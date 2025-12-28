--除非你清楚自己在做什么，否则请勿复制此本地化文件的结构
--或许可以去试试查看其他模组的？

--非常感谢 @一人之下、@:)、@一朵小花 等人对汉化错误的指正和修改！

--特别注意：TEOcean汉化模组对这个文件做了一些适配改动，这些改动不会给原来的逻辑造成任何影响，只有当TEOcean模组存在时才会运行适配的代码

local localization = {}
local localization_files = {}

local teocean_mod = SMODS.find_mod("teocean")[1]

if teocean_mod then
	-- TEOcean内的相对路径
	localization = {
		translator = {
			"Alophrine",
		},
	}
	local base_rel_path = "impl/mods/JoyousSpring/localization/zh_CN"
	local base_abs_path = teocean_mod.path .. base_rel_path

	-- 1. 加载根目录下文件
	local loc_src = NFS.getDirectoryItems(base_abs_path)
	for _, file in ipairs(loc_src) do
		-- 确保是文件且不是目录（NFS.getDirectoryItems返回文件名）
		local abs_file_path = base_abs_path .. "/" .. file
		if NFS.getInfo(abs_file_path).type ~= "directory" then
			-- 使用 SMODS.load_file 加载，需传入相对于 teocean 的路径
			local file_rel_path = base_rel_path .. "/" .. file
			local loaded_chunk = assert(SMODS.load_file(file_rel_path, "teocean"))
			localization_files[#localization_files + 1] = loaded_chunk()
		end
	end

	-- 2. 加载 archetypes 子目录下文件
	local archetypes_rel_path = base_rel_path .. "/archetypes"
	local archetypes_abs_path = base_abs_path .. "/archetypes"

	if NFS.getInfo(archetypes_abs_path) then
		local loc_archetypes_src = NFS.getDirectoryItems(archetypes_abs_path)
		for _, file in ipairs(loc_archetypes_src) do
			local file_rel_path = archetypes_rel_path .. "/" .. file
			local loaded_chunk = assert(SMODS.load_file(file_rel_path, "teocean"))
			localization_files[#localization_files + 1] = loaded_chunk()
		end
	end
else
	local loc_src = NFS.getDirectoryItems(SMODS.find_mod("JoyousSpring")[1].path .. "localization/zh_CN")
	for _, file in ipairs(loc_src) do
		if NFS.getInfo(SMODS.find_mod("JoyousSpring")[1].path .. "localization/zh_CN/" .. file).type ~= "directory" then
			localization_files[#localization_files + 1] = assert(SMODS.load_file("localization/zh_CN/" .. file,
				"JoyousSpring"))()
		end
	end

	local loc_archetypes_src = NFS.getDirectoryItems(SMODS.find_mod("JoyousSpring")[1].path ..
		"localization/zh_CN/archetypes")
	for _, file in ipairs(loc_archetypes_src) do
		localization_files[#localization_files + 1] = assert(SMODS.load_file("localization/zh_CN/archetypes/" .. file,
			"JoyousSpring"))()
	end
end

for _, file in ipairs(localization_files) do
	for _, loc_type in ipairs({ "descriptions", "misc" }) do
		if file[loc_type] then
			if not localization[loc_type] then
				localization[loc_type] = {}
			end
			for desc_key, desc_type_table in pairs(file[loc_type]) do
				if not localization[loc_type][desc_key] then
					localization[loc_type][desc_key] = {}
				end
				for obj_key, obj_desc in pairs(desc_type_table) do
					localization[loc_type][desc_key][obj_key] = obj_desc
				end
			end
		end
	end
end

return localization
