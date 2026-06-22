-- AI Provider Adapter
-- 统一处理 OpenAI / Claude / Gemini 三种接口格式

local json = JSON or require("json")

local function trim(s)
    if type(s) ~= "string" then return "" end
    return s:match("^%s*(.-)%s*$") or ""
end

local function preview_text(text, max_len)
    if type(text) ~= "string" then
        text = tostring(text or "")
    end
    max_len = tonumber(max_len) or 1000
    if #text <= max_len then
        return text
    end
    return text:sub(1, max_len) .. "...[truncated " .. tostring(#text - max_len) .. " chars]"
end

local function is_non_empty_string(v)
    return type(v) == "string" and trim(v) ~= ""
end

local function ends_with(str, suffix)
    if type(str) ~= "string" or type(suffix) ~= "string" then return false end
    return str:sub(-#suffix) == suffix
end

local function normalize_openai_url(url)
    local clean = trim(url)
    if clean == "" then return nil end
    local lower = clean:lower()

    if lower:find("/chat/completions", 1, true) then
        return clean
    end

    clean = clean:gsub("/+$", "")
    if clean:lower():match("/v%d+$") then
        return clean .. "/chat/completions"
    end
    return clean .. "/v1/chat/completions"
end

local function normalize_claude_url(url)
    local clean = trim(url)
    if clean == "" then return nil end
    local lower = clean:lower()

    if lower:find("/v1/messages", 1, true) then
        return clean
    end

    clean = clean:gsub("/+$", "")
    if clean:lower():match("/v1$") then
        return clean .. "/messages"
    end
    return clean .. "/v1/messages"
end

local function normalize_gemini_url(url, model)
    local clean = trim(url)
    if clean == "" then return nil, "Gemini API URL is empty" end
    local lower = clean:lower()

    if lower:find(":generatecontent", 1, true) then
        return clean
    end

    clean = clean:gsub("/+$", "")
    lower = clean:lower()

    if lower:find("/models/", 1, true) then
        return clean .. ":generateContent"
    end

    if not is_non_empty_string(model) then
        return nil, "Gemini endpoint requires a model when URL is a base path"
    end

    if lower:find("/v1beta", 1, true) or lower:find("/v1", 1, true) then
        return clean .. "/models/" .. model .. ":generateContent"
    end

    return clean .. "/v1beta/models/" .. model .. ":generateContent"
end

local function normalize_provider(provider)
    local p = trim(provider):lower()
    if p == "anthropic" then p = "claude" end
    if p == "google" then p = "gemini" end
    if p == "openai" or p == "claude" or p == "gemini" then
        return p
    end
    return "auto"
end

local function detect_provider_by_url(api_url)
    local url = trim(api_url):lower()
    if url == "" then return "openai" end

    if url:find(":generatecontent", 1, true)
        or url:find("generativelanguage", 1, true)
        or url:find("gemini", 1, true) then
        return "gemini"
    end

    if url:find("/v1/messages", 1, true)
        or url:find("anthropic", 1, true)
        or url:find("claude", 1, true) then
        return "claude"
    end

    return "openai"
end

local function resolve_provider(cfg)
    local explicit = normalize_provider((cfg and cfg.api_format) or "auto")
    if explicit ~= "auto" then
        return explicit
    end
    return detect_provider_by_url((cfg and cfg.api_url) or "")
end

local function extract_openai_message_content(content)
    if type(content) == "string" then
        return content
    end
    if type(content) ~= "table" then return nil end

    local pieces = {}
    for i = 1, #content do
        local item = content[i]
        if type(item) == "table" then
            if type(item.text) == "string" and item.text ~= "" then
                table.insert(pieces, item.text)
            elseif type(item.content) == "string" and item.content ~= "" then
                table.insert(pieces, item.content)
            end
        end
    end
    if #pieces > 0 then
        return table.concat(pieces, "\n")
    end
    return nil
end

local function extract_error_message(data, status_code, raw_body)
    if type(data) == "table" then
        if type(data.error) == "string" and data.error ~= "" then
            return data.error
        end
        if type(data.error) == "table" then
            if type(data.error.message) == "string" and data.error.message ~= "" then
                return data.error.message
            end
            if type(data.error.type) == "string" and data.error.type ~= "" then
                return data.error.type
            end
        end
        if type(data.message) == "string" and data.message ~= "" then
            return data.message
        end
    end
    if type(raw_body) == "string" and raw_body ~= "" then
        return ("HTTP %s: %s"):format(tostring(status_code), raw_body)
    end
    return "Unknown API error"
end

local function collect_body_chunks(value, parts)
    if type(value) == "string" then
        parts[#parts + 1] = value
        return true
    end
    if type(value) == "number" or type(value) == "boolean" then
        parts[#parts + 1] = tostring(value)
        return true
    end
    if type(value) ~= "table" then
        return false
    end
    if #value == 0 then
        return false
    end

    for i = 1, #value do
        if not collect_body_chunks(value[i], parts) then
            return false
        end
    end
    return true
end

local function normalize_response_body(raw_body)
    if type(raw_body) == "string" then
        return raw_body, "string"
    end
    if raw_body == nil then
        return "", "nil"
    end
    if type(raw_body) == "table" then
        if raw_body.body ~= nil then
            local body_text, body_source = normalize_response_body(raw_body.body)
            if body_text ~= "" then
                return body_text, "table.body." .. tostring(body_source)
            end
        end

        for _, key in ipairs({ "data", "text", "response", "content" }) do
            if raw_body[key] ~= nil then
                local field_text, field_source = normalize_response_body(raw_body[key])
                if field_text ~= "" then
                    return field_text, "table." .. key .. "." .. tostring(field_source)
                end
            end
        end

        local parts = {}
        if collect_body_chunks(raw_body, parts) and #parts > 0 then
            return table.concat(parts), "table.sequence"
        end

        local ok, encoded = pcall(json.encode, raw_body)
        if ok and type(encoded) == "string" and encoded ~= "" then
            return encoded, "table.json"
        end
    end

    return tostring(raw_body or ""), type(raw_body)
end

function TEO_detect_ai_provider(api_url, api_format)
    local explicit = normalize_provider(api_format or "auto")
    if explicit ~= "auto" then
        return explicit
    end
    return detect_provider_by_url(api_url or "")
end

function TEO_has_required_ai_config(cfg)
    return cfg
        and is_non_empty_string(cfg.api_url)
        and is_non_empty_string(cfg.api_model)
        and is_non_empty_string(cfg.api_key)
end

function TEO_build_ai_request(cfg, system_prompt, user_text)
    cfg = cfg or {}
    local api_url = trim(cfg.api_url)
    local api_model = trim(cfg.api_model)
    local api_key = trim(cfg.api_key)

    if api_url == "" then
        return nil, "API URL is required"
    end
    if api_model == "" then
        return nil, "Model is required"
    end
    if api_key == "" then
        return nil, "API Key is required"
    end

    local provider = resolve_provider(cfg)
    local endpoint
    local endpoint_err
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local body = {}
    local prompt = trim(system_prompt)
    local user = tostring(user_text or "")

    if provider == "openai" then
        endpoint = normalize_openai_url(api_url)
        headers["Authorization"] = "Bearer " .. api_key
        body = {
            model = api_model,
            messages = {
                { role = "system", content = prompt },
                { role = "user", content = user }
            },
            stream = false
        }
    elseif provider == "claude" then
        endpoint = normalize_claude_url(api_url)
        headers["x-api-key"] = api_key
        headers["anthropic-version"] = trim(cfg.anthropic_version or "") ~= "" and trim(cfg.anthropic_version) or
            "2023-06-01"
        body = {
            model = api_model,
            max_tokens = tonumber(cfg.max_output_tokens) or 1024,
            system = prompt,
            messages = {
                { role = "user", content = user }
            }
        }
    elseif provider == "gemini" then
        endpoint, endpoint_err = normalize_gemini_url(api_url, api_model)
        if not endpoint then
            return nil, endpoint_err
        end
        headers["x-goog-api-key"] = api_key
        body = {
            systemInstruction = {
                parts = {
                    { text = prompt }
                }
            },
            contents = {
                {
                    role = "user",
                    parts = {
                        { text = user }
                    }
                }
            }
        }
        local generation = {}
        if tonumber(cfg.max_output_tokens) then
            generation.maxOutputTokens = math.floor(tonumber(cfg.max_output_tokens))
        end
        if tonumber(cfg.temperature) then
            generation.temperature = tonumber(cfg.temperature)
        end
        if next(generation) then
            body.generationConfig = generation
        end
    else
        return nil, "Unsupported API format: " .. tostring(provider)
    end

    if not endpoint then
        return nil, endpoint_err or "Invalid API endpoint"
    end

    return {
        provider = provider,
        url = endpoint,
        headers = headers,
        body = body
    }, nil
end

function TEO_parse_ai_response(provider, status_code, raw_body)
    local body_text, body_source = normalize_response_body(raw_body)
    if body_text:byte(1) == 239 and body_text:byte(2) == 187 and body_text:byte(3) == 191 then
        body_text = body_text:sub(4)
    end

    local ok, data = pcall(json.decode, body_text)
    if not ok or type(data) ~= "table" then
        return false, nil, "Invalid JSON response (" .. tostring(body_source) .. ")", {
            raw_body_type = type(raw_body),
            normalized_body_source = body_source,
            normalized_body_preview = preview_text(body_text, 4000),
            decode_error = ok and "decoded non-table JSON value" or tostring(data),
        }
    end

    if tonumber(status_code) ~= 200 then
        return false, nil, extract_error_message(data, status_code, body_text), data
    end

    if provider == "openai" then
        local choice = data.choices and data.choices[1]
        local content = choice and choice.message and extract_openai_message_content(choice.message.content)
        if type(content) == "string" and content ~= "" then
            return true, content, nil, data
        end
        return false, nil, "OpenAI response missing choices[1].message.content", data
    end

    if provider == "claude" then
        local pieces = {}
        if type(data.content) == "table" then
            for i = 1, #data.content do
                local item = data.content[i]
                if type(item) == "table" and item.type == "text" and type(item.text) == "string" and item.text ~= "" then
                    table.insert(pieces, item.text)
                end
            end
        end
        if #pieces > 0 then
            return true, table.concat(pieces, "\n"), nil, data
        end
        return false, nil, "Claude response missing content text blocks", data
    end

    if provider == "gemini" then
        local candidate = data.candidates and data.candidates[1]
        local parts = candidate and candidate.content and candidate.content.parts
        local pieces = {}
        if type(parts) == "table" then
            for i = 1, #parts do
                local p = parts[i]
                if type(p) == "table" and type(p.text) == "string" and p.text ~= "" then
                    table.insert(pieces, p.text)
                end
            end
        end
        if #pieces > 0 then
            return true, table.concat(pieces, "\n"), nil, data
        end
        return false, nil, "Gemini response missing candidates[1].content.parts text", data
    end

    return false, nil, "Unknown provider while parsing response: " .. tostring(provider), data
end

