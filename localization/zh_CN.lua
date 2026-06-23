return {
    descriptions = {
        Other = {
            teo_show_original = {
                name = "显示原版翻译",
                text = {
                    "在卡牌详细描述中显示",
                    "原来mod的本地化",
                    "用于对照翻译质量"
                }
            },
            teo_show_original_blind = {
                name = "显示盲注原版翻译",
                text = {
                    "在盲注挑战中显示",
                    "原来mod的中文翻译",
                    "用于对照翻译质量"
                }
            },
            teo_runtime_override = {
                name = "在内存中动态翻译",
                text = {
                    "在内存中动态应用翻译",
                    "无需重启游戏或返回主菜单",
                    "不会修改磁盘上的文件",
                    "关闭时：写入文件（磁盘模式）"
                }
            },
            teo_enable_ai = {
                name = "启动 AI 翻译",
                text = {
                    "使用你配置的 AI 接口自动翻译",
                    "遇到未翻译内容时自动调用",
                    "需要先配置 API URL、模型和 API Key"
                }
            },
            teo_disable_edge_sidebar = {
                name = "关闭侧边栏",
                text = {
                    "勾选可以彻底关闭侧边栏"
                }
            },
            teo_enable_debug = {
                name = "启用DEBUG模式",
                text = {
                    "启动DEBUG模式会在控制台",
                    "看到更多日志"
                }
            },
            teo_ai_cache_manager = {
                name = "AI缓存管理",
                text = {
                    "查看和管理AI翻译缓存",
                    "可以清除单个或全部Mod的AI缓存"
                }
            }
        }
    },
    misc = {
        dictionary = {
            teo_reload = "手动重载",
            teo_adapted_mods = "适配的模组",
            teo_adapted_mods2 = "已适配的模组",
            teo_adapted_mods3 = "人工翻译的模组列表",
            b_t_by = "译者：",
            teo_show_original = "显示原版翻译",
            teo_show_original_blind = "显示盲注原版翻译",
            teo_original_tooltip = "原版翻译",
            teo_actions = "操作",
            teo_optional_config = "可选配置",
            teo_runtime_override = "在内存中动态翻译",
            teo_enable_ai = "启用AI翻译",
            teo_disable_edge_sidebar = "关闭侧边栏",
            teo_set_api_key = "设置AI翻译",
            teo_api_key_popup_title = "请输入 AI 接口配置",
            teo_api_settings_popup_title = "AI 翻译接口配置",
            teo_api_url_label = "API URL",
            teo_api_url_placeholder = "https://api.example.com/v1/chat/completions",
            teo_api_model_label = "模型名称",
            teo_api_model_placeholder = "gpt-5.3-codex / claude-4-5-sonnet / gemini-3.1-flash",
            teo_api_key_label = "API Key",
            teo_api_key_placeholder = "sk-...",
            teo_b_set = "确认",
            teo_b_cancel = "取消",
            teo_b_clear = "清空内容",
            teo_b_paste = "粘贴",
            teo_b_get_key = "获取API文档",
            teo_enable_debug = "启用DEBUG模式",
            teo_ai_cache_manager = "AI缓存管理",
            teo_no_ai_cache = "暂无AI缓存",
            teo_clear_cache = "清除",
            teo_clear_all_cache = "清除全部AI缓存",
            teo_b_test_api = "检测可用性",
            teo_test_translation_title = "翻译测试",
            teo_test_input_label = "输入要翻译的文本：",
            teo_test_input_placeholder = "输入英文文本...",
            teo_b_translate = "翻译",
            teo_test_result_label = "翻译结果：",
            teo_test_result_placeholder = "等待翻译...",
            teo_test_translating = "正在翻译...",
            teo_test_error_empty = "请输入要翻译的文本",
            teo_test_error_no_key = "请先配置 API Key",
            teo_test_error_missing_config = "请先配置 API URL、模型名称和 API Key",
            teo_test_error_prefix = "错误: ",
        },
    },
}
