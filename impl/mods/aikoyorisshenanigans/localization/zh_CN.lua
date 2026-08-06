local poker_hand_desc = {}
local poker_hands_name = {}
for i = 3, 45 do
    local key = "akyrs_" .. tostring(i) .. "-letter Word"
    poker_hand_desc[key] = {
        '组成一个有效的' .. i .. '个字母英文单词',
        '不能有多余字母',
    }
    poker_hands_name[key] = i .. "个字母英文单词"
end

local word_letter = {
    "Apple", "Bee", "Cat", "Dog", "Earth", "Fire", "Ghost", "Hat", "Ice", "Jar",
    "Kite", "Lemon", "Mushroom", "Night", "Onion", "Pie", "Quill", "Rat", "Spoon", "Tea",
    "Umbrella", "Vase", "Water", "Xylophone", "Yarn", "Zoom", "#"
}
Alphabet = {}
for i = 1, #word_letter do
    local w = word_letter[i]

    if w == "#" then
        Alphabet["c_akyrs_alphabet_wild"] = {
            name = "？万能占位符",
            text = {
                "将最多 #2# 张选择的字母牌",
                "转换为 {C:red}万能字母 (#1#){}"
            },
        }
    else
        local first = w:sub(1, 1)
        local lower = first:lower()
        local upper = first:upper()

        Alphabet["c_akyrs_alphabet_" .. lower] = {
            name = upper .. " for " .. w,
            text = {
                "将所有选择的字母牌",
                "转换为 {C:red}#1#{}"
            },
        }
    end
end

poker_hands_name["akyrs_Word Hand"] = "单词牌型"
poker_hand_desc["akyrs_Word Hand"] = { '打出有效的字典单词' }

poker_hands_name["akyrs_expression"] = "表达式"
poker_hand_desc["akyrs_expression"] = { '创建有效的数学表达式' }

poker_hands_name["akyrs_modification"] = "修改"
poker_hand_desc["akyrs_modification"] = { '修改当前筹码值' }

poker_hands_name["akyrs_assignment"] = "赋值"
poker_hand_desc["akyrs_assignment"] = { '为变量赋值' }

poker_hands_name["akyrs_tripair"] = "三连对"
poker_hand_desc["akyrs_tripair"] = { '三组不同点数的对子' }

poker_hands_name["akyrs_triplush"] = "三连对同花"
poker_hand_desc["akyrs_triplush"] = { '三组不同点数的对子', '并且包含同花' }

poker_hands_name["akyrs_twintriple"] = "双三条"
poker_hand_desc["akyrs_twintriple"] = { '两组三条' }

poker_hands_name["akyrs_twinflupple"] = "同花双三条"
poker_hand_desc["akyrs_twinflupple"] = { '同时包含同花的双三条' }

poker_hands_name["akyrs_twinflush"] = "双重同花"
poker_hand_desc["akyrs_twinflush"] = { '两组同花' }

poker_hands_name["akyrs_flushbung"] = "双倍同花"
poker_hand_desc["akyrs_flushbung"] = { '规模加倍的同花' }

poker_hands_name["akyrs_twinstraight"] = "双顺子"
poker_hand_desc["akyrs_twinstraight"] = { '两组顺子', '点数不得重复' }

poker_hands_name["akyrs_direstraight"] = "超长顺子"
poker_hand_desc["akyrs_direstraight"] = { '长度至少加倍的顺子' }

poker_hands_name["akyrs_twinstraightflush"] = "同花双顺子"
poker_hand_desc["akyrs_twinstraightflush"] = { '同时包含同花的两组顺子', '点数不得重复' }

local localization = {
    translator = {
        "mleaf233",
    },
    descriptions = {
        Alphabet = Alphabet,
        Back = {
            b_akyrs_letter_deck = {
                name = "字母牌组",
                text = {
                    "仅包含字母的牌组",
                    "字母给予{C:mult}倍率{}",
                    "基础盲注要求分数{C:red}X#1#{}",
                    "{C:red}+#2#{}次弃牌",
                    "{C:attention}+#3#{}手牌上限",
                },
            },
            b_akyrs_math_deck = {
                name = "数学牌组",
                text = {
                    "组成数学表达式",
                    "得分需在盲注要求的",
                    "{C:red,f:6}±{C:red}#1#%{}范围内",
                    "每提升一次{C:attention}底注{}",
                    "获得{C:akyrs_playable}+#3#{}次可选机会",
                },
            },
            b_akyrs_hardcore_challenges = {
                name = "硬核挑战牌组",
                text = {
                    "未开发",
                },
            },
            b_akyrs_scuffed_misprint = {
                name = "瑕疵错印牌组",
                text = {
                    "大多数卡牌的数值",
                    "被{C:attention}随机化{}",
                    "{C:inactive}(从X#1#到X#2#)",
                    "不要为那个人担心",
                },
            },
            b_akyrs_freedom = {
                name = "自由牌组",
                text = {
                    "你可以拖拽卡牌",
                    "放置到任意位置",
                },
            },
            b_akyrs_ultimate_freedom = {
                name = "终极自由牌组",
                text = {
                    "你可以拖拽{E:1,C:attention}任何{}卡牌",
                    "放置到任意位置",
                },
            },
            b_akyrs_split_deck = {
                name = "分裂牌组",
                text = {
                    "开局时所有卡牌",
                    "{C:attention}一分为二{}",
                    "{C:red}+#1#{}次弃牌",
                },
            },
            b_akyrs_ranking_deck = {
                name = "点数牌组",
                text = {
                    "开局时{C:attention}没有花色{}",
                    "盲注要求分数{C:red}X#1#{}",
                },
            },
            b_akyrs_suitable_deck = {
                name = "花色牌组",
                text = {
                    "开局时{C:attention}没有点数{}",
                    "盲注要求分数{C:red}X#1#{}",
                },
            },
            b_akyrs_inversion_deck = {
                name = "反转牌组",
                text = {
                    "卡牌选择被{C:attention}反转{}",
                },
            },
            b_akyrs_down_deck = {
                name = "暗牌牌组",
                text = {
                    "{C:attention}+#1#{}个小丑牌槽位",
                    "所有小丑牌在购买前",
                    "都被{C:attention}翻转背面朝下{}",
                },
            },
            b_akyrs_cry_misprint_ultima = {
                name = "终极错印牌组",
                text = {
                    "卡牌和牌型的数值",
                    "被{C:attention}随机化{}",
                    "{C:inactive}(从X#1#到X#2#)",
                    "真正的挑战是别让游戏崩溃",
                },
            },
            b_akyrs_mega_letter_deck = {
                name = "巨型字母牌组",
                text = {
                    "字母牌组变体",
                    "但{C:blue}+#3#{}手牌上限",
                    "你只有{C:red}1次出牌{}机会",
                    "基础盲注要求分数{C:red}X#1#{}",
                },
            },
            b_akyrs_developer_deck = {
                name = "开发者牌组",
                text = {
                    "{C:red,s:1.5,E:akyrs_shrivel}制作中{}",
                },
            },
            b_akyrs_prism_deck = {
                name = "棱镜牌组",
                text = {
                    "以{X:dark_edition,C:white}#1#{}点生命开局",
                    "惩罚{C:red,E:1}更加严厉{}",
                    "生命{C:red}不会{}恢复",
                    "{C:dark_edition}+#2#{}个小丑牌槽位",
                    "{C:dark_edition}+#3#{}个消耗牌槽位",
                },
            },
            b_akyrs_kaleidoscopic_deck = {
                name = "万花筒牌组",
                text = {
                    "{C:red,s:1.5,E:akyrs_shrivel}制作中{}",
                },
            },
            b_akyrs_sheared_deck = {
                name = "剪切牌组",
                text = {
                    "{C:red,s:1.5,E:akyrs_shrivel}制作中{}",
                },
            },
            b_akyrs_vision_deck = {
                name = "幻视牌组",
                text = {
                    "{C:red,s:1.5,E:akyrs_shrivel}制作中{}",
                },
            },
            b_akyrs_animosity_deck = {
                name = "敌意牌组",
                text = {
                    "{C:red,s:1.5,E:akyrs_shrivel}制作中{}",
                },
            },
            b_akyrs_weaver_deck = {
                name = "织者牌组",
                text = {
                    "{C:red,s:1.5,E:akyrs_shrivel}制作中{}",
                },
            },
            b_akyrs_puppet_deck = {
                name = "傀儡牌组",
                text = {
                    "{C:red,s:1.5,E:akyrs_shrivel}制作中{}",
                },
            },
            b_akyrs_shining_deck = {
                name = "闪耀牌组",
                text = {
                    "{C:red,s:1.5,E:akyrs_shrivel}制作中{}",
                },
            },
            b_akyrs_dotted_deck = {
                name = "点阵牌组",
                text = {
                    "{C:blue}出牌{}与{C:red}弃牌{}",
                    "会{C:attention}相互交换{}",
                },
            },
            b_akyrs_flora_deck = {
                name = "花神牌组",
                text = {
                    "{C:red,s:1.5,E:akyrs_shrivel}制作中{}",
                },
            },
            b_akyrs_discord_deck = {
                name = "纷争牌组",
                text = {
                    "{C:red,s:1.5,E:akyrs_shrivel}制作中{}",
                },
            },
            b_akyrs_nitro_deck = {
                name = "硝基牌组",
                text = {
                    "{C:red,s:1.5,E:akyrs_shrivel}制作中{}",
                },
            },
            b_akyrs_judge_deck = {
                name = "裁决牌组",
                text = {
                    "以{X:green,C:white}#1#{}点生命开局",
                    "每回合{X:green,C:white}+#2#{}点生命",
                    "{C:dark_edition}+#3#{}个小丑牌槽位",
                },
            },
        },
        Blind = {
            bl_akyrs_the_thought = {
                name = "思考",
                text = {
                    "解开5字母谜题才能获胜",
                },
            },
            bl_akyrs_the_libre = {
                name = "自由者",
                text = {
                    "禁用此Boss",
                    "会将盲注要求分数设为#1#",
                },
            },
            bl_akyrs_the_picker = {
                name = "挑剔者",
                text = {
                    "当你改变给定的牌选择时",
                    "盲注分数要求X#2#",
                },
            },
            bl_akyrs_the_height = {
                name = "高度",
                text = {
                    "盲注分数要求变为",
                    "你在非最终出牌回合的得分X#1#",
                },
            },
            bl_akyrs_the_expiry = {
                name = "过期",
                text = {
                    "所有消耗牌",
                    "被永久削弱",
                },
            },
            bl_akyrs_the_nature = {
                name = "自然",
                text = {
                    "每张人头牌（留在手牌中和打出的）",
                    "给予X#1#倍率",
                },
            },
            bl_akyrs_the_key = {
                name = "关键",
                text = {
                    "打出的牌有",
                    "#1#/#2#几率被永久选中",
                },
            },
            bl_akyrs_the_alignment = {
                name = "对齐",
                text = {
                    "第一张和最后一张打出的牌",
                    "不会得分",
                },
            },
            bl_akyrs_the_duality = {
                name = "二元",
                text = {
                    "第一张和最后一张打出的牌",
                    "被削弱",
                },
            },
            bl_akyrs_the_collapse = {
                name = "崩塌",
                text = {
                    "本回合中资金无法改变",
                },
            },
            bl_akyrs_the_bonsai = {
                name = "盆栽",
                text = {
                    "人头牌有#1#/#2#几率",
                    "不计分",
                },
            },
            bl_akyrs_the_base = {
                name = "基底",
                text = {
                    "无法重新触发",
                },
            },
            bl_akyrs_final_periwinkle_pinecone = {
                name = "长春蓝松果",
                text = {
                    "出牌后洗混剩余游戏牌",
                    "并抽到手牌中",
                },
            },
            bl_akyrs_final_razzle_raindrop = {
                name = "炫彩雨滴",
                text = {
                    "每打出一种不重复的花色",
                    "就弃掉对应数量的手牌",
                },
            },
            bl_akyrs_final_velvet_vapour = {
                name = "绒雾之息",
                text = {
                    "每张与第一张打出的牌",
                    "点数相同的牌",
                    "有#1#/#2#几率被弃掉",
                },
            },
            bl_akyrs_final_chamomile_cloud = {
                name = "洋甘菊云",
                text = {
                    "每次抽牌弃掉一种",
                    "随机花色",
                },
            },
            bl_akyrs_final_salient_stream = {
                name = "凸显之流",
                text = {
                    "必须在出牌",
                    "和弃牌之间交替进行",
                },
            },
            bl_akyrs_final_luminous_lemonade = {
                name = "发光柠檬水",
                text = {
                    "非最后一次出牌",
                    "不会得分",
                },
            },
            bl_akyrs_final_glorious_glaive = {
                name = "荣耀战戟",
                text = {
                    "每打出一张牌",
                    "盲注分数要求X#1#",
                },
            },
            bl_akyrs_final_lilac_lasso = {
                name = "丁香套索",
                text = {
                    "每次出牌只有随机#1#张小丑牌生效",
                    "其余小丑牌均被削弱",
                },
            },
            bl_akyrs_forgotten_weights_of_the_past = {
                name = "往昔重负",
                text = {
                    "每有一张牌计分",
                    "底注X#1#",
                },
            },
            bl_akyrs_forgotten_prospects_of_the_future = {
                name = "未来前景",
                text = {
                    "每有一张牌留在手牌中",
                    "底注+#1#",
                },
            },
            bl_akyrs_forgotten_uncertainties_of_life = {
                name = "人生无常",
                text = {
                    "出牌后永久",
                    "-#1#手牌上限",
                },
            },
            bl_akyrs_forgotten_inevitability_of_death = {
                name = "死亡必然",
                text = {
                    "回合结束时损失资金",
                    "数值为最终得分除以盲注要求分数",
                },
            },
            bl_akyrs_expert_confrontation = {
                name = "对峙",
                text = {
                    "出牌必须包含人头牌",
                },
            },
            bl_akyrs_expert_fluctuation = {
                name = "波动",
                text = {
                    "出牌前随机将分数乘以",
                    "#1#~#2#之间的数值",
                },
            },
            bl_akyrs_expert_straightforwardness = {
                name = "直率",
                text = {
                    "所有出牌起始拥有",
                    "#1#%基础筹码和#2#%基础倍率",
                },
            },
            bl_akyrs_expert_entanglement = {
                name = "纠缠",
                text = {
                    "除一种花色外",
                    "所有其他花色的牌抽取时背面朝上",
                },
            },
            bl_akyrs_expert_manuscript = {
                name = "手稿",
                text = {
                    "每回合损失资金等于",
                    "所出牌型的基础倍率",
                },
            },
            bl_akyrs_expert_inflation = {
                name = "膨胀",
                text = {
                    "极其巨大的盲注",
                },
            },
            bl_akyrs_the_choice = {
                name = "抉择",
                text = {
                    "打出的单词必须包含'#1#'",
                },
            },
            bl_akyrs_the_reject = {
                name = "拒绝",
                text = {
                    "打出的单词不能包含'#1#'",
                },
            },
            bl_akyrs_the_redo = {
                name = "重做",
                text = {
                    "打出的单词不能包含",
                    "本盲注内上次打出单词中的字母",
                },
            },
            bl_akyrs_the_reverse = {
                name = "逆转",
                text = {
                    "单词必须以倒序打出",
                },
            },
            bl_akyrs_master_faraway_island = {
                name = "远方之岛",
                text = {
                    "出牌必须至少包含",
                    "一张没有花色或点数的牌",
                },
            },
            bl_akyrs_master_plywood_forest = {
                name = "人造森林",
                text = {
                    "所有留在手牌中的牌",
                    "在出牌计分后会被摧毁",
                },
            },
            bl_akyrs_master_golden_jade = {
                name = "黄金翡翠",
                text = {
                    "每计分一张牌",
                    "资金X#1#",
                },
            },
            bl_akyrs_master_milk_crown_on_sonnetica = {
                name = "牛奶王冠",
                text = {
                    "当一张人头牌得分时",
                    "盲注要求分数X#1#",
                },
            },
            bl_akyrs_master_bug = {
                name = "漏洞",
                text = {
                    "出牌得分后",
                    "随机一张小丑牌被摧毁",
                },
            },
            bl_akyrs_the_bomb = {
                name = "炸弹",
                text = {
                    "拆除炸弹",
                },
            },
            bl_akyrs_the_stomata = {
                name = "气孔",
                text = {
                    "每有一张人头牌被计分",
                    "损失{C:money}$1",
                },
            },
            bl_akyrs_the_rhizome = {
                name = "根茎",
                text = {
                    "当重复打出",
                    "已出过的牌型时",
                    "盲注要求分数X#1#",
                },
            },
            bl_akyrs_the_shrink = {
                name = "收缩",
                text = {
                    "每打出一种",
                    "不重复的牌型",
                    "盲注要求分数X#1#",
                },
            },
            bl_akyrs_the_harmonic = {
                name = "谐波",
                text = {
                    "每次抽牌后",
                    "随机选择一张牌弃掉",
                },
            },
            bl_akyrs_the_sinusoidal = {
                name = "正弦",
                text = {
                    "最后抽到的2张牌",
                    "以背面朝上方式抽取",
                },
            },
            bl_akyrs_the_saw = {
                name = "锯子",
                text = {
                    "第一张计分牌被摧毁",
                },
            },
            bl_akyrs_the_selfish = {
                name = "自私",
                text = {
                    "有#1#/#2#几率",
                    "元音字母被削弱",
                },
            },
            bl_akyrs_the_polite = {
                name = "礼貌",
                text = {
                    "元音字母不会得分",
                },
            },
            bl_akyrs_the_bent = {
                name = "弯曲",
                text = {
                    "打出#1#",
                    "#2#次",
                },
            },
            bl_akyrs_ultima_lost_umbrella = {
                name = "遗失之伞",
                text = {
                    "所有小丑牌被削弱直到",
                    "摧毁#1#张游戏牌",
                },
            },
        },
        DescriptionDummy = {
            -- 配置
            dd_akyrs_wildcard_behaviour_1 = {
                name = "万能牌行为",
                text = {
                    "{C:attention}自动",
                    "自动为未设置字母的万能牌",
                    "寻找一个字母（默认）",
                },
            },
            dd_akyrs_wildcard_behaviour_2 = {
                name = "万能牌行为",
                text = {
                    "{C:attention}强制设置",
                    "如果选择了未设置的万能牌",
                    "出牌按钮将被禁用",
                },
            },
            dd_akyrs_wildcard_behaviour_3 = {
                name = "万能牌行为",
                text = {
                    "{C:attention}始终手动",
                    "万能牌默认没有分配字母",
                    "打出时不会尝试寻找字母（可能有助于性能）",
                },
            },
            dd_akyrs_wildcard_behaviour_4 = {
                name = "万能牌行为",
                text = {
                    "{C:attention}自动设置",
                    "自动为万能牌寻找字母",
                    "如果目标未设置则自动设置字母",
                },
            },
            dd_akyrs_balance_settings = {
                name = "平衡性设置",
                text = {
                    "{C:green,E:2}适中",
                    "平衡性贴近原版",
                    "{C:red,E:1}荒诞{C:inactive}（需要Talisman）",
                    "更大的数字 更疯狂的效果",
                    "更严重的后果",
                },
            },
            dd_akyrs_card_preview_tooltip = {
                name = "卡牌预览提示",
                text = {
                    "一些卡牌有一个小的“预览”窗口",
                    "用于演示卡牌的效果",
                    "如果悬停卡牌后遇到游戏崩溃",
                    "关闭此选项可能有所帮助",
                },
            },
            dd_akyrs_crt_shader_toggle = {
                name = "CRT着色器",
                text = {
                    "通常 游戏{C:attention}总是{}渲染CRT着色器",
                    "即使你在设置中将其调为0 这也是为什么一切看起来饱和度都很高",
                    "关闭此选项意味着所有画面饱和度会降低{C:inactive}（如果你喜欢褪色的外观）",
                },
            },
            dd_akyrs_full_dictionary = {
                name = "完整词典",
                text = {
                    "使用{C:attention,E:1}50万{}词条的完整词典 而非5万词条",
                    "经过大量测试 完整词典{C:attention}可能{}在打出长单词时",
                    "造成明显的卡顿 但你会拥有更多单词选择",
                    "精简词典意味着许多{C:attention}复数形式{}",
                    "将不可用 但不太可能卡顿",
                    "这也会影响{C:attention}炸弹{}Boss盲注的提示词选择",
                },
            },
            dd_akyrs_toggle_colourblind_ui = {
                name = "高对比度界面",
                text = {
                    "部分界面对某些玩家而言可能难以辨认",
                    "目前会将部分绿色与黄色元素改为橙色与蓝色",
                },
            },
            dd_akyrs_experimental_feature = {
                name = "实验性功能",
                text = {
                    "{s:1.5}前方未知且危险！",
                    "{s:1.4}如果你需要思考是否启用，那就{s:1.4,E:akyrs_shrivel,C:red}不要启用",
                    "启用模组的实验性功能",
                    "这些功能可能是损坏的或完全无法使用的",
                    "或{C:red}彻底损坏你的存档{}",
                    "{C:inactive}（可能性很小 但确实可能发生）",
                    "这主要是供开发人员使用，以便其能够发布模组的错误修复",
                    "同时开发新内容",
                    "开发者不会阻止你启用它，但毕竟它还未完成（后果自负）",
                },
            },
            -- 工具提示
            dd_akyrs_maxwell_example = {
                name = "示例",
                text = {
                    "{C:inactive,s:0.8}例如 拼出{C:spectral,s:0.8}'Spectral'",
                    "{C:inactive,s:0.8}会给予你一张{C:spectral,s:0.8}幻灵{C:inactive,s:0.8}牌",
                },
            },
            dd_akyrs_yona_yona_ex = {
                name = "视觉示例",
                text = {
                },
            },
            dd_akyrs_2fa_example = {
                name = "示例出牌",
                text = {
                },
            },
            dd_akyrs_credit_larantula = {
                name = "美术鸣谢",
                text = {
                    "{X:dark_edition,C:white}@larantula_l{}",
                },
            },
            dd_akyrs_credit_gud = {
                name = "美术鸣谢",
                text = {
                    "{X:dark_edition,C:white}@gudusername_53951{}",
                },
            },
            dd_akyrs_credit_lyman = {
                name = "美术鸣谢",
                text = {
                    "{X:dark_edition,C:white}@lyman{}",
                },
            },
            dd_akyrs_credit_marcyptata64 = {
                name = "美术鸣谢",
                text = {
                    "{X:akyrs_gappie_cred,C:white}@marcyptata64{}",
                },
            },
            dd_akyrs_hibana_conditions = {
                name = "循环选项",
                text = {
                    "{X:dark_edition,C:white}1{} - A",
                    "{X:dark_edition,C:white}2{} - 人头牌",
                    "{X:dark_edition,C:white}3{} - 红桃",
                    "{X:dark_edition,C:white}4{} - 5",
                },
            },
            dd_akyrs_tldr_tldr_old = {
                name = "太长不看",
                text = {
                    "每张牌{C:mult}+#1#{}倍率",
                    "包括打出和留在手牌中的",
                },
            },
            dd_akyrs_tldr_tldr_absurd = {
                name = "太长不看",
                text = {
                    "{C:white,X:mult} X#1# {}倍率",
                },
            },
            dd_akyrs_aikoyori_base_ability = {
                name = "Steamodded与Lovely能力",
                text = {
                    "每张计分的非人头牌",
                    "{X:mult,C:white} X#1# {}倍率",
                },
            },
            dd_akyrs_aikoyori_base_ability_absurd = {
                name = "Steamodded、Lovely与Talisman能力",
                text = {
                    "每张计分的非人头牌",
                    "{X:dark_edition,C:white} ^#1# {}倍率",
                },
            },
            dd_akyrs_aikoyori_cryptid_ability = {
                name = "神秘生物能力",
                text = {
                    "如果出牌仅包含{C:attention}一张A{}",
                    "生成一张{C:dark_edition}负片{C:green}代码{}牌",
                },
            },
            dd_akyrs_aikoyori_more_fluff_ability = {
                name = "More Fluff能力",
                text = {
                    "当{C:colourcard}色彩牌（Colour Cards）{}获得回合时",
                    "额外添加{C:attention}1{}回合",
                },
            },
            dd_akyrs_aikoyori_entropy_ability = {
                name = "熵能力",
                text = {
                    "如果{C:attention}整副手牌{}包含至少",
                    "{C:attention}4{}张不同点数和花色的牌",
                    "生成一张{C:dark_edition}负片{C:spectral}反面（Flipside）{}",
                },
            },
            dd_akyrs_aikoyori_sdmstuff_ability = {
                name = "SDM_0物品能力",
                text = {
                    "如果{C:attention}出牌{}包含",
                    "一个{C:attention}葫芦{}",
                    "生成一张{C:dark_edition}负片{C:attention}烘焙坊（Bakery）{}牌",
                },
            },
            dd_akyrs_aikoyori_togasstuff_ability = {
                name = "TOGA物品能力",
                text = {
                    "如果你在回合结束时",
                    "获得少于{C:money}$10{}",
                    "生成一个随机补充包标签",
                    "来自{C:attention}TOGA物品{}",
                },
            },
            dd_akyrs_cryptposting_ability = {
                name = "cryptposting能力",
                text = {
                    "当盲注被跳过时",
                    "生成一张{X:attention,E:1}小丑牌{}",
                    "{C:inactive}（无需空位）",
                },
            },
            dd_akyrs_aikoyori_pta_ability = {
                name = "Paya's Terrible Additions能力",
                text = {
                    "获得额外{C:blue}辉石（Pyroxenes）{}",
                    "数值等于本回合获得的{C:money}资金{}",
                },
            },
            dd_akyrs_placeholder_art = {
                name = "Placeholder Art",
                text = {
                    "这张牌使用后",
                    "{C:attention}Placeholder art{}",
                    "后续会更改",
                },
            },
            dd_akyrs_prism_ability = {
                name = "棱镜能力",
                text = {
                    "如果出牌不包含{C:attention}同花{}",
                    "生成一张负片{C:attention}神话牌{}",
                },
            },
            dd_akyrs_garbshit_ability = {
                name = "GARBSHIT能力",
                text = {
                    "当一张{C:attention}小丑牌{}被售出时",
                    "生成一张{C:dark_edition}负片{C:attention}印花牌{}",
                },
            },
            dd_akyrs_finity_ability = {
                name = "Finity能力",
                text = {
                    "当一个{C:attention}对决{}盲注被击败时",
                    "生成一张{C:dark_edition}负片{C:spectral}Finity{}",
                },
            },
            dd_akyrs_bakery_ability = {
                name = "Bakery能力",
                text = {
                    "{C:dark_edition} +1 {}{C:attention}吊饰{}可在商店中出现{}",
                },
            },
            dd_akyrs_astronomica_ability = {
                name = "Astronomica能力",
                text = {
                    "{C:purple}将分数乘以{}",
                    "打出的牌数量",
                    "低于手牌上限的数量",
                },
            },
            dd_akyrs_vallkarri_ability = {
                name = "Vall-Karri能力",
                text = {
                    "如果按下出牌后",
                    "{C:blue}出牌次数{} = {C:red}弃牌次数{}",
                    "生成一张{C:dark_edition}负片{C:attention}美学牌{}(Aesthetic card)",
                },
            },
            dd_akyrs_grab_bag_ability = {
                name = "摸彩袋能力",
                text = {
                    "当盲注被选中时",
                    "生成一张{C:dark_edition}负片{C:attention}瞬息牌{}(Ephemeral Card)",
                },
            },
            dd_akyrs_ortalab_ability = {
                name = "Ortalab能力",
                text = {
                    "当{C:attention}星座{}牌被使用时",
                    "升级对应的{C:attention}牌型{}",
                },
            },
            dd_akyrs_hotpot_ability = {
                name = "Hot Potato能力",
                text = {
                    "获得{C:blue,f:hpot_plincoin}͸icks{}",
                    "数值等于最终计分{C:chips}筹码{}的{C:attention}10{}倍",
                },
            },
            dd_akyrs_phanta_ability = {
                name = "Phanta能力",
                text = {
                    "如果{C:attention}出牌{}包含",
                    "一个{C:attention}四条{}",
                    "生成一张{C:dark_edition}负片{C:attention}花札牌{}(Hanafuda card)",
                },
            },
            dd_akyrs_kino_ability = {
                name = "Balatro Goes Kino能力",
                text = {
                    "当在{C:attention}奇数{}次{C:blue}出牌{}时出牌",
                    "生成一张{C:dark_edition}负片{C:Confection}甜点{}(Confection)",
                    "{C:inactive}（点击出牌前的数字）",
                },
            },
            dd_akyrs_maximus_ability = {
                name = "Maximus能力",
                text = {
                    "当售出一张{C:planet}星球牌{}时",
                    "生成一张{C:dark_edition}负片{C:horoscope}Horoscope{}",
                },
            },
            dd_akyrs_sagatro_ability = {
                name = "Sagatro能力",
                text = {
                    "当售出一张{C:tarot}塔罗牌{}时",
                    "生成一张{C:dark_edition}负片{C:sgt_divinatio}神谕牌{}(Divinatio)",
                },
            },
            dd_akyrs_qualatro_ability = {
                name = "Qualatro能力",
                text = {
                    "{C:attention}Rip{}获得1点{C:attention}Quality",
                },
            },
            dd_akyrs_mukuroju_en = {
                name = "骸树之守",
                text = {
                    "每使用一张{C:tarot}星星{}",
                    "此小丑牌获得{X:mult,C:white} X#1# {}倍率",
                    "{C:inactive}（当前{X:mult,C:white} X#2# {C:inactive}倍率）",
                },
            },
            dd_akyrs_mukuroju_en_absurd = {
                name = "骸树之守",
                text = {
                    "每次使用{C:tarot}星星{}时",
                    "此小丑牌的{X:mult,C:white}倍率{}X8",
                    "{C:inactive}（当前{X:mult,C:white} X#1# {C:inactive}倍率）",
                },
            },
            dd_akyrs_nhh_cryptid = {
                name = "如果安装了Cryptid模组",
                text = {
                    "改为给予{X:dark_edition,C:white} ^#1# {}倍率",
                },
            },
            -- 盲注图标
            dd_akyrs_expert_blind = {
                name = "专家盲注",
                text = {
                    "难度高于通常的",
                    "盲注",
                },
            },
            dd_akyrs_master_blind = {
                name = "大师盲注",
                text = {
                    "难度更高的",
                    "盲注",
                },
            },
            dd_akyrs_ultima_blind = {
                name = "终极盲注",
                text = {
                    "极其困难的盲注",
                    "{scale:0.7,C:inactive}（我好像在哪见过这个）",
                },
            },
            dd_akyrs_remaster_blind = {
                name = "二阶大师盲注",
                text = {
                    "现有盲注的强化版本",
                    "{scale:0.7,C:inactive}（我好像也见过这个）",
                },
            },
            dd_akyrs_lunatic_blind = {
                name = "狂人盲注",
                text = {
                    "比终极盲注更困难",
                    "{scale:0.7,C:inactive}（我好像还是见过这个）",
                },
            },
            dd_akyrs_dx_blind = {
                name = "DX盲注",
                text = {
                    "来自More Fluff模组的",
                    "升级版底注8盲注",
                },
            },
            dd_akyrs_no_reroll = {
                name = "不可重掷",
                text = {
                    "此盲注无法被重掷",
                },
            },
            dd_akyrs_no_disabling = {
                name = "不可禁用",
                text = {
                    "此盲注无法被禁用",
                },
            },
            dd_akyrs_no_overriding = {
                name = "不可覆盖",
                text = {
                    "在此盲注被击败前",
                    "无法被覆盖",
                },
            },
            dd_akyrs_no_skipping = {
                name = "不可跳过",
                text = {
                    "此盲注无法被跳过",
                },
            },
            dd_akyrs_forgotten_blind = {
                name = "遗忘盲注",
                text = {
                    "此盲注只会在",
                    "负底注中出现",
                },
            },
            dd_akyrs_word_blind = {
                name = "单词盲注",
                text = {
                    "此盲注只会在",
                    "可能打出单词时",
                    "出现",
                },
            },
            dd_akyrs_puzzle_blind = {
                name = "谜题盲注",
                text = {
                    "此盲注只能通过",
                    "完成特定条件来击败",
                },
            },
            dd_akyrs_postwin_blind = {
                name = "获胜后盲注",
                text = {
                    "此盲注出现在",
                    "高于获胜底注（8底注）的底注中",
                },
            },
            dd_akyrs_endless_blind = {
                name = "无尽盲注",
                text = {
                    "此盲注只会在",
                    "无尽模式中出现",
                },
            },
            dd_akyrs_kessoku_band = {
                name = "{f:5}結束バンド {}(Kessoku Band)",
                text = {
                    "这张小丑牌看起来",
                    "想要{C:akyrs_bocchi}R{C:akyrs_kita}o{C:akyrs_nijika}c{C:akyrs_ryou}k{}",
                },
            },
            dd_akyrs_copper_scrape_tip = {
                name = "刮除",
                text = {
                    "固定{C:green}10%几率{}",
                    "当消耗牌被{C:attention}使用时",
                    "{C:attention}刮除{}一层",
                    "氧化层",
                },
            },
            dd_akyrs_pure_cards_tip = {
                name = "纯净牌",
                text = {
                    "{C:attention}纯净牌{}可以组成{C:attention}纯净牌型",
                    "{C:attention}纯净牌型{}提供更多",
                    "基础{C:chips}筹码{}和{C:mult}倍率",
                    "但只能在出牌仅包含{C:attention}纯净牌{}时打出",
                    "例如 这是一个{C:attention}纯净同花{}",
                },
            },
            dd_akyrs_pure_cards_tip_no_preview = {
                name = "纯净牌",
                text = {
                    "{C:attention}纯净牌{}可以组成{C:attention}纯净牌型",
                    "{C:attention}纯净牌型{}提供更多",
                    "基础{C:chips}筹码{}和{C:mult}倍率",
                    "但只能在出牌仅包含{C:attention}纯净牌{}时打出",
                    "例如 你可以用五张{C:clubs}纯净梅花{}牌",
                    "组成一个{C:attention}纯净同花{}",
                },
            },
            dd_akyrs_letter_puzzle_umbral_expl = {
                name = "字母与谜题",
                text = {
                    "{C:attention}合并{}两个字母",
                    "到一张牌上",
                },
            },
            j_hatena = {
                name = "????????",
                text = {
                    "这张牌的能力已被{C:attention}隐藏{}",
                },
            },
            dd_akyrs_neon_seal_ex = {
                name = "示例",
                text = {
                    "如果你打出{C:attention}3{}张带此蜡封的牌",
                    "并在手牌中留{C:green}1{}张带此蜡封的牌",
                    "它会生成{C:green}1{}张{C:akyrs_umbral_p,X:akyrs_umbral_y}暗影{}牌",
                    "{C:inactive}（取较小值）",
                },
            },
            dd_akyrs_non_functional = {
                name = "警告！",
                text = {
                    "{C:red,E:akyrs_shrivel,s:1.9}这张牌",
                    "{C:red,E:akyrs_shrivel,s:1.8}不会生效！",
                },
            },
            dd_akyrs_scenario_tooltip = {
                name = "情境",
                text = {
                    "{B:1,V:2}#3# #4#{}",
                    "{C:blue}#1#{} / #2#回合剩余",
                },
            },
        },
        Edition = {
            e_akyrs_texelated = {
                name = "像素化",
                text = {
                    "{C:white,X:chips}X#1#{}筹码",
                    "{C:white,X:mult}X#2#{}倍率",
                },
            },
            e_akyrs_noire_joker = {
                name = "霓虹黑",
                text = {
                    "{C:dark_edition}+#1#{}个小丑牌槽位",
                    "{C:white,X:mult}X#2#{}倍率",
                },
            },
            e_akyrs_noire_consumable = {
                name = "霓虹黑",
                text = {
                    "{C:dark_edition}+#1#{}个消耗牌槽位",
                    "{C:white,X:mult}X#2#{}倍率",
                },
            },
            e_akyrs_noire_hand = {
                name = "霓虹黑",
                text = {
                    "{C:dark_edition}+#1#{}手牌上限",
                    "{C:white,X:mult}X#2#{}倍率",
                },
            },
            e_akyrs_noire = {
                name = "霓虹黑",
                text = {
                    "{C:dark_edition}+#1#{}最大槽位容量",
                    "{C:white,X:mult}X#2#{}倍率",
                },
            },
            e_akyrs_charged = {
                name = "充能",
                text = {
                    "{C:purple}+#1#{}分数",
                    "每次触发获得{C:purple}+#2# {C:inactive}[+#3#]{}",
                },
            },
            e_akyrs_sliced = {
                name = "切片",
                text = {
                    "{C:attention}减半{}所有数值",
                    "效果计算{C:attention}两次{}",
                },
            },
            e_akyrs_burnt = {
                name = "烧焦",
                text = {
                    "有{C:green}#1#/#2#{}几率",
                    "在回合结束时",
                    "化为灰烬",
                },
            },
            e_akyrs_enchanted = {
                name = "附魔",
                text = {},
            },
        },
        Enchantment = {
            ench_akyrs_multi_enchant_book = {
                name = "附魔书",
                text = {
                    "包含{C:attention}不止一种{}附魔",
                },
            },
            ench_akyrs_unbreaking = {
                name = "耐久#1#",
                text = {
                    "当此卡牌被{C:attention}摧毁{}时",
                    "有{C:attention}固定{C:green}#2#%{}几率",
                    "复制一张不带附魔的此卡牌",
                },
            },
            ench_akyrs_efficiency = {
                name = "效率#1#",
                text = {
                    "有{C:attention}固定{C:green}#2#%{}几率",
                    "复制{C:attention}左侧卡牌{}的能力",
                    "{B:1,C:white} #3# {}",
                },
            },
            ench_akyrs_mending = {
                name = "经验修补",
                text = {
                    "{C:attention}重新触发{}1次",
                },
            },
            ench_akyrs_fire_aspect = {
                name = "火焰附加#1#",
                text = {
                    "触发时{C:purple}+#2#%{}分数",
                },
            },
            ench_akyrs_fortune = {
                name = "时运#1#",
                text = {
                    "此卡牌的{C:green}概率+#2#%{}",
                },
            },
            ench_akyrs_greed = {
                name = "贪婪#1#",
                text = {
                    "售出卡牌时将其售价的{C:money}+#2#%{}",
                    "添加到{C:attention}此卡牌{}的售价中",
                },
            },
            ench_akyrs_silk_touch = {
                name = "精准采集#1#",
                text = {
                    "弃掉时移除{C:attention}增强效果{}",
                    "并为此卡牌添加{C:white,X:mult} X#2# {}倍率",
                },
            },
            ench_akyrs_cornucopia = {
                name = "丰饶之角",
                text = {
                    "打出时复制{C:attention}此卡牌{}并加入出牌",
                    "移除复制牌的{C:attention}附魔{}",
                },
            },
        },
        Enhanced = {
            m_bld_the_choice = {
                name = "选择",
                text = {
                    "{X:dark_edition,C:white}褪色{}",
                    "{X:red,C:white}X#1#{}倍率",
                    "出牌必须包含{B:1}#2#{}盲注",
                },
            },
            m_bld_the_reject = {
                name = "拒绝",
                text = {
                    "{X:dark_edition,C:white}褪色{}",
                    "{X:blue,C:white}X#1#{}筹码",
                    "出牌不得包含{B:1}#2#{}盲注",
                },
            },
            m_bld_the_redo = {
                name = "重来",
                text = {
                    "{X:dark_edition,C:white}黄色{}",
                    "打出时{C:attention}重新触发{}1次",
                    "留在手牌中的效果",
                },
            },
            m_akyrs_brick_card = {
                name = "砖块牌",
                text = {
                    "{C:mult}+#1#{}倍率",
                    "没有点数或花色",
                },
            },
            m_akyrs_scoreless = {
                name = "不计分牌",
                text = {
                    "不计分",
                },
            },
            m_akyrs_ash_card = {
                name = "灰烬牌",
                text = {
                    "{C:blue}+#1#{}筹码",
                    "没有点数和花色",
                    "有{C:green}#2#/#3#{}几率",
                    "在回合结束时",
                    "化为乌有",
                },
            },
            m_akyrs_ash_card_absurd = {
                name = "灰烬牌",
                text = {
                    "{C:purple,X:edition} ^#1# {}筹码",
                    "没有点数和花色",
                    "在回合结束时",
                    "{C:attention}必定{}化为乌有",
                },
            },
            m_akyrs_hatena = {
                name = "？牌",
                text = {
                    {
                        "计分时有{C:green}#1#/#2#{}几率获得{C:money}$#3#",
                        "有{C:green}#4#/#5#{}几率获得{C:money}$#6#",
                        "有{C:green}#7#/#8#{}几率给予{C:mult}+#9#{}倍率",
                        "首次计分时和重新触发时{X:mult,C:white} X#10# {}",
                    },
                    {
                        "没有点数和花色 总是计分",
                    },
                },
            },
            m_akyrs_item_box = {
                name = "道具盒牌",
                text = {
                    {
                        "计分时生成一张{C:attention}随机{}",
                        "{C:tarot}消耗牌{}",
                        "{C:inactive}（必须有空位）",
                    },
                    {
                        "如果成功触发",
                        "则在回合结束时{C:red,E:1}自毁{}",
                    },
                    {
                        "没有点数和花色 总是计分",
                    },
                },
            },
            m_akyrs_insolate_card = {
                name = "曝晒牌",
                text = {
                    "如果出牌{C:attention}不包含{}重复的{C:attention}增强效果",
                    "此牌打出时获得{C:white,X:mult} X#1# {}倍率",
                    "{C:inactive}（当前{C:white,X:mult} X#2# {C:inactive}倍率）",
                },
            },
            m_akyrs_canopy_card = {
                name = "华盖牌",
                text = {
                    "每次出牌可{C:attention}双击{}此牌1次",
                    "使其点数{C:attention}-1{}",
                    "{B:1,V:2}#1#{}",
                },
            },
            m_akyrs_thai_tea_card = {
                name = "泰式奶茶牌",
                text = {
                    "{X:mult,C:white} X#1# {}倍率",
                },
            },
            m_akyrs_matcha_card = {
                name = "抹茶牌",
                text = {
                    "{X:purple,C:white} X#1# {}分数",
                    "{X:blind,C:white} X#1# {}盲注要求分数",
                },
            },
            m_akyrs_earl_grey_tea_card = {
                name = "伯爵茶牌",
                text = {
                    "如果此牌被{C:attention}打出但未计分{}",
                    "获得{C:money}+$#1#{}",
                },
            },
            m_akyrs_zap_card = {
                name = "闪电牌",
                text = {
                    "此牌每计分{C:attention}#1#{}次",
                    "{C:inactive}（#2#）{}",
                    "{C:attention}复制{}自身",
                    "不带增强效果",
                },
            },
            m_akyrs_net_card = {
                name = "网牌",
                text = {
                    {
                        "留在手牌中时",
                        "{C:white,X:mult}X#1#{}倍率",
                    },
                    {
                        "回合结束时如果留在手牌中",
                        "获得{C:money}#2#{}",
                    },
                },
            },
            m_akyrs_droplet_card = {
                name = "水滴牌",
                text = {
                    "有{C:green}#1#/#2#{}几率",
                    "被弃掉时给予",
                    "{C:red}+#3#{}次弃牌",
                },
            },
            m_akyrs_semibreve_card = {
                name = "全音符牌",
                text = {
                    "{C:chips}+#1#{}筹码",
                    "{C:mult}+#2#{}倍率",
                },
            },
            m_akyrs_minim_card = {
                name = "二分音符牌",
                text = {
                    "{C:white,X:chips}X#1#{}筹码",
                    "{C:mult}+#2#{}倍率",
                },
            },
            m_akyrs_crotchet_card = {
                name = "四分音符牌",
                text = {
                    "{C:white,X:chips}X#1#{}筹码",
                    "{C:white,X:mult}X#2#{}倍率",
                },
            },
            m_akyrs_wafer_card = {
                name = "威化牌",
                text = {
                    "在本回合{C:attention}最后一次出牌{}时",
                    "获得{C:white,X:purple}X#1#{}分数",
                },
            },
            m_akyrs_shore_card = {
                name = "海岸牌",
                text = {
                    "{C:white,X:mult}X#1#{}倍率",
                    "计分时有{C:green}#3#/#4#{}几率被摧毁",
                    "有{C:green}#5#/#6#{}几率扩散到",
                    "随机一张留在手牌中的牌",
                    "并额外获得{C:white,X:mult}X#2#{}倍率",
                },
            },
            m_akyrs_cloud_card = {
                name = "云朵牌",
                text = {
                    "回合结束时",
                    "牌组中每有1张此牌获得{C:money}#1#{}",
                },
            },
            m_akyrs_nightshade_card = {
                name = "夜影牌",
                text = {
                    "{C:white,X:chips}X#1#{}筹码",
                    "如果抽到后没有{C:attention}立即打出{}",
                    "则{C:attention}削弱自身{}",
                },
            },
            m_akyrs_tap_card = {
                name = "轻触牌",
                text = {
                    {
                        "{C:white,X:blind}X#1#{}盲注要求分数",
                        "没有点数和花色 总是计分",
                    },
                },
            },
            m_akyrs_tap_card_life = {
                name = "轻触牌",
                text = {
                    {
                        "{C:white,X:blind}X#1#{}盲注要求分数",
                        "没有点数和花色 总是计分",
                    },
                    {
                        "损失的{C:green}生命{}",
                        "是通常情况的{C:attention}一半{}",
                    },
                },
            },
        },
        FakeCenter = {
            fc_akyrs_eggymari_hatena_art = {
                name = "隐藏卡牌图像",
                text = {
                    "会与{C:attention}隐藏贴纸{}一同出现",
                    "也会出现在部分{C:attention}挑战{}中",
                },
            },
            fc_akyrs_toga_charmap = {
                name = "字符映射表",
                text = {
                    "安装{C:attention}TOGA's Stuff{}后即可揭晓",
                },
            },
            fc_akyrs_toga_winword = {
                name = "微软 Word",
                text = {
                    "安装{C:attention}TOGA's Stuff{}后即可揭晓",
                },
            },
            fc_akyrs_paperback_pure_star = {
                name = "纯净星星牌",
                text = {
                    "安装{C:attention}Paperback{}以启用{C:attention}星星{}花色",
                },
            },
            fc_akyrs_paperback_pure_crown = {
                name = "纯净王冠牌",
                text = {
                    "安装{C:attention}Paperback{}以启用{C:attention}王冠{}花色",
                },
            },
            fc_akyrs_paperback_pure_apostle = {
                name = "纯净使徒牌",
                text = {
                    "安装{C:attention}Paperback{}以启用{C:attention}使徒{}花色",
                },
            },
            fc_akyrs_judgement_miss = {
                name = "失误",
                text = {
                    "用于{C:green}生命{}机制",
                },
            },
            fc_akyrs_judgement_good = {
                name = "良好",
                text = {
                    "用于{C:green}生命{}机制",
                },
            },
            fc_akyrs_judgement_great = {
                name = "优秀",
                text = {
                    "用于{C:green}生命{}机制",
                },
            },
            fc_akyrs_judgement_perfect = {
                name = "完美",
                text = {
                    "用于{C:green}生命{}机制",
                },
            },
            fc_akyrs_judgement_cperfect = {
                name = "极致完美",
                text = {
                    "用于{C:green}生命{}机制",
                },
            },
        },
        Joker = {
            -- toga
            j_akyrs_toga_charmap = {
                name = "字符映射表",
                text = {
                    "如果只有一个最常见的字母",
                    "为最常打出的字母",
                    "生成一张{C:attention}字母{}牌",
                },
            },
            j_akyrs_toga_winword = {
                name = "微软 Word",
                text = {
                    "如果打出单词",
                    "每个字母使此小丑牌获得{X:mult,C:white} X#1# {}倍率",
                    "{C:inactive}（当前{X:mult,C:white} X#2# {C:inactive}倍率）",
                },
            },
            j_akyrs_redstone_repeater = {
                name = "红石中继器",
                text = {
                    "交换当前的{C:white,X:mult}倍率{}值",
                    "与存储的{C:mult}倍率{}值",
                    "然后{X:mult,C:white} X#2# {}倍率",
                },
            },
            j_akyrs_redstone_repeater_absurd = {
                name = "红石中继器",
                text = {
                    "交换当前的{C:white,X:mult}倍率{}值",
                    "与存储的{C:mult}倍率{}值",
                    "然后{C:white,X:dark_edition} ^#2# {}倍率",
                },
            },
            j_akyrs_observer = {
                name = "观察者",
                text = {
                    "每当观察者以外的卡牌{C:attention}晃动{}",
                    "达到{C:attention}#4#{}次{C:inactive}（#3#）{}",
                    "此小丑牌获得{C:mult}+#1#{}倍率",
                    "{s:0.8}每次此小丑牌获得{C:mult}倍率{}",
                    "{s:0.8}所需次数增加{C:attention}#5#{}",
                    "{C:inactive}（当前{C:mult}+#2#{C:inactive}倍率）",
                },
            },
            j_akyrs_observer_absurd = {
                name = "观察者",
                text = {
                    "每次{C:chips}筹码{}或{C:mult}倍率{}值变化",
                    "达到{C:attention}#4#{}次{C:inactive}（#3#）{}",
                    "此小丑牌获得{X:mult,C:white} X#1# {}倍率",
                    "{s:0.8}每次此小丑牌获得{X:mult,C:white}倍率{}",
                    "{s:0.8}所需次数增加{C:attention}#5#{}",
                    "{C:inactive}（当前{X:mult,C:white} X#2# {C:inactive}倍率）",
                },
            },
            j_akyrs_quasi_connectivity = {
                name = "准连通性",
                text = {
                    "{C:white,X:mult} X#1# {}倍率",
                    "出牌后禁用一张{C:attention}随机小丑牌{}",
                    "{s:0.8}如果它是唯一的卡牌",
                    "{s:0.8}则削弱自身",
                },
            },
            j_akyrs_quasi_connectivity_absurd = {
                name = "准连通性",
                text = {
                    "{C:white,X:dark_edition} ^#1# {}倍率",
                    "出牌后禁用两张{C:attention}随机小丑牌{}",
                    "{s:0.8}如果你有2张或更少小丑牌",
                    "{s:0.8}则削弱自身",
                },
            },
            j_akyrs_diamond_pickaxe = {
                name = "钻石镐",
                text = {
                    "从每张计分的{C:attention}石头{}牌",
                    "吸取{C:chips}#2#{}筹码",
                    "并将该数值{C:attention}添加{}到此小丑牌",
                    "{C:inactive}（如果卡牌没有剩余筹码则移除石头效果）",
                    "{C:inactive}（当前{C:chips}+#1#{C:inactive}筹码）",
                },
            },
            j_akyrs_diamond_pickaxe_absurd = {
                name = "钻石镐",
                text = {
                    "出牌后将你{C:attention}所有{}",
                    "留在手牌中的牌变为{C:attention}石头牌{}",
                    "每张计分的{C:attention}石头{}牌",
                    "给予{C:attention}#2#{}层{C:chips}+#1#{}筹码",
                    "并将每张计分的{C:attention}石头{}牌",
                    "变为随机{C:attention}非石头增强{}",
                },
            },
            j_akyrs_netherite_pickaxe = {
                name = "下界合金镐",
                text = {
                    "摧毁打出的{C:attention}石头{}牌",
                    "每张被{C:attention}摧毁的石头牌",
                    "使这张小丑牌获得{X:chips,C:white}X#2#{}筹码",
                    "{C:inactive}（当前{X:chips,C:white} X#1# {C:inactive}筹码）",
                },
            },
            j_akyrs_netherite_pickaxe_absurd = {
                name = "下界合金镐",
                text = {
                    "将{C:attention}所有被弃掉的{}牌",
                    "变为{C:attention}石头牌{}",
                    "每张计分的{C:attention}石头{}牌",
                    "获得{C:attention}#2#{}层{X:chips,C:white} X#1# {}筹码",
                    "{C:red,E:1}随后摧毁所有",
                    "{C:attention,E:1}计分的{C:red,E:1}石头牌{}",
                    "{C:inactive}（当前{X:chips,C:white} X#3# {C:inactive}筹码）",
                },
            },
            j_akyrs_utage_charts = {
                name = "宴乐榜单",
                text = {
                    "{C:akyrs_playable}+#1#{}选择上限",
                },
            },
            j_akyrs_maxwells_notebook = {
                name = "麦克斯韦笔记",
                text = {
                    "拼出一种卡牌类型",
                    "给予你{C:attention}一张{}对应类型的卡牌",
                    "拼出增强效果会",
                    "将计分牌增强为你拼写的效果",
                    "{C:inactive}（必须有空位）",
                },
            },
            j_akyrs_it_is_forbidden_to_dog = {
                name = "禁止狗狗",
                text = {
                    "当此小丑牌计分时",
                    "每张留在手牌中的被削弱牌",
                    "给予{X:mult,C:white} X#1#{}倍率",
                    "{C:inactive}（由于技术限制）",
                    "每次{C:attention}抽牌{}后",
                    "手牌中{C:attention}随机{}一张游戏牌被削弱",
                },
            },
            j_akyrs_it_is_forbidden_to_dog_absurd = {
                name = "禁止狗狗",
                text = {
                    "每张{C:attention}未计分{}的打出的牌",
                    "给予{X:dark_edition,C:white} ^#1#{}倍率",
                    "{C:attention}所有{}未计分牌变为{C:attention}不计分牌{}",
                },
            },
            j_akyrs_eat_pant = {
                name = "吃裤子",
                text = {
                    "如果出牌正好是{C:attention}4{}张牌",
                    "{C:red}摧毁前两张打出的牌{}",
                    "每张被摧毁的牌失去",
                    "当前{X:mult,C:white}倍率{}的{X:mult,C:white}1/#2#{}",
                    "{C:inactive}（当前{X:mult,C:white} X#3# {C:inactive}倍率）",
                    "{C:inactive}（可能降至{X:mult,C:white} X1 {C:inactive}以下）",
                },
            },
            j_akyrs_eat_pant_absurd = {
                name = "吃裤子",
                text = {
                    "如果出牌包含{C:attention}两对{}",
                    "每张计分牌使此小丑牌获得{X:mult,C:white} X#2# {}倍率",
                    "{C:red}摧毁所有打出的牌{}",
                    "{C:inactive}（当前{X:mult,C:white} X#3# {C:inactive}倍率）",
                },
            },
            j_akyrs_tsunagite = {
                name = "{f:5,C:akyrs_luminous}系ぎて",
                text = {
                    "如果打出的牌的{C:chips}筹码{}",
                    "能被{C:attention}#1#{}整除",
                    "打出的牌永久获得{X:mult,C:white} X#2#{}倍率",
                },
            },
            j_akyrs_tsunagite_absurd = {
                name = "{f:5,C:akyrs_luminous}系ぎて{}",
                text = {
                    "打出的牌计分时获得当前列出的数值",
                    "当{C:tarot,T:c_wheel_of_fortune}命运之轮{}被使用时",
                    "{C:tarot,T:c_wheel_of_fortune}命运之轮{}总是失败",
                },
            },
            j_akyrs_yona_yona_dance = {
                name = "夜夜舞踊",
                text = {
                    "重新触发每张打出的{C:attention}4{}和{C:attention}7{}",
                    "额外{C:attention}#1#{}次",
                    "{C:inactive,s:0.9,f:akyrs_MochiyPopOne}ならば踊らにゃ損、踊らにゃ損です!{}",
                },
            },
            j_akyrs_tldr_joker = {
                name = "太长懒得看小丑",
                text = {
                    {
                        "仅当下列{C:attention}全部{}条件",
                        "在本赛局中至少完成1次时",
                        "获得{C:white,X:mult} X#1# {}倍率",
                        "否则每张牌{C:mult}+#2#{}倍率",
                    },
                    {
                        "太平藏邪教 正邪之间有{C:red}倍率{} 待数字尽染蓝色 十条线索须全解",
                        "其一不可少 乘{C:red}疾风{}胜盲注 烈焰灼灼 一次出牌定胜负",
                        "其二商店诱人 此牌必须{C:attention}售出1次{} 方可继续持有",
                        "其三轮到{C:purple}魔术{} 有些模组会卡顿 但务必取得{C:purple}魔术标签{}",
                        "其四打破高墙 有言道{C:akyrs_replicant_o}仿生牌{}非黄金 故须{C:attention}使用{}",
                        "其五并不难 {C:attention}优惠券{}并非免费 务必{C:attention}兑换{}1张",
                        "其六须筹谋 {C:attention}售出{}同伴一员 此员须为{C:red}稀有{} 方显无贪",
                        "其七途中有壕沟 使用{C:akyrs_umbral_p,X:akyrs_umbral_y}侵入性思维{}赢下回合 莫待运气消磨",
                        "其八重整布局 用{C:attention}小丑牌{}将槽位{C:attention}填满{} 次序无妨",
                        "其九看似荒唐 同一回合既打出{C:attention}顺子{} 又打出{C:attention}同花{}",
                        "其十并非单牌 拥有{C:attention}两张{}{C:hearts}红桃8{} 十项俱成 倍率归你",
                    },
                },
            },
            j_akyrs_tldr_joker_2 = {
                name = "太长懒得看小丑2",
                text = {
                    "在{C:attention,E:1,s:1.1}Balatro{}的广阔世界中 一位神祇降临 只有如此天才之人",
                    "才能理解这位神祇 如此优雅而神圣的身影最多只会赐下寥寥数语",
                    "神祇说道 坚持不懈是通往终极真理的关键 这是生命的事实",
                    "这可不止寥寥数语 不是吗 这位神祇所说的终极真理究竟是什么",
                    "当有人想出在所有地方坚持到底的绝妙点子时 此事才受到关注",
                    "一名年近30的男子问道 只有这样的天才才能抵达终极真理吗",
                    "他会打破史上最不聪明样本的纪录 排名甚至低于海绵动物",
                    "标题并未说谎 他确实不太聪明 但他尝试了 他一直想回到",
                    "小学补回一个正常成年人在现代社会生存所需的知识",
                    "他在NASA当清洁工的薪水足够支付某所高端职业学校的课程",
                    "他的坚持 或者说固执 使他一生中做出了许多错误决定",
                    "小时候他认为{C:purple}巨石阵{}由外星人建造 还认为世界{C:attention}7大奇迹{}只是自然造物",
                    "经历一切后 他知道自己已准备好再次面对神祇 这场{C:attention}仪式{}他早已烂熟于心",
                    "他吟诵道 主啊 请救我脱离现实这片燃烧的地狱 一道宛如全息影像的图像出现在眼前",
                    "全息影像宣告 蓝zoozh设备已准备配对 他难以置信 神祇竟如此高科技",
                    "居然使用蓝牙这种先进的人类技术 他掏出Phone 17 Pro Max Ultra Ultimate & Knuckles 连接名为神祇传送门的设备",
                    "全息影像喊道 蓝zoozh设备已呃成功连接 你有一个卡尔",
                    "他误听之后驾车冲下全息影像最初出现的悬崖 看来他终究还是",
                    "疯了 当全身每一寸都烧成灰烬时 车载屏幕显示{C:white,X:mult} X#1# {}倍率",
                    "这就是他需要知道的一切 他终于接受那个该死的神祇毫无用处",
                    "神祇突然出现在他几近烧焦的身体前 原来从初次见面起便谋划着他的毁灭",
                    "你已经在世间坚持了个遍 现在该安详离开这个世界了",
                    "话音落下 一切沉入黑暗 只留下成为更好自我的愿望",
                },
            },
            j_akyrs_tldr_joker_absurd = {
                name = "太长懒得看小丑",
                text = {
                    "{C:inactive}译者注：没有乱写，请自行从文本中找到这张小丑牌的效果{}",
                    "起初 只有{C:attention,E:1,s:1.1}Balatro{}不是神祇 而是更复杂的存在 是包裹在清晰数字纸牌中的不断洗混的{C:akyrs_playable}混沌化身{}",
                    "游戏存在于逻辑与{C:tarot}狂乱{}之间的阈限空间、数学与幻象之间 在那里{C:green}概率{}变得可塑 扑克游戏牌随着每次{C:blue}出牌{}变异为神话",
                    "在{C:attention,E:1,s:1.1}Balatro{}中 人们不仅{E:2,C:attention}玩{}扑克 在这里{C:attention}顺子{}延伸至超现实 {C:attention}同花{}低语着禁忌几何 {C:akyrs_playable}牌组{}是活的，随着势能和像素化威胁而振动",
                    "每次抽牌都像从{C:attention}巨型小丑包{}中拽出{C:attention}仪式匕首{}",
                    "在混乱之上赫然耸立的是不洁的神殿：小丑牌，他们不是弄臣，而是神。",
                    "伪装成{C:akyrs_playable}小丑{}的数学之灵，每张小丑牌扭曲规则、打破规则，有时将它们整个吞噬，滋养着建立在傲慢、电子表格和原始本能上的策略",
                    "登场的是{C:attention}太长懒得看小丑{}——在疯狂与理论殿堂中被低语的小丑。刻有单一预言的矩形符文：“如果手牌包含高牌 则{C:white,X:mult} X#1# {}倍率”",
                    "这很简单，很神圣，是任性的辉煌。为什么是{C:white,X:mult}X#1#{}，为什么不是{C:white,X:mult} X1.19542 {}倍率或{C:white,X:mult} X638.95 {}或{C:white,X:mult,f:6} Xπ {}倍率，因为{C:white,X:mult} X#1# {}是戏剧性的神圣数字",
                    "因为三是神圣精神的数字，{C:attention}人头牌{}、三角力量中的三角形、三轮车的轮子",
                    "因为看到手牌中有一张{C:attention}K{}，并被告知{C:attention,E:1}“你可以乘坐了”{}，是见证{C:akyrs_playable}混沌{}理论与时尚傲慢交汇处的设计",
                    "{C:attention}太长懒得看小丑{}不乞求协同，它{C:attention}要求{}崇敬和警惕，它将高牌变为圣物，它们的出现{C:spectral}召唤{}力量，{C:attention}J{}不再只是穿着天鹅绒运动夹克的青少年贵族，现在他们是宇宙{C:white,X:mult}倍率{}的导管，是通往{C:dark_edition}指数{}级增长的桥梁",
                    "让我们直说{C:attention}“高牌”{}，那些游戏牌牌型的皇家幽灵：{C:attention}J{}——带着青少年的狡黠趾高气扬、{C:attention}Q{}——危险而神圣、{C:attention}K{}——沉重的君主。挥舞着{C:attention}税赋{}和{C:white,X:mult}倍率{}，还有{C:attention}A{}——模糊、适应性强、既是起始也是终结",
                    "神级的野性化身，抽到一张是{C:tarot}幸运{}，打出一张是策略。将一张与{C:attention}太长懒得看小丑{}结合，是召唤一个如此暴力的方程，它打穿了电子表格矩阵，这不仅是组合，也是生活方式；是宣言，也是数学的张扬；牌组因它而扭曲",
                    "你开始寻找{C:attention}皇族{}。不是出于虚荣，而是奉献。{C:hearts}红桃{}心跳加速、{C:spades}黑桃{}挖掘更深、{C:diamonds}方片{}带着目的闪烁、甚至通常如此粗野的{C:clubs}梅花{}，现在也{C:attention}闪耀{}着精炼的潜力",
                    "每次抽牌都变成祈祷：拜托，来个{C:attention}Q{}吧。或{C:attention}K{}、或{C:attention}J{}，因为即使牌型是垃圾，单张人头牌就能神圣化它",
                    "{C:attention,E:1,s:1.1}Balatro{}变成了不是最佳牌型的游戏，而是最佳{C:attention}条件{}的游戏，带K的垃圾手不是垃圾，是{C:white,X:mult}X#1#{}驱动的后果引擎",
                    "现在让我们回溯时光，回到小丑牌之前——{C:attention,E:1,s:1.1}Balatro{}之前",
                    "发现硅和发明CPU之前的几个世纪，回到9世纪的{C:white,X:red,f:4}中国{}——{C:attention}纸牌{}开始的地方；在那里，在卷轴和皮影戏中，游戏的{C:tarot}基石{}诞生了",
                    "纸张的不确定性，命运之舞用{C:attention}文字{}和书法书写，在那个世界{C:green}运气{}不是{C:attention}对手{}，而是{C:attention}基本真理{}。{C:green}骰子{}不是为了控制而掷，而是为了与未知沟通",
                    "机遇被尊为缪斯（神名），而不是作为数学问题解决。在{C:attention,E:1,s:1.1}Balatro{}中，我们也感受到这种对不确定性的古老崇敬（即塔罗牌设计）",
                    "{C:attention}太长懒得看小丑{}戴着现代面具，是那些古老原则的祖先的化身，是嵌入数字牌组的凤凰羽毛，是朝代的低语。",
                    "它提醒我们无论走了多远，从古代丝绸牌到OLED现代屏幕，我们仍然被{C:green}机遇的不确定性{}所困扰和谦卑。所以当我们抽到{C:attention}高牌{}，{C:attention}太长懒得看小丑{}闪烁出现",
                    "我们不仅是乘法运算，我们{C:attention}召唤{}古老的、永恒的、混沌的未知存在。我们成为战略家和、祈求者、数学家和{C:red}神秘主义者{}",
                    "赛局结束，屏幕淡出，小丑牌留存。{C:attention}太长懒得看小丑{}说：",
                    "{C:attention}高牌{}=高赌注=高生活",
                    "这不仅是机制，也是隐喻",
                    "{C:attention,E:1,s:1.1}Balatro{}的成功不仅建立在手牌上",
                    "而且建立在全部都是{C:hearts}红桃{}牌上",
                    "有时候，需要的只是一张K，和一张注意到它的小丑牌",
                },
            },
            j_akyrs_reciprocal_joker = {
                name = "倒数小丑",
                text = {
                    "将{X:mult,C:white}倍率{}设置为",
                    "{X:chips,C:white}筹码{}÷{X:mult,C:white}倍率{}",
                },
            },
            j_akyrs_reciprocal_joker_absurd = {
                name = "倒数小丑",
                text = {
                    "将{X:chips,C:white}筹码{}设置为",
                    "{X:mult,C:white}倍率{}÷{X:chips,C:white}筹码{}",
                },
            },
            j_akyrs_kyoufuu_all_back = {
                name = "Kyoufuu All Back",
                text = {
                    "将之前{C:attention}打出和弃掉的{}牌",
                    "以及{C:attention}打出的{}牌返回牌组",

                },
            },
            j_akyrs_2fa = {
                name = "双重验证",
                text = {
                    "{C:attention}所有打出的牌的{}点数和花色",
                    "在计分后{C:attention}随机化{}",
                    "每张打出的牌使这张小丑牌获得{C:chips}+#1#{}筹码",
                    "回合结束时{C:attention}减半{}",
                    "{C:inactive}（当前{C:chips}+#2#{C:inactive}筹码）",
                    "{C:inactive,s:0.8}提醒：请在所有在线账户启用双重验证",
                },
            },
            j_akyrs_2fa_absurd = {
                name = "双重验证",
                text = {
                    "{C:attention}所有打出的牌的{}点数和花色",
                    "在计分后{C:attention}随机化{}",
                    "如果点数保持不变 获得{X:chips,C:white} X#1# {}筹码",
                    "如果花色保持不变 获得{X:mult,C:white} X#2# {}倍率",
                    "{C:inactive}（当前{X:chips,C:white} X#3# {C:inactive}筹码",
                    "{C:inactive}和{X:mult,C:white} X#4# {C:inactive}倍率）",
                    "{C:inactive,s:0.8}提醒：请在所有在线账户启用双重验证",
                },
            },
            j_akyrs_gaslighting = {
                name = "煤气灯",
                text = {
                    "每次出牌此小丑牌获得{X:mult,C:white} X#1# {}倍率",
                    "{C:attention}得分着火时绝对不会重置",
                    "{C:inactive,s:0.7}相信我 不是金宝",
                    "{C:inactive}（当前{X:mult,C:white} X#2# {C:inactive}倍率）",
                },
            },
            j_akyrs_gaslighting_absurd = {
                name = "煤气灯",
                text = {
                    "{C:edition,X:dark_edition,s:1.1} ^^#1# {}倍率",
                    "{C:attention}绝对不会让你输",
                    "{C:inactive,s:0.6}你只是在想象我有",
                    "{C:inactive,s:0.6}#3#/#4#几率改为给予{X:inactive,C:white,s:0.6} ^^#2# {C:inactive,s:0.6}倍率",
                },
            },
            j_akyrs_hibana = {
                name = "火花",
                text = {
                    "{C:attention}#1#{}会最先被抽到",
                    "每回合{C:attention}循环{}列表",
                    "{C:inactive}（当前选项：{C:white,X:dark_edition}#2#{C:inactive}）",
                },
            },
            j_akyrs_centrifuge = {
                name = "离心机",
                text = {
                    "如果至少打出{C:attention}3{}张牌",
                    "第一张和最后一张牌点数{C:attention}+#1#{}",
                    "所有其他牌点数{C:attention}-#1#{}",
                    "打出的每张牌给予{C:chips}+#2#{}筹码",
                },
            },
            j_akyrs_centrifuge_absurd = {
                name = "离心机",
                text = {
                    "如果至少打出{C:attention}3{}张牌",
                    "第一张和最后一张牌点数{C:attention}+#1#{}",
                    "两者获得新增强和版本",
                    "所有其他牌点数{C:attention}-#1#{}",
                    "并变为{C:attention}不计分牌{}",
                },
            },
            j_akyrs_henohenomoheji = {
                name = "へのへのもへじ",
                text = {
                    "带有字母{C:attention}K{}、{C:attention}Q{}和{C:attention}J{}的牌",
                    "被视为{C:attention}人头牌{}",
                },
            },
            j_akyrs_henohenomoheji_absurd = {
                name = "へのへのもへじ",
                text = {
                    "带有字母{C:attention}K{}、{C:attention}Q{}和{C:attention}J{}的牌",
                    "分别被视为{C:attention}K{}、{C:attention}Q{}",
                    "和{C:attention}J{}",
                },
            },
            j_akyrs_neurosama = {
                name = "Neuro Sama",
                text = {
                    {
                        "如果出牌同时包含{C:hearts}红桃{}和{C:spades}黑桃{}",
                        "每张计分的{C:hearts}红桃{}和{C:spades}黑桃{}",
                        "使此小丑牌获得{X:mult,C:white} X#2# {}倍率",
                    },
                    {
                        "{C:inactive}（当前{X:mult,C:white} X#1# {C:inactive}倍率）",
                    },
                },
            },
            j_akyrs_neurosama_absurd = {
                name = "Neuro Sama",
                text = {
                    "每张计分的{C:hearts}红桃{}牌",
                    "使此小丑牌的{X:mult,C:white}倍率{}{X:mult,C:white} X#2# {}",
                    "如果存在{T:j_akyrs_evilneuro,C:red}Evil Neuro{}",
                    "每张计分的{C:spades}黑桃{}牌",
                    "也使此小丑牌的{X:mult,C:white}倍率{}{X:mult,C:white} X#2# {}",
                    "{C:inactive}（当前{X:mult,C:white} X#1# {C:inactive}倍率）",
                },
            },
            j_akyrs_evilneuro = {
                name = "Evil Neuro",
                text = {
                    {
                        "如果出牌同时包含{C:clubs}梅花{}和{C:diamonds}方片{}",
                        "每张计分的{C:clubs}梅花{}和{C:diamonds}方片{}",
                        "使此小丑牌获得{X:chips,C:white} X#2# {}筹码",
                    },
                    {
                        "{C:inactive}（当前{X:chips,C:white} X#1# {C:inactive}筹码）",
                    },
                },
            },
            j_akyrs_evilneuro_absurd = {
                name = "Evil Neuro",
                text = {
                    "每张计分的{C:clubs}梅花{}牌",
                    "使此小丑牌的{X:chips,C:white}筹码{}指数增加{X:edition,C:purple} ^#2# {}",
                    "如果存在{T:j_akyrs_neurosama,C:red}Neuro Sama{}",
                    "每张计分的{C:diamonds}方片{}牌",
                    "也使此小丑牌的{X:chips,C:white}筹码{}指数增加{X:edition,C:purple} ^#2# {}",
                    "{C:inactive}（当前{X:chips,C:white} X#1# {C:inactive}筹码）",
                },
            },
            j_akyrs_dried_ghast = {
                name = "干燥幽灵",
                text = {
                    "接下来{C:blue}#1#{}回合",
                    "{C:red}没有弃牌{}次数",
                    "并生成{T:j_akyrs_ghastling,C:purple}小幽灵{}",
                    "{C:red}自毁{}",
                },
            },
            j_akyrs_ghastling = {
                name = "小幽灵",
                text = {
                    "{C:mult}+#2#{}倍率",
                    "在打出{C:attention}#1#{}次出牌后",
                    "生成一个{T:j_akyrs_happy_ghast,C:purple}欢乐幽灵{}",
                    "{C:red}自毁{}",
                    "每存在一个{T:j_ice_cream,C:blue}冰淇淋{}",
                    "每次出牌减少{C:blue}1{}次额外计数",
                },
            },
            j_akyrs_happy_ghast = {
                name = "欢乐幽灵",
                text = {
                    "{X:mult,C:white}X#1#{}倍率",
                },
            },
            j_akyrs_happy_ghast_absurd = {
                name = "欢乐幽灵",
                text = {
                    "每张计分牌{C:white,X:dark_edition} ^#1# {}倍率",
                },
            },
            j_akyrs_charred_roach = {
                name = "焦黑蟑螂",
                text = {
                    "{C:red}摧毁和售出{}卡牌",
                    "给予你它们的{C:attention}烧焦{}复制品",
                },
            },
            j_akyrs_ash_joker = {
                name = "灰烬小丑",
                text = {
                    "{C:chips}+#1#{}筹码",
                    "有{C:green}#2#/#3#{}几率",
                    "在回合结束时化为灰烬",
                    "",
                    "如果概率未触发",
                    "获得{C:chips}+#4#{}筹码",
                },
            },
            j_akyrs_ash_joker_absurd = {
                name = "灰烬小丑",
                text = {
                    "{C:purple,X:edition} ^#1# {}筹码",
                    "在回合结束时",
                    "{C:attention}必定{}化为乌有",
                },
            },
            j_akyrs_yee = {
                name = "咿耶",
                text = {
                    "如果打出单词包含{C:green}一个Y{}和{C:green}两个E{}",
                    "每张计分的{C:attention}Y{}和{C:blue}E{}",
                    "获得{C:chips}+#1#{}筹码和{C:mult}+#2#{}倍率",
                    "{s:0.7,C:inactive}谁还记得这个",
                },
            },
            j_akyrs_yee_absurd = {
                name = "咿耶",
                text = {
                    "{C:attention}在出牌计分前{} 将",
                    "打出牌的{C:attention}前两个{}字母",
                    "变为{C:green}Y{}和{C:green}E{}",
                    "如果出牌{C:attention}不是{}{C:attention}高牌{}",
                    "此小丑牌获得{X:chips,C:white} X#1# {}筹码",
                    "{C:inactive}（当前{X:chips,C:white} X#2# {C:inactive}筹码）",
                    "{s:0.7,C:inactive}bobobobo bo bobo bo bobo bobobobo bo bobo YEE",
                },
            },
            j_akyrs_yee_absurd_cass_none = {
                name = "咿耶",
                text = {
                    "{C:attention}在出牌计分前{} 将",
                    "打出牌的{C:attention}前两个{}字母",
                    "变为{C:green}Y{}和{C:green}E{}",
                    "如果出牌{C:attention}不是{}{C:attention}高牌{}或{C:attention}空气{}",
                    "此小丑牌获得{X:chips,C:white} X#1# {}筹码",
                    "{C:inactive}（当前{X:chips,C:white} X#2# {C:inactive}筹码）",
                    "{s:0.7,C:inactive}bobobobo bo bobo bo bobo bobobobo bo bobo YEE",
                },
            },
            j_akyrs_chicken_jockey = {
                name = "小鸡骑士",
                text = {
                    {
                        "购买非小丑牌时{C:attention}获得{}一张{C:red}爆米花{}",
                        "{C:inactive}（必须有空位）{}",
                        "{s:0.7,C:inactive}绝对影院{}",
                    },
                },
            },
            j_akyrs_tetoris = {
                name = "Tetoris",
                text = {
                    "打出的牌会按{C:attention}相反顺序{}再次计分",
                    "{s:0.9,C:inactive,f:5}テテテテト テト テテテテトリス!{}",
                },
            },
            j_akyrs_tetoris_absurd = {
                name = "Tetoris",
                text = {
                    "每打出一张牌{C:attention}消除行数{}增加{C:attention}1{}",
                    "如果回合结束时至少消除{C:attention}4{}行",
                    "生成一张{C:dark_edition}负片{C:spectral}幻灵牌{}并将消除行数{C:attention}减少{}4{}",
                    "如果回合结束时至少消除{C:attention}160{}行",
                    "生成一张{C:dark_edition}负片{C:spectral}灵魂{}并将消除行数{C:attention}减少{}160{}",
                    "{C:inactive}（已消除行数：{X:attention,C:white}#1#{C:inactive}）",
                    "{s:0.9,C:inactive,f:5}興味がないこと本気じゃないもの全部後回しで{}",
                    "{s:0.9,C:inactive,f:5}知ってることは知らんぷり私は終わってる{}",
                },
            },
            j_akyrs_aikoyori = {
                name = "{C:dark_edition,E:akyrs_rainbow_wiggle}Aikoyori",
                text = {
                    "此{E:akyrs_obfuscate}小丑牌？{}获得的能力",
                    "取决于你安装的{C:attention}模组{}数量",
                    "{C:inactive}永恒的自我代入！",
                },
            },
            j_akyrs_mukuroju_no_hakamori = {
                name = "{f:5}躯樹の墓守",
                text = {
                    "{f:5}此小丑牌每使用一次{f:5,C:tarot}星星{}",
                    "{f:5}获得{X:mult,C:white}X#1#{f:5}倍率",
                    "{C:inactive}（{C:inactive,f:5}当前为{X:mult,C:white}X#2#{C:inactive}倍率）",
                },
            },
            j_akyrs_mukuroju_no_hakamori_absurd = {
                name = "{f:5}躯樹の墓守",
                text = {
                    "{f:5}此小丑牌每使用一次{f:5,C:tarot}星星{}",
                    "{f:5}自身倍率{X:mult,C:white,f:5}X8{f:5}",
                    "{C:inactive}（{C:inactive,f:5}当前为{X:mult,C:white}X#1#{C:inactive}倍率）",
                },
            },
            j_akyrs_emerald = {
                name = "翡翠",
                text = {
                    {
                        "此小丑牌的售价为其购买价格",
                        "加上拥有的翡翠数量之和的{X:money,C:black}X#1#{}",
                        "（{C:money}$#2#{} + {C:money}$#3#{}）",
                        "{C:inactive}（未来的更新会加入更多功能 请相信）",
                    },
                    {
                        "{C:inactive}持有此小丑牌时",
                        "{C:inactive}更容易找到另一张翡翠",
                    },
                },
            },
            j_akyrs_emerald_absurd = {
                name = "翡翠",
                text = {
                    "此小丑牌售出价格为{X:akyrs_money_x,C:akyrs_money_c}(x+#1#)^#2#{}",
                    "其中{X:akyrs_money_x,C:akyrs_money_c}x{}为其购买成本（{C:money}$#3#{}）",
                    "{C:inactive}（未来的更新会加入更多功能 请相信）",
                    "{C:inactive}持有此小丑牌会增加",
                    "{C:inactive}找到相同小丑牌的几率",
                },
            },
            j_akyrs_shimmer_bucket = {
                name = "闪烁水桶",
                text = {
                    "离开商店后",
                    "摧毁并生成{C:attention}#1#{}张小丑牌",
                    "其稀有度与此小丑牌{C:attention}左侧紧邻的{}小丑牌相同",
                    "{C:red}自毁{}",
                },
            },
            j_akyrs_space_elevator = {
                name = "太空电梯",
                text = {
                    {
                        "打出{C:attention}#1#次{C:blue}#2#{}{C:inactive}（#4#）{}",
                        "以进入下一{C:attention}阶段{}{C:inactive}（#3#/6）{}",
                        "完成一个阶段时获得一张",
                        "{C:dark_edition}负片{}{C:spectral}幻灵牌{}",
                    },
                },
            },
            j_akyrs_turret = {
                name = "炮塔",
                text = {
                    "售出此小丑牌以摧毁",
                    "其{C:attention}右侧的小丑牌{}并返还{X:money,C:black}X#2#{}",
                    "的{C:attention}售出{}金额{C:inactive}（{C:money}$#1#{C:inactive}）{}",
                    "{E:1,C:red}可无视永恒贴纸{}",
                },
            },
            j_akyrs_corkscrew = {
                name = "开瓶器",
                text = {
                    "{C:white,X:mult} X#1# {}倍率",
                    "点击出牌后{C:attention}移动自身{}",
                },
            },
            j_akyrs_corkscrew_absurd = {
                name = "开瓶器",
                text = {
                    "{C:white,X:dark_edition,E:2} ^#1# {}倍率",
                    "{C:attention}数值基于其位置{}",
                    "点击出牌后{C:attention}移动自身{}",
                    "{C:inactive}（拖拽查看数值）",
                },
            },
            j_akyrs_goodbye_sengen = {
                name = "告别宣言",
                text = {
                    "如果回合{C:attention}第一次出牌{}只有{C:attention}1张{}牌",
                    "摧毁它并生成一张{C:tarot}正义{}",
                    "{C:inactive}（必须有空位）{}",
                    "{C:inactive,f:5}引きこもり絶対ジャスティス俺の私だけの折の中で{}",
                },
            },
            j_akyrs_goodbye_sengen_absurd = {
                name = "告别宣言",
                text = {
                    "当{C:tarot}正义{}被使用时",
                    "{C:attention}高牌{}等级翻倍",
                    "{C:inactive,f:5}引きこもり絶対ジャスティス俺の私だけの折の中で{}",
                },
            },
            j_akyrs_liar_dancer = {
                name = "谎言舞者",
                text = {
                    "{C:attention}所有打出的牌{}的点数",
                    "视为同一位置{C:attention}留在手牌中{}的牌",
                },
            },
            j_akyrs_liar_dancer_absurd = {
                name = "谎言舞者",
                text = {
                    "升级{C:attention}出牌{}牌型{C:attention}之外的{}",
                    "所有{C:attention}牌型{}",
                    "{C:inactive,f:5}（踊れ 踊れ 嘘に踊れ）{}",
                },
            },
            j_akyrs_pissandshittium = {
                name = "臭臭",
                text = {
                    "告知下载地址",
                    "{X:akyrs_pissandshittium,C:white}Pissandshittium{}",
                    "{C:akyrs_pissandshittium}+#1#{}倍率",
                },
            },
            j_akyrs_pissandshittium_absurd = {
                name = "臭臭",
                text = {
                    "告知下载地址",
                    "{X:akyrs_pissandshittium,C:white}Pissandshittium{}",
                    "{X:akyrs_pissandshittium,C:white}^#1#{}倍率",
                },
            },
            j_akyrs_pandora_paradoxxx = {
                name = "潘多拉悖论",
                text = {
                    "每打出并计分{C:attention}#1#{C:inactive}（#2#）{}张",
                    "游戏牌 给予{C:attention}标准标签",
                },
            },
            j_akyrs_pandora_paradoxxx_absurd = {
                name = "潘多拉悖论",
                text = {
                    "当一张{C:attention}游戏牌{}加入牌组时",
                    "有{C:green}#1#/#2#{}几率给予{C:attention}标准标签",
                },
            },
            j_akyrs_story_of_undertale = {
                name = "传说之下故事",
                text = {
                    "在{C:attention}底注4{}及之后出现",
                    "你的行动会带来{C:attention}后果{}",
                    "{C:inactive}（屠杀路线：至少摧毁10张游戏牌）{}",
                    "{C:inactive}（中立路线：至少修改或摧毁1张游戏牌）{}",
                    "{C:inactive}（和平路线：不修改或摧毁游戏牌）{}",
                },
            },
            j_akyrs_story_of_undertale_neutral = {
                name = "传说之下故事（中立）",
                text = {
                    "回合结束时生成一张{C:red}稀有{}小丑牌",
                    "并{C:red}自毁{}",
                    "{C:inactive}（中立路线：至少修改或摧毁1张游戏牌）{}",
                },
            },
            j_akyrs_story_of_undertale_genocide = {
                name = "传说之下故事（屠杀）",
                text = {
                    "{X:mult,C:white} X#1# {}倍率",
                    "始终为{C:purple}永恒卡{}",
                    "{C:inactive}（屠杀路线：至少摧毁10张游戏牌）{}",
                },
            },
            j_akyrs_story_of_undertale_pacifist = {
                name = "传说之下故事（和平）",
                text = {
                    "回合结束时生成一张{C:red}传奇{}小丑牌",
                    "并{C:red}自毁{}",
                    "{C:inactive}（和平路线：不修改或摧毁游戏牌）{}",
                },
            },
            j_akyrs_no_hints_here = {
                name = "此处无提示",
                text = {
                    "{X:mult,C:white} X#1# {}倍率",
                    "隐藏{C:attention}所有{}提示",
                },
            },
            j_akyrs_no_hints_here_absurd = {
                name = "此处无提示",
                text = {
                    "{X:dark_edition,C:white} ^#1# {}倍率",
                    "隐藏{C:attention}所有{}提示",
                },
            },
            j_akyrs_brushing_clothes_pattern = {
                name = "面条",
                text = {
                    "将{C:attention}第一张留在手牌中的牌{}",
                    "加入出牌中",
                    "{C:inactive}（该牌会位于最左侧）",
                    "{C:inactive}面条是音游中的一种键型，玩家需要长时间按压判定键{}",
                    "{C:inactive}原文这里是指这种操作，这里把它译成一种键型名称更容易理解{}",
                },
            },
            j_akyrs_brushing_clothes_pattern_absurd = {
                name = "面条",
                text = {
                    "如果打出的牌包含{C:attention}同花{}",
                    "且其中至少有一张是{C:attention}万能牌{}",
                    "当{C:attention}万能牌{}计分时",
                    "这张小丑牌获得{X:chips,C:white}X#1#{}筹码",
                    "{C:inactive}（当前为{X:chips,C:white}X#2#{C:inactive}筹码）",
                    "{C:inactive}面条是音游中的一种键型，玩家需要长时间按压判定键{}",
                    "{C:inactive}原文这里是指这种操作，这里把它译成一种键型名称更容易理解{}"
                },
            },
            j_akyrs_you_tried = {
                name = "你尽力了",
                text = {
                    "{C:attention}防止死亡{}并",
                    "{C:red}摧毁你所有小丑牌",
                    "当前底注{C:inactive}（向上取整）减半",
                    "资金设为{C:money}$#2#",
                    "然后{E:akyrs_snaking,C:red}自毁",
                },
            },
            j_akyrs_you_tried_mp = {
                name = "你尽力了",
                text = {
                    "当输给{C:attention}非PvP{}盲注时",
                    "获得{C:money}$#2#",
                    "然后{E:akyrs_snaking,C:red}自毁",
                },
            },
            j_akyrs_you_tried_absurd = {
                name = "你尽力了",
                text = {
                    "{C:attention}防止死亡{}并",
                    "将底注设为{C:attention}#1#{}",
                    "然后{E:akyrs_snaking,C:red}自毁",
                },
            },
            j_akyrs_you_tried_absurd_mp = {
                name = "你尽力了",
                text = {
                    "{C:attention}防止死亡{}并",
                    "将生命设为{C:attention}#1#{}",
                    "然后{E:akyrs_snaking,C:red}自毁",
                },
            },
            j_akyrs_don_chan = {
                name = "咚酱",
                text = {
                    "将当前{X:chips,C:white}筹码{}的",
                    "{C:attention}#1#%{}添加到{C:white,X:mult}倍率",
                },
            },
            j_akyrs_don_chan_absurd = {
                name = "咚酱",
                text = {
                    "打出的牌{C:attention}计分{}时",
                    "将当前{X:chips,C:white}筹码{}的",
                    "{C:attention}#1#%{}添加到{C:white,X:mult}倍率",
                },
            },
            j_akyrs_katsu_chan = {
                name = "咔酱",
                text = {
                    "将当前{C:white,X:mult}倍率{}的",
                    "{C:attention}#1#%{}添加到{X:chips,C:white}筹码",
                },
            },
            j_akyrs_katsu_chan_absurd = {
                name = "咔酱",
                text = {
                    "打出的牌{C:attention}计分{}时",
                    "将当前{C:white,X:mult}倍率{}的",
                    "{C:attention}#1#%{}添加到{X:chips,C:white}筹码",
                },
            },
            j_akyrs_lagtrain = {
                name = "延迟列车",
                text = {
                    "打出的牌",
                    "获得{C:chips}+#1#{}筹码",
                },
            },
            j_akyrs_lagtrain_absurd = {
                name = "延迟列车",
                text = {
                    "如果打出的牌包含{C:attention}顺子{}",
                    "每低于#2#{C:white,X:mult}帧率{}",
                    "获得{X:chips,C:white}X#1#{}筹码",
                    "{C:inactive}（当前{X:chips,C:white} X#3# {C:inactive}筹码）",
                },
            },
            j_akyrs_bocchi = {
                name = {
                    "{f:5}後藤ひとり{}",
                    "{s:0.7}Gotoh Hitori",
                },
                text = {
                    {
                        "出牌时每持有一张{C:attention}結束バンド{}小丑牌",
                        "向手牌中添加一张带增强效果和蜡封的{C:spades}黑桃{}牌",
                    },
                },
            },
            j_akyrs_bocchi_absurd = {
                name = {
                    "{f:5}後藤ひとり{}",
                    "{s:0.7}Gotoh Hitori",
                },
                text = {
                    "如果打出的牌仅包含{C:spades}黑桃{}",
                    "每持有一张{C:attention}結束バンド{}小丑牌",
                    "此小丑牌的{C:white,X:mult}倍率{}指数增加{C:white,X:dark_edition} ^#1# {}",
                    "{C:inactive}（当前{C:white,X:mult} X#2# {C:inactive}倍率）",
                },
            },
            j_akyrs_kita = {
                name = {
                    "{f:5}喜多郁代{}",
                    "{s:0.7}Kita Ikuyo",
                },
                text = {
                    {
                        "如果出牌包含{C:attention}同花{}",
                        "且有一张{C:hearts}红桃{}花色的牌",
                        "生成{C:tarot}恋人{}",
                        "{C:inactive}（必须有空位）{}",
                    },
                },
            },
            j_akyrs_kita_absurd = {
                name = {
                    "{f:5}喜多郁代{}",
                    "{s:0.7}Kita Ikuyo",
                },
                text = {
                    "每张计分的{C:hearts}红桃{}牌",
                    "生成一张{C:dark_edition}负片{C:tarot}恋人{}",
                },
            },
            j_akyrs_ryou = {
                name = {
                    "{f:5}山田リョウ{}",
                    "{s:0.7}Yamada Ryou",
                },
                text = {
                    {
                        "每回合可{C:attention}使用{}此牌1次",
                        "立即获得{C:money}#1#{}",
                        "{C:inactive}（剩余{C:money}#2#{C:inactive} 本回合#3#）",
                    },
                },
            },
            j_akyrs_ryou_absurd = {
                name = {
                    "{f:5}山田リョウ{}",
                    "{s:0.7}Yamada Ryou",
                },
                text = {
                    "每打出{C:attention}对{C:clubs}梅花{}的{C:attention}对子{}",
                    "负债上限提高至{C:red}-$#1#{}",
                    "负债限额乘以{X:red,C:white}X#2#{}",
                },
            },
            j_akyrs_nijika = {
                name = {
                    "{f:5}伊地知虹夏{}",
                    "{s:0.7}Ijichi Nijika",
                },
                text = {
                    {
                        "如果{C:attention}出牌{}包含{C:attention}顺子{}",
                        "且有一张{C:diamonds}方片{}花色的牌",
                        "生成一张对应最常用牌型的",
                        "{C:dark_edition}负片{}{C:planet}星球牌{}",
                    },
                },
            },
            j_akyrs_nijika_absurd = {
                name = {
                    "{f:5}伊地知虹夏{}",
                    "{s:0.7}Ijichi Nijika",
                },
                text = {
                    "如果{C:attention}出牌{}包含{C:attention}顺子{}",
                    "每打出一张{C:diamonds}方片{}牌",
                    "生成一张你最常出的牌型",
                    "对应的{C:dark_edition}负片{C:planet}星球牌{}",
                },
            },
            j_akyrs_blue_portal = {
                name = "蓝色传送门",
                text = {
                    {
                        "{C:white,X:chips} X#1# {}筹码",
                        "购买需要{C:attention}2{}个空闲小丑牌槽位",
                        "购买时生成对应的",
                        "{C:attention}橙色传送门{}",
                    },
                },
            },
            j_akyrs_orange_portal = {
                name = "橙色传送门",
                text = {
                    {
                        "{C:white,X:mult} X#1# {}倍率",
                    },
                },
            },
            j_akyrs_g = {
                name = {
                    "超酷的邪恶蓝色骷髅头",
                    "旁边放着键盘",
                    "其中\"g\"键",
                    "被高亮显示",
                },
                text = {
                    "如果第一次出牌是单词",
                    "且以{C:white,X:blue}g{}开头",
                    "{E:akyrs_shrivel,C:red}摧毁所有打出的牌{}",
                    "并将手牌中所有牌增强为{C:blue}闪电牌{}",
                },
            },
            j_akyrs_d_se_dab = {
                name = "D se Dab",
                text = {
                    "当至少打出{C:attention}3种不同的{}增强牌",
                    "手牌和打出的牌中带有字母{C:attention}D{}",
                    "永久{C:attention}获得{}{C:white,X:chips} X#1# {}筹码",
                    "{C:inactive,s:0.8}酷炫衣着+态度+新手势",
                },
            },
            j_akyrs_c = {
                name = "c",
                text = {
                    "带有字母{C:attention}C{}的牌",
                    "计分时每张给予{C:chips}+#1#{}筹码",
                    "{C:inactive,s:0.8}cue Tobu - Cloud 9",
                },
            },
            j_akyrs_koshitan = {
                name = {
                    "{f:5}虎視虎子{}",
                    "{s:0.7}Koshi Torako",
                },
                text = {
                    "当盲注被{C:attention}选中时",
                    "扣除{C:money}$#1#{}并添加",
                    "{C:money}$#2#{}到此小丑牌的",
                    "{C:money}售出价值{}",
                },
            },
            j_akyrs_nokotan = {
                name = {
                    "{f:5}鹿乃子のこ{}",
                    "{s:0.7}Shikanoko Noko",
                },
                text = {
                    "这张小丑牌的{C:mult}倍率{}等于",
                    "其{C:attention}左右紧邻的{}小丑牌",
                    "{C:attention}合计{}售出价值的{C:mult}#1#倍{}",
                    "{C:inactive}（当前{C:mult}+#2#{C:inactive}倍率）",
                },
            },
            j_akyrs_koshian = {
                name = {
                    "{f:5}虎視餡子{}",
                    "{s:0.7}Koshi Anko",
                },
                text = {
                    "此小丑牌的{C:attention}售出价值{}等于",
                    "概率的{C:green}分子与分母之积{}",
                    "基础几率为{C:attention}2/2",
                    "{C:inactive}（当前{C:green}#1#/#2#{C:inactive}）",
                },
            },
            j_akyrs_bashame = {
                name = {
                    "{f:5}馬車芽めめ{}",
                    "{s:0.7}Bashame Meme",
                },
                text = {
                    "当一张{C:attention}华盖牌{}计分时",
                    "此小丑牌获得其{C:attention}售出价值{}的",
                    "{C:money}$#1#{}",
                },
            },
            j_akyrs_e = {
                name = "E",
                text = {
                    "带有字母{C:attention}E{}的牌",
                    "计分时每张给予{C:mult}+#1#{}倍率",
                    "{C:inactive,s:0.8}为什么他们又把Markiplier的脸放在法夸德勋爵上",
                },
            },
            j_akyrs_catchphrase = {
                name = "口头禅",
                text = {
                    "留在手牌中带有字母{C:attention}H{}的牌",
                    "计分时每张给予{C:mult}+#1#{}倍率",
                    "{C:inactive,s:0.8}为什么他们又把Markiplier的脸放在法夸德勋爵上",
                },
            },
            j_akyrs_furina = {
                name = "水之神芙宁娜",
                text = {
                    "{C:attention}出牌{}时",
                    "获得{C:red}+#1#{}次弃牌",
                },
            },
            j_akyrs_gift_voucher = {
                name = "礼品券",
                text = {
                    "商店中{C:attention}#1#{}免费",
                    "回合结束时{C:attention}变为{}",
                    "另一种消耗牌类型",
                },
            },
            j_akyrs_press_f = {
                name = "按下{X:grey}F{}表示敬意",
                text = {
                    "如果{C:attention}出牌{}包含",
                    "单个字母{C:attention}F{}，摧毁它并",
                    "生成一张{C:akyrs_umbral_p,X:akyrs_umbral_y}暗影{}牌",
                    "{C:inactive}（必须有空位）",
                },
            },
            j_akyrs_ojisan_koubun = {
                name = {
                    "{f:5}お返事まだカナ？(水)おじさん構文{f:akyrs_NotoEmoji}😁❗",
                    "{s:0.7}大叔体文本",
                },
                text = {
                    "如果{C:attention}出牌{}的{C:attention}首字母{}",
                    "与上次打出{C:attention}单词{}的",
                    "{C:attention}尾字母{}匹配{C:inactive}（#1#）",
                    "生成一个{C:attention}双倍标签",
                },
            },
            j_akyrs_sushi = {
                name = { "寿司" },
                text = {
                    "{C:chips}+#1#{}筹码",
                    "当你从商店{C:attention}购买{}一张小丑牌时",
                    "{C:chips}#2#{}筹码",
                },
            },
            j_akyrs_biochamber = {
                name = {
                    "生物舱"
                },
                text = {
                    "出牌时",
                    "生成一份{C:attention}营养剂",
                    "{C:inactive}（必须有空位）",
                },
            },
            j_akyrs_nutrient = {
                name = { "营养剂" },
                text = {
                    "{C:white,X:chips}X#1#{}筹码",
                    "回合结束时",
                    "{C:white,X:chips}-X#2#{}筹码",
                },
            },
            j_akyrs_shine_bright_like_a_diamond = {
                name = { "如钻石般闪耀" },
                text = {
                    "将一张永久复制的",
                    "{C:diamonds}方片{}{C:attention}A{}",
                    "添加到每次{C:attention}出牌{}中",
                },
            },
            j_akyrs_so_close = {
                name = { "近在咫尺" },
                text = {
                    "如果打出的牌包含{C:attention}两对{}",
                    "每张留在手牌中的牌",
                    "添加盲注要求分数的{C:purple}#1#%{}到得分中",
                },
            },
            j_akyrs_snow_pea = {
                name = { "寒冰射手" },
                text = {
                    "如果出牌中{C:attention}没有非{C:clubs}梅花{}牌",
                    "{C:white,X:purple}X#1#{}分数",
                },
            },
            j_akyrs_konton_boogie = {
                name = {
                    "{f:5}混沌ブギ",
                    "混沌布吉",
                },
                text = {
                    {
                        "每张未计分牌使此小丑牌",
                        "获得{C:white,X:mult} X#1# {}倍率",
                    },
                    {
                        "如果出牌中没有未计分牌",
                        "此小丑牌失去{C:white,X:mult} X#2# {}倍率",
                    },
                    {
                        "{C:inactive}（当前{C:white,X:mult} X#3# {C:inactive}倍率）",
                    },
                },
            },
            j_akyrs_yamada_perfect = {
                name = {
                    "{f:5}山田PERFECT",
                    "Yamada Perfect",
                },
                text = {
                    {
                        "如果出牌包含{C:attention}同花{}",
                        "每张计分牌使此小丑牌获得{C:white,X:chips} X#1# {}筹码",
                    },
                    {
                        "每打出1张{V:1}#4#{}牌",
                        "此小丑牌改为失去{C:white,X:chips} X#2# {}筹码",
                        "{C:inactive}花色每次出牌后改变",
                    },
                    {
                        "{C:inactive}（当前{C:white,X:chips} X#3# {C:inactive}筹码）",
                    },
                },
            },
            j_akyrs_trend_angelina = {
                name = {
                    "{f:5}流行アンジェリーナ",
                    "流行安吉丽娜",
                },
                text = {
                    {
                        "如果出牌包含{C:attention}顺子{}",
                        "此小丑牌获得{C:white,X:purple} X#1# {}分数",
                    },
                    {
                        "计分牌型中每有1个{C:attention}重复点数{}",
                        "此小丑牌失去{C:white,X:purple} X#2# {}分数",
                    },
                    {
                        "{C:inactive}（当前{C:white,X:purple} X#3# {C:inactive}分数）",
                    },
                },
            },
            j_akyrs_gappie = {
                name = { "加比" },
                text = {
                    {
                        "如果剩余{C:blue}1{}次出牌和{C:red}0{}次弃牌",
                        "{C:attention}抽取{}牌组中所有剩余卡牌",
                        "并使此小丑牌获得{C:white,X:mult} X#2# {}倍率",
                        "{C:inactive}（当前{C:white,X:mult} X#1# {C:inactive}倍率）",
                    },
                },
            },
            j_akyrs_xaleidoscopix = {
                name = {
                    "{f:5}Xaleid◆scopiX{}",
                    "{s:0.7}xi{}",
                },
                text = {
                    {
                        "每张打出的{C:diamonds}方片{}给予{X:chips,C:white} X#1# {}筹码",
                        "每打出#2#张{C:inactive}（#3#）{}{C:diamonds}方片{}",
                        "此小丑牌获得{X:chips,C:white} X#4# {}筹码",
                    },
                },
            },
            j_akyrs_butcher_vanity = {
                name = {
                    "BUTCHER VANITY",
                    "{s:0.7}FLAVOR FOLEY{}",
                },
                text = {
                    {
                        "打出的{C:attention}人头牌{}会分裂为",
                        "{C:attention}纯净点数{}牌和{C:attention}纯净花色{}牌",
                        "留在手牌中的纯净{C:attention}人头牌{}",
                        "给予{X:mult,C:white} X#1# {}倍率",
                    },
                },
            },
            j_akyrs_deck_shovel = {
                name = { "牌组铲" },
                text = {
                    {
                        "抽到{C:attention}新牌{}时自动弃掉",
                        "本次出牌中已经弃过的{C:attention}点数{}",
                        "和{C:attention}花色{}且不消耗弃牌次数",
                    },
                },
            },
            j_akyrs_mikudashi = {
                name = {
                    "{f:5}ミクだし",
                    "{s:0.7}[Under My Heel (MIKU dashi)] by hya",
                },
                text = {
                    {
                        "每张计分的{C:hearts}红桃{}给予{X:chips,C:white} X#1# {}筹码",
                        "{C:hearts}红桃{}无法被{C:red}弃掉{}",
                    },
                },
            },
            j_akyrs_companion_cube = {
                name = { "伙伴方块" },
                text = {
                    {
                        "{C:hearts}红桃{}牌变为{C:attention}灰烬牌{}",
                        "{C:attention}灰烬牌{}给予{C:mult}+#1#{}倍率",
                    },
                },
            },
            j_akyrs_edge = {
                name = { "EDGE Extended" },
                text = {
                    {
                        "每次抽牌时为1张{C:attention}随机卡牌{}",
                        "添加{C:dark_edition}多彩{}版本",
                        "前提是手牌中没有{C:dark_edition}多彩{}卡牌",
                    },
                },
            },
            j_akyrs_7wonders = {
                name = {
                    "7大奇迹",
                    "{s:0.8}Sakuzyo",
                },
                text = {
                    {
                        "本回合牌组中其他所有{C:attention}7{}都计分后",
                        "最后1张计分的{C:attention}7{}给予{X:purple,C:white} X#1# {}分数",
                    },
                },
            },
            j_akyrs_sulfur_cube = {
                name = { "硫磺方块" },
                text = {
                    {
                        "复制收藏中1张{C:attention}随机小丑牌{}的能力",
                        "能力在{C:attention}回合结束时{}改变",
                    },
                    {
                        "可花费{C:money}#1#{}重掷此能力",
                    },
                },
            },
            j_akyrs_aether_portal = {
                name = "以太传送门",
                text = {
                    "选择盲注时",
                    "其{C:attention}左侧的小丑牌{}",
                    "获得一个{C:attention}新{}版本",
                    "有{C:green}#1#/#2#{}几率在此过程中",
                    "{C:red}摧毁{}此传送门",
                    "{C:inactive}（所有版本权重相等）",
                },
            },
            j_akyrs_chicken_jockey_absurd = {
                name = "鸡骑士",
                text = {
                    "在此小丑牌存在时获得的每张{C:red}爆米花{}",
                    "起始为{C:red}#4#{}倍率 改为每回合减少{C:red}-#3#{}倍率",
                    "每吃掉一张{C:red}爆米花{}获得{X:dark_edition,C:white}^#1#{}倍率",
                    "{C:inactive}（当前{X:dark_edition,C:white} ^#2# {C:inactive}倍率）",
                    "{s:0.7,C:inactive}他们想让我和鸡打架",
                    "当盲注被选中时",
                    "生成一张{C:red}爆米花{}",
                    "{C:inactive}（必须有空位）",
                    "{s:0.7,C:inactive}这才叫电影！",
                },
            },
        },
        Judgement = {
            judgement_akyrs_none_none = {
                name = "无",
                text = {
                    "游戏牌拥有{C:white,X:green}#1#{}点生命",
                    "小丑牌拥有{C:white,X:green}#2#{}点生命",
                },
            },
            judgement_akyrs_none_normal = {
                name = "无",
                text = {
                    "{C:white,X:green}#1#{}点生命",
                },
            },
            judgement_akyrs_none_kaleidoscope = {
                name = "无",
                text = {
                    "{C:white,X:blue}#1#{}点生命",
                },
            },
            judgement_akyrs_miss_none = {
                name = "失误",
                text = {
                    "游戏牌拥有{C:white,X:green}#1#{}点生命",
                    "小丑牌拥有{C:white,X:green}#2#{}点生命",
                },
            },
            judgement_akyrs_miss_normal = {
                name = "失误",
                text = {
                    "{C:white,X:green}#1#{}点生命",
                },
            },
            judgement_akyrs_miss_kaleidoscope = {
                name = "失误",
                text = {
                    "{C:white,X:blue}#1#{}点生命",
                },
            },
            judgement_akyrs_good_none = {
                name = "良好",
                text = {
                    "游戏牌拥有{C:white,X:green}#1#{}点生命",
                    "小丑牌拥有{C:white,X:green}#2#{}点生命",
                },
            },
            judgement_akyrs_good_normal = {
                name = "良好",
                text = {
                    "{C:white,X:green}#1#{}点生命",
                },
            },
            judgement_akyrs_good_kaleidoscope = {
                name = "良好",
                text = {
                    "{C:white,X:blue}#1#{}点生命",
                },
            },
            judgement_akyrs_great_none = {
                name = "优秀",
                text = {
                    "游戏牌拥有{C:white,X:green}#1#{}点生命",
                    "小丑牌拥有{C:white,X:green}#2#{}点生命",
                },
            },
            judgement_akyrs_great_normal = {
                name = "优秀",
                text = {
                    "{C:white,X:green}#1#{}点生命",
                },
            },
            judgement_akyrs_great_kaleidoscope = {
                name = "优秀",
                text = {
                    "{C:white,X:blue}#1#{}点生命",
                },
            },
            judgement_akyrs_perfect_none = {
                name = "完美",
                text = {
                    "游戏牌拥有{C:white,X:green}#1#{}点生命",
                    "小丑牌拥有{C:white,X:green}#2#{}点生命",
                },
            },
            judgement_akyrs_perfect_normal = {
                name = "完美",
                text = {
                    "{C:white,X:green}#1#{}点生命",
                },
            },
            judgement_akyrs_perfect_kaleidoscope = {
                name = "完美",
                text = {
                    "{C:white,X:blue}#1#{}点生命",
                },
            },
            judgement_akyrs_critical_perfect_none = {
                name = "极致完美",
                text = {
                    "游戏牌拥有{C:white,X:green}#1#{}点生命",
                    "小丑牌拥有{C:white,X:green}#2#{}点生命",
                },
            },
            judgement_akyrs_critical_perfect_normal = {
                name = "极致完美",
                text = {
                    "{C:white,X:green}#1#{}点生命",
                },
            },
            judgement_akyrs_critical_perfect_kaleidoscope = {
                name = "极致完美",
                text = {
                    "{C:white,X:blue}#1#{}点生命",
                },
            },
        },
        Partner = {
            pnr_akyrs_aikoyori = {
                name = "小Aikoyori",
                text = {
                    "重新触发{C:attention}每张{}牌{C:attention}#1#{}次",
                },
                unlock = {
                    "使用{C:attention}Aikoyori",
                    "在{C:attention}金注{}难度",
                    "获胜",
                },
            },
        },
        Akyrs_Dialog = {
            akyrs_balance_dialog_intro = {
                name = "",
                text = {
                    "你好！感谢并欢迎来到{E:akyrs_rainbow_wiggle}Aikoyori的恶作剧{}",
                    "我是{E:2,C:dark_edition}Aikoyori{} 我将引导你完成",
                    "一些必要的设置 让我们开始吧",
                },
            },
            akyrs_balance_dialog_intro_again = {
                name = "",
                text = {
                    "又见面了！由于你之前的",
                    "{E:akyrs_rainbow_wiggle}Aikoyori的恶作剧{}游玩",
                    "我检测到一些需要处理的{E:1,C:attention}更改{}",
                    "让我们把它解决掉吧",
                },
            },
            akyrs_balance_dialog_cryptid = {
                name = "",
                text = {
                    "嗯...看起来{E:2,C:blue}Cryptid{}已安装",
                    "我将应用{E:1,C:red}荒诞{}平衡性",
                    "如果你想改为{E:2,C:green}适中{}",
                    "可以随时在模组配置中更改",
                },
            },
            akyrs_balance_dialog_playbook = {
                name = "",
                text = {
                    "哦哇！看起来{E:2,C:dark_edition}Playbook{}已安装",
                    "我将应用{E:1,C:red}荒诞{}平衡性",
                    "如果你想改为{E:2,C:green}适中{}",
                    "可以随时在模组配置中更改",
                },
            },
            akyrs_balance_dialog_multiplayer_initialise = {
                name = "",
                text = {
                    "嗯？{E:2,C:dark_edition}Balatro Multiplayer{}已安装",
                    "由于主场优势原因，我将把游戏",
                    "设置为{E:2,C:green}适中{}平衡性",
                    "在{E:2,C:dark_edition}Balatro Multiplayer{}激活期间",
                    "你将无法更改它",
                    "一些内容也将{E:2,C:dark_edition}不可用{}",
                },
            },
            akyrs_balance_dialog_multiplayer_start_from_already_set_profile = {
                name = "",
                text = {
                    "看起来{E:2,C:dark_edition}Balatro Multiplayer{}",
                    "在某个时间点安装到这个{E:1,C:red}荒诞{}平衡性的存档文件上",
                    "由于主场优势原因，我不得不将",
                    "游戏设置为{E:2,C:green}适中{}平衡性",
                    "在{E:2,C:dark_edition}Balatro Multiplayer{}激活期间",
                    "你将无法更改它",
                    "一些内容也将{E:2,C:dark_edition}不可用{}",
                },
            },
            akyrs_balance_dialog_details = {
                name = "",
                text = {
                    "此模组包含{E:2,C:green}适中{}平衡性",
                    "和{E:1,C:red}荒诞{}平衡性",
                    "- {E:2,C:green}适中{} - 标准体验",
                    "平衡性贴近原版但更独特",
                    "- {E:1,C:red}荒诞{}（需要Talisman）- 数值崩坏",
                    "更多特殊能力、更疯狂的效果、更严重的卡顿",
                    "{C:inactive}--------------------------------------------------------",
                    "你可以随时在模组设置中更改这些",
                },
            },
        },
        Other = {
            akyrs_self_destructs = {
                name = "自毁",
                text = {
                    "回合结束时",
                    "{C:red}自毁{}",
                },
            },
            akyrs_sigma = {
                name = "西格玛",
                text = {
                    "{C:red}无法移除{}且",
                    "{C:red}不可摧毁{}",
                    "{C:inactive,s:0.8}怎么把他弄走",
                },
            },
            akyrs_oxidising = {
                name = "氧化",
                text = {
                    "{C:red}#1#%{}几率不触发",
                    "在{C:attention}#3#{}#4#后变为{C:attention}#2#{}{C:inactive}（+#5#%）{}",
                },
            },
            akyrs_oxidising_full = {
                name = "氧化",
                text = {
                    "{C:red}#1#%{}几率不触发",
                },
            },
            akyrs_attention = {
                name = "注意力",
                text = {
                    "{C:red}无法被弃掉{}",
                    "{C:attention}必须被打出{}",
                    "打出后{C:red}自毁{}",
                },
            },
            akyrs_concealed = {
                name = "隐匿",
                text = {
                    "此卡牌能力{C:red}总是隐藏{}",
                },
            },
            akyrs_crystalised = {
                name = "结晶化",
                text = {
                    "打出时{C:red}不得分{}",
                    "打出时{C:attention}移除此{}贴纸",
                },
            },
            akyrs_latticed = {
                name = "晶格化",
                text = {
                    "{C:red}无法{}通过正常方式售出",
                },
            },
            akyrs_sus = {
                name = "可疑",
                text = {
                    "回合结束时",
                    "{C:red}随机{}改变",
                    "{C:attention}花色{}或{C:attention}点数{}",
                },
            },
            akyrs_sale = {
                name = "九折",
                text = {
                    "售价无法改变",
                },
            },
            akyrs_carmine_seal = {
                name = "胭脂红蜡封",
                text = {
                    "在回合{C:attention}第一次出牌{}时",
                    "总是未削弱",
                },
            },
            akyrs_neon_seal = {
                name = "霓虹蜡封",
                text = {
                    "如果此牌被打出但{C:attention}未计分{}",
                    "生成一张{C:akyrs_umbral_p,X:akyrs_umbral_y}暗影{}牌",
                    "{C:inactive}（必须有空位）",
                },
            },
            akyrs_twin_seal = {
                name = "双生蜡封",
                text = {
                    "计分时复制一张{C:attention}随机{}小丑牌的",
                    "{C:attention}主要{}能力",
                    "{C:inactive}（不会复制每张卡的能力）{}",
                },
            },
            akyrs_fault_seal = {
                name = "断层蜡封",
                text = {
                    "如果打出的所有牌都有{C:attention}断层蜡封{}",
                    "有{C:green}1/x{C:green,E:akyrs_exponent,s:0.7}2{C:green}几率{}重新触发{C:attention}x{}次",
                    "其中{C:attention}x{}为打出牌的数量",
                    "{C:inactive}（当前{C:green}#1#/#2#{C:inactive} -> {C:attention}#3#{C:inactive}次）",
                },
            },
            akyrs_deformed_seal = {
                name = "畸形蜡封",
                text = {
                    "打出时生成一张此牌的",
                    "{C:attention}自毁{}复制品",
                    "并添加到{C:attention}出牌{}中",
                },
            },
            akyrs_chip_mult_xchip_xmult = {
                name = "给予",
                text = {
                    "每张计分牌",
                    "{C:chips}+#1#{}筹码{C:mult}+#2#{}倍率",
                    "{X:chips,C:white} X#3# {}筹码{X:mult,C:white} X#4# {}倍率",
                },
            },
            akyrs_gain_chip_mult_xchip_xmult = {
                name = "给予",
                text = {
                    "小丑牌获得",
                    "{C:chips}+#1#{}筹码{C:mult}+#2#{}倍率",
                    "{X:chips,C:white} X#3# {}筹码{X:mult,C:white} X#4# {}倍率",
                },
            },
            akyrs_tsunagite_scores = {
                name = "总计",
                text = {
                    "当前总计",
                    "{s:1.2,C:attention}#1#{}",
                },
            },
            akyrs_tsunagite_name = {
                name = "名称",
                text = {
                    "{s:1.5}Tsunagite",
                    "{C:inactive,s:0.9}（Tsu-nah-gi-teh）",
                },
            },
            akyrs_hardcore_challenge_locked = {
                name = "未解锁",
                text = {
                    "赢得一局挑战赛",
                    "以解锁硬核挑战模式",
                },
            },
            undiscovered_alphabet = {
                name = "未发现",
                text = {
                    "在非预设局的字母模式中",
                    "购买或使用此卡牌",
                    "以了解其效果",
                },
            },
            undiscovered_umbral = {
                name = "未发现",
                text = {
                    "在非预设局中",
                    "购买或使用",
                    "此卡牌以了解",
                    "其效果",
                },
            },
            undiscovered_bet = {
                name = "未发现",
                text = {
                    "在非预设局中",
                    "兑换此卡牌以了解",
                    "其效果",
                },
            },
            undiscovered_replicant = {
                name = "未发现",
                text = {
                    "在非预设局中",
                    "购买或使用",
                    "此卡牌以了解",
                    "其效果",
                },
            },
            undiscovered_enchantment = {
                name = "未发现",
                text = {
                    "在非预设局中获得附魔书",
                    "或使用此附魔为卡牌附魔",
                    "以了解其效果",
                },
            },
            undiscovered_scenario = {
                name = "未发现",
                text = {
                    "在非预设局中持有",
                    "或开始此情境",
                    "以了解其效果",
                },
            },
            pinned_left = {
                name = "固定",
                text = {
                    "此卡牌保持在",
                    "最左侧位置",
                    "固定不动",
                },
            },
            akyrs_playing_card_suit = {
                text = {
                    "{V:1}#2#",
                },
            },
            akyrs_playing_card_rank = {
                text = {
                    "{C:light_black}#1#",
                },
            },
            akyrs_no_rank = {
                text = { "无点数" },
            },
            akyrs_no_suit = {
                text = { "无花色" },
            },
            akyrs_perma_score = {
                text = {
                    "{C:purple}#1#{}分数",
                },
            },
            akyrs_perma_h_score = {
                text = {
                    "如果留在手牌中{C:purple}#1#{}分数",
                },
            },
            akyrs_perma_xscore = {
                text = {
                    "{X:purple,C:white}X#1#{}分数",
                },
            },
            akyrs_perma_h_xscore = {
                text = {
                    "如果留在手牌中{X:purple,C:white}X#1#{}分数",
                },
            },
            -- 补充包
            p_akyrs_letter_pack_normal = {
                name = "字母包",
                text = {
                    "从最多{C:attention}#2#{C:attention}字母牌{}中",
                    "选择{C:attention}#1#{}张",
                    "保留供后续使用",
                },
            },
            p_akyrs_letter_pack_jumbo = {
                name = "巨型字母包",
                text = {
                    "从最多{C:attention}#2#{C:attention}字母牌{}中",
                    "选择{C:attention}#1#{}张",
                    "保留供后续使用",
                },
            },
            p_akyrs_letter_pack_mega = {
                name = "超级字母包",
                text = {
                    "从最多{C:attention}#2#{C:attention}字母牌{}中",
                    "选择{C:attention}#1#{}张",
                    "保留供后续使用",
                },
            },
            p_akyrs_umbral_pack_normal = {
                name = "暗影包",
                text = {
                    "从最多{C:attention}#2#{C:akyrs_umbral_p,X:akyrs_umbral_y}暗影{}牌中",
                    "选择{C:attention}#1#{}张",
                    "即选即用",
                },
            },
            p_akyrs_umbral_pack_jumbo = {
                name = "巨型暗影包",
                text = {
                    "从最多{C:attention}#2#{C:akyrs_umbral_p,X:akyrs_umbral_y}暗影{}牌中",
                    "选择{C:attention}#1#{}张",
                    "即选即用",
                },
            },
            p_akyrs_umbral_pack_mega = {
                name = "超级暗影包",
                text = {
                    "从最多{C:attention}#2#{C:akyrs_umbral_p,X:akyrs_umbral_y}暗影{}牌中",
                    "选择{C:attention}#1#{}张",
                    "即选即用",
                },
            },
            p_akyrs_replica_pack_normal = {
                name = "仿生包",
                text = {
                    "从最多{C:attention}#2#{C:akyrs_replicant_o}仿生{}牌中",
                    "选择{C:attention}#1#{}张",
                    "即选即用",
                },
            },
            p_akyrs_replica_pack_jumbo = {
                name = "巨型仿生包",
                text = {
                    "从最多{C:attention}#2#{C:akyrs_replicant_o}仿生{}牌中",
                    "选择{C:attention}#1#{}张",
                    "即选即用",
                },
            },
            p_akyrs_replica_pack_mega = {
                name = "超级仿生包",
                text = {
                    "从最多{C:attention}#2#{C:akyrs_replicant_o}仿生{}牌中",
                    "选择{C:attention}#1#{}张",
                    "即选即用",
                },
            },
            akyrs_copper_sticker = {
                name = "铜色标贴",
                text = {
                    "使用此小丑牌",
                    "在{C:attention}铜注{}难度",
                    "获胜",
                },
            },
            akyrs_inner_sticker = {
                name = "内层标贴",
                text = {
                    "使用此小丑牌",
                    "在{C:attention}内层注{}难度",
                    "获胜",
                },
            },
            akyrs_outer_sticker = {
                name = "外层标贴",
                text = {
                    "使用此小丑牌",
                    "在{C:attention}外层注{}难度",
                    "获胜",
                },
            },
            akyrs_lime_sticker = {
                name = "青柠标贴",
                text = {
                    "使用此小丑牌",
                    "在{C:attention}青柠注{}难度",
                    "获胜",
                },
            },
            akyrs_lemon_sticker = {
                name = "柠檬标贴",
                text = {
                    "使用此小丑牌",
                    "在{C:attention}柠檬注{}难度",
                    "获胜",
                },
            },
            akyrs_turquoise_sticker = {
                name = "绿松石标贴",
                text = {
                    "使用此小丑牌",
                    "在{C:attention}绿松石注{}难度",
                    "获胜",
                },
            },
            akyrs_amethyst_sticker = {
                name = "紫水晶标贴",
                text = {
                    "使用此小丑牌",
                    "在{C:attention}紫水晶注{}难度",
                    "获胜",
                },
            },
            akyrs_wooden_sticker = {
                name = "木纹标贴",
                text = {
                    "使用此小丑牌",
                    "在{C:attention}木纹注{}难度",
                    "获胜",
                },
            },
            akyrs_bismuth_sticker = {
                name = "铋标贴",
                text = {
                    "使用此小丑牌",
                    "在{C:attention}铋注{}难度",
                    "获胜",
                },
            },
            akyrs_high_contrast_sticker = {
                name = "高对比度标贴",
                text = {
                    "使用此小丑牌",
                    "在{C:attention}高对比度注{}难度",
                    "获胜",
                },
            },
            akyrs_hydrogel_sticker = {
                name = "水凝胶标贴",
                text = {
                    "使用此小丑牌",
                    "在{C:attention}水凝胶注{}难度",
                    "获胜",
                },
            },
            akyrs_spotify_sticker = {
                name = "Spotify标贴",
                text = {
                    "使用此小丑牌",
                    "在{C:attention}Spotify注{}难度",
                    "获胜",
                },
            },
            akyrs_aluminium_sticker = {
                name = "铝标贴",
                text = {
                    "使用此小丑牌",
                    "在{C:attention}铝注{}难度",
                    "获胜",
                },
            },
            akyrs_steam_sticker = {
                name = "钢标贴",
                text = {
                    "使用此小丑牌",
                    "在{C:attention}蒸汽注{}难度",
                    "获胜",
                },
            },
            akyrs_netherite_sticker = {
                name = "下界合金标贴",
                text = {
                    "使用此小丑牌",
                    "在{C:attention}下界合金注{}难度",
                    "获胜",
                },
            },
            akyrs_doom_sticker = {
                name = "末日标贴",
                text = {
                    "使用此小丑牌",
                    "在{C:attention}末日注{}难度",
                    "获胜",
                },
            },
        },
        Planet = {
            c_akyrs_p_ara = {
                name = "天坛座",
                text = {
                    "{S:0.8}（{S:0.8,V:1}等级#1#{S:0.8}）{}升级",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{}倍率和",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_akyrs_p_crux = {
                name = "南十字座",
                text = {
                    "{S:0.8}（{S:0.8,V:1}等级#1#{S:0.8}）{}升级",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{}倍率和",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_akyrs_p_indus = {
                name = "印第安座",
                text = {
                    "{S:0.8}（{S:0.8,V:1}等级#1#{S:0.8}）{}升级",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{}倍率和",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_akyrs_p_puppis = {
                name = "船尾座",
                text = {
                    "{S:0.8}（{S:0.8,V:1}等级#1#{S:0.8}）{}升级",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{}倍率和",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_akyrs_p_lacerta = {
                name = "蝎虎座",
                text = {
                    "{S:0.8}（{S:0.8,V:1}等级#1#{S:0.8}）{}升级",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{}倍率和",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_akyrs_p_eridanus = {
                name = "波江座",
                text = {
                    "{S:0.8}（{S:0.8,V:1}等级#1#{S:0.8}）{}升级",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{}倍率和",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_akyrs_p_reticulum = {
                name = "网罟座",
                text = {
                    "{S:0.8}（{S:0.8,V:1}等级#1#{S:0.8}）{}升级",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{}倍率和",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_akyrs_p_horologium = {
                name = "时钟座",
                text = {
                    "{S:0.8}（{S:0.8,V:1}等级#1#{S:0.8}）{}升级",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{}倍率和",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_akyrs_p_telescopium = {
                name = "望远镜座",
                text = {
                    "{S:0.8}（{S:0.8,V:1}等级#1#{S:0.8}）{}升级",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{}倍率和",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_akyrs_p_microscopium = {
                name = "显微镜座",
                text = {
                    "{S:0.8}（{S:0.8,C:red}等级???{S:0.8}）{}升级",
                    "{C:attention}#1#",
                    "{C:attention}和更长的手牌",
                },
            },
            c_akyrs_planet_bishop_ring = {
                name = "主教之环",
                text = {
                    "{S:0.8}（{S:0.8,C:red}等级#1#{S:0.8}）{}升级",
                    "{C:attention}纯净牌型",
                    "倍率：{C:mult}#2#{}{C:attention}+#3#",
                },
            },
        },
        Scenario = {
            sc_akyrs_genesis = {
                name = "创世",
                text = {
                    "清除{C:akyrs_scenario_dark_yellow}浅黄{}情境",
                },
            },
            sc_akyrs_day = {
                name = "白昼",
                text = {
                    "{C:mult}+#1#{}倍率",
                },
            },
            sc_akyrs_night = {
                name = "黑夜",
                text = {
                    "{C:chips}+#1#{}筹码",
                },
            },
            sc_akyrs_sunrise = {
                name = "日出",
                text = {
                    "{X:mult,C:white}X#1#{}倍率",
                },
            },
            sc_akyrs_sunset = {
                name = "日落",
                text = {
                    "每次出牌获得{C:money}#1#{}",
                },
            },
            sc_akyrs_high_noon = {
                name = "正午",
                text = {
                    "选择盲注时生成一张{C:attention}小丑牌{}",
                    "{C:inactive}（必须有空位）",
                },
            },
            sc_akyrs_eclipse = {
                name = "日食",
                text = {
                    "{X:blind,C:white}X#1#{}盲注要求分数",
                },
            },
            sc_akyrs_yellow_hatena = {
                name = "随机黄色",
                text = {
                    "随机选取一个{X:akyrs_scenario_yellow}黄色{}情境",
                },
            },
            sc_akyrs_clear = {
                name = "放晴",
                text = {
                    "清除{X:akyrs_scenario_dark_yellow,C:akyrs_scenario_yellow}深黄色{}情境",
                },
            },
            sc_akyrs_cloudy = {
                name = "多云",
                text = {
                    "每次出牌获得{C:money}#1#{}",
                },
            },
            sc_akyrs_rain = {
                name = "降雨",
                text = {
                    "出牌后{C:red}#1#{}次弃牌",
                    "且手牌上限{C:attention}#2#{} 直至回合结束",
                },
            },
            sc_akyrs_snow = {
                name = "降雪",
                text = {
                    "{X:chips,C:white}X#1#{}筹码",
                    "出牌后{C:blue}#2#{}次出牌",
                    "直至回合结束",
                },
            },
            sc_akyrs_hail = {
                name = "冰雹",
                text = {
                    "每张计分牌给予{C:chips}#1#{}筹码",
                    "和{X:chips,C:white} X#2#{}筹码",
                },
            },
            sc_akyrs_thunder = {
                name = "雷暴",
                text = {
                    "手牌中1张随机卡牌变为",
                    "{C:dark_edition}充能{}{C:attention}闪电牌{}",
                },
            },
            sc_akyrs_tornado = {
                name = "龙卷风",
                text = {
                    "弃牌时弃掉手牌中的{C:red}所有{}卡牌",
                    "选择盲注时{C:blue}#1#{}次出牌",
                },
            },
            sc_akyrs_void = {
                name = "创世",
                text = {
                    "清除{C:akyrs_scenario_dark_pink}浅粉{}情境",
                },
            },
        },
        Spectral = {},
        Stake = {
            stake_akyrs_copper = {
                name = "铜注",
                text = {
                    "卡牌可能有{C:attention}氧化{}贴纸",
                    "{s:0.8}之前的赌注也都生效",
                },
            },
            stake_akyrs_inner = {
                name = "内层注",
                text = {
                    "{C:blue}+1{}手牌上限",
                },
            },
            stake_akyrs_outer = {
                name = "外层注",
                text = {
                    "{C:blue}+1{}次出牌",
                },
            },
            stake_akyrs_lime = {
                name = "青柠注",
                text = {
                    "盲注大小{C:red}X1.5{}",
                    "{s:0.8}之前的赌注也都生效",
                },
            },
            stake_akyrs_lemon = {
                name = "柠檬注",
                text = {
                    "{C:attention}更快{}的底注增长",
                    "{s:0.8}之前的赌注也都生效",
                },
            },
            stake_akyrs_turquoise = {
                name = "绿松石注",
                text = {
                    "开局额外拥有{C:money}$1{}",
                    "{s:0.8}之前的赌注也都生效",
                },
            },
            stake_akyrs_amethyst = {
                name = "紫水晶注",
                text = {
                    "每回合一张随机游戏牌获得{C:attention}结晶化{}贴纸",
                    "{S:0.8}（打出时不得分 打出时移除贴纸）",
                    "开局{C:blue}+1{}次出牌",
                    "{s:0.8}之前的赌注也都生效",
                },
            },
            stake_akyrs_wooden = {
                name = "木纹注",
                text = {
                    "盲注被{C:attention}选中时{}添加一张随机游戏牌到牌组",
                    "{s:0.8}之前的赌注也都生效",
                },
            },
            stake_akyrs_bismuth = {
                name = "铋注",
                text = {
                    "小丑牌可能有{C:attention}晶格化{}贴纸",
                    "{S:0.8}（无法通过正常方式售出）",
                    "{s:0.8}之前的赌注也都生效",
                },
            },
            stake_akyrs_high_contrast = {
                name = "高对比度注",
                text = {
                    "{C:attention}更快的{}底注增长",
                    "{s:0.8}之前的赌注也都生效",
                },
            },
            stake_akyrs_hydrogel = {
                name = "水凝胶注",
                text = {
                    "每回合一张随机游戏牌获得{C:attention}可疑{}贴纸",
                    "{s:0.8}（回合结束时随机改变花色或点数）",
                    "{s:0.8}之前的赌注也都生效",
                },
            },
            stake_akyrs_spotify = {
                name = "Spotify注",
                text = {
                    "当{C:attention}Boss盲注{}被击败时",
                    "一张随机小丑牌获得{C:money}租用{}贴纸",
                    "{s:0.8}之前的赌注也都生效",
                },
            },
            stake_akyrs_aluminium = {
                name = "铝注",
                text = {
                    "{C:red}+1{}获胜底注",
                    "{s:0.8}之前的赌注也都生效",
                },
            },
            stake_akyrs_steam = {
                name = "蒸汽注",
                text = {
                    "商店中许多卡牌有{C:red}九折{}贴纸",
                    "（回合结束时损失{C:money}$0.5{}）",
                    "{s:0.8}之前的赌注也都生效",
                },
            },
            stake_akyrs_netherite = {
                name = "下界合金注",
                text = {
                    "开局额外拥有{C:money}$2{}和{C:red}+1{}次弃牌",
                    "{s:0.8}之前的赌注也都生效",
                },
            },
            stake_akyrs_doom = {
                name = "末日注",
                text = {
                    "卡牌可能有{C:attention}自毁{}贴纸",
                    "回合结束时{C:red}自毁{}",
                    "{s:0.8}之前的赌注也都生效",
                },
            },
        },
        Tag = {
            tag_akyrs_spell_itself_tag = {
                name = "自拼写标签",
                text = {
                    "给予一个免费的",
                    "{C:blue}超级字母包",
                },
            },
            tag_akyrs_umbral_tag = {
                name = "暗影标签",
                text = {
                    "给予一个免费的",
                    "{C:akyrs_umbral_p}超级暗影包",
                },
            },
            tag_akyrs_replicant_tag = {
                name = "仿生标签",
                text = {
                    "给予一个免费的",
                    "{C:akyrs_replicant_o}仿生包",
                },
            },
        },
        Tarot = {
            c_akyrs_wof_nopes = {
                name = "命运之轮（修改版）",
                text = {
                    "没有任何效果",
                },
            },
        },
        Bet = {
            bet_akyrs_expert_play = {
                name = "专家玩法！",
                text = {
                    "可能出现{C:attention}专家{}及更高难度的Boss盲注",
                    "{C:dark_edition}+#1#{}个消耗牌槽位",
                },
            },
            bet_akyrs_raise_the_stake = {
                name = "提高赌注！",
                text = {
                    "应用一个随机{C:attention}赌注{}效果{C:inactive}（如果可用）",
                    "为一张小丑牌添加随机{C:dark_edition}版本{}",
                },
            },
            bet_akyrs_a_lock_and_a_hard_place = {
                name = "进退维谷！",
                text = {
                    "商店中1件{C:attention}随机{}商品始终被{C:attention}锁定{}",
                    "必须{C:attention}购买{}后才会消失",
                },
            },
            bet_akyrs_flames_of_desires = {
                name = "欲望之焰！",
                text = {
                    "从牌组中{C:attention}摧毁{}所有",
                    "属于1种{C:attention}随机{}花色的卡牌",
                },
            },
            bet_akyrs_resonance_of_chaos = {
                name = "混沌共鸣！",
                text = {
                    "牌组中所有卡牌的增强效果",
                    "被{C:attention}锁定{}为任意一种{C:attention}音符牌{}",
                },
            },
            bet_akyrs_ghastly_limelight = {
                name = "惨白聚光灯！",
                text = {
                    "牌组中所有卡牌的增强效果",
                    "被{C:attention}锁定{}为任意一种{C:attention}音符牌{}",
                },
            },
            bet_akyrs_kaleidoscope = {
                name = "万花筒！",
                text = {
                    "牌组中所有卡牌的增强效果",
                    "被{C:attention}锁定{}为任意一种{C:attention}音符牌{}",
                },
            },
        },
        Voucher = {
            v_akyrs_alphabet_soup = {
                name = "字母汤",
                text = {
                    "游戏牌上出现{C:attention}字母{}",
                    "可以用游戏牌组成单词",
                    "{C:akyrs_playable}+#1#{}选择上限",
                },
            },
            v_akyrs_crossing_field = {
                name = "跨界领域",
                text = {
                    "{C:attention}字母{}基于其",
                    "{C:attention}拼字游戏分值{}给予{C:mult}倍率{}",
                    "{C:akyrs_playable}+#1#{}选择上限",
                },
            },
            v_akyrs_banquet = {
                name = "盛宴",
                text = {
                    "{C:akyrs_playable}+#1#{}选择上限",
                    "{C:blue}+#1#{}手牌上限",
                },
            },
            v_akyrs_worlds_end = {
                name = "世界尽头",
                text = {
                    "{C:akyrs_playable}+#1#{}选择上限",
                    "{C:blue}+#1#{}手牌上限",
                },
            },
            v_akyrs_i_owe_you = {
                name = "欠你一次",
                text = {
                    "{C:inactive}金宝现在手头不太宽裕",
                    "{C:inactive}如果你愿意给他资金 确实能帮上忙",
                    "{C:inactive}或许以后他会报答你",
                },
            },
            v_akyrs_premium_free_joker = {
                name = "高级免费小丑",
                text = {
                    "金宝的概率把戏中可进行",
                    "{C:attention}3{}次{C:blue}普通{}小丑牌重掷",
                },
            },
            v_akyrs_super_premium_free_joker = {
                name = "超级高级免费小丑",
                text = {
                    "金宝的概率把戏中每回合可进行",
                    "{C:attention}1{}次必定为{C:green}罕见{}的重掷",
                },
            },
            v_akyrs_ultra_premium_free_joker = {
                name = "终极高级免费小丑",
                text = {
                    "金宝的概率把戏中每底注可进行",
                    "{C:attention}1{}次必定为{C:red}稀有{}的重掷",
                },
            },
        },
        AikoyoriExtraBases = {
            null_card = {
                name = "空白",
                text = {
                    "一张简单的空白卡牌",
                    "上面什么都没有",
                },
            },
            lettersMult = {
                name = "",
                text = {
                    "{C:mult}+#2#{}倍率",
                },
            },
            lettersXMult = {
                name = "",
                text = {
                    "{C:white,X:mult}X#3#{}倍率",
                },
            },
            letterCardFrequency = {
                name = "",
                text = {
                    "出现频率：{C:attention}#4#",
                },
            },
            lettersWild = {
                name = "万能牌",
                text = {
                    "可设置为特定字母",
                    "但不提供得分",
                },
            },
            letters = {
                name = "字母牌",
                text = {
                    "{s:1.4,C:attention}#1#",
                    "允许打出单词",
                },
            },
            symbols = {
                name = "符号牌",
                text = {
                    "{s:1.4,C:attention}#1#",
                    "这些符号用于",
                    "特定情况",
                },
            },
            numbers = {
                name = "数字牌",
                text = {
                    "{s:1.4,C:attention}#1#",
                    "允许创建",
                    "数学表达式",
                },
            },
        },
        Sleeve = {
            sleeve_akyrs_letter = {
                name = "字母牌套",
                text = {
                    "开局时{C:red}字母{}已启用",
                },
            },
            sleeve_akyrs_letter_alt = {
                name = "字母牌套",
                text = {
                    "开局时拥有",
                    "{C:white,X:dark_edition}X#1#{}牌组大小",
                    "{C:red}+#2#{}次弃牌",
                    "{C:blue}+#3#{}手牌上限",
                    "基础盲注要求分数{C:red}X#4#{}",
                },
            },
            sleeve_akyrs_letter_math_pro = {
                name = "数学牌组专业版",
                text = {
                    "开局时额外拥有",
                    "{C:attention}2{}组{C:attention}英文字母{}",
                    "和{C:attention}4{}个等号",
                    "{C:blue}+#1#{}额外出牌次数",
                    "{C:attention}+#2#{}额外手牌上限",
                    "{C:red}+#3#{}额外弃牌次数",
                },
            },
            sleeve_akyrs_freedom = {
                name = "自由牌套",
                text = {
                    "你可以{C:attention}拖拽{}卡牌",
                    "放置到任意位置",
                },
            },
            sleeve_akyrs_freedom_alt = {
                name = "终极自由牌套",
                text = {
                    "你可以拖拽{C:attention}任何{}卡牌",
                    "放置到任意位置",
                },
            },
            sleeve_akyrs_cry_misprint_ultima = {
                name = "终极错印牌套",
                text = {
                    "卡牌和牌型的数值",
                    "被{C:attention}随机化{}",
                    "{C:inactive}（从X#1#到X#2#）",
                    "真正的挑战是别让游戏崩溃",
                },
            },
            sleeve_akyrs_cry_misprint_ultima_alt = {
                name = "终极错印牌套+",
                text = {
                    "卡牌和牌型的数值",
                    "被{C:attention}超级随机化{}",
                    "{C:inactive}（从X#1#到X#2#）",
                    "真正的挑战是别让游戏崩溃",
                },
            },
            sleeve_akyrs_inversion = {
                name = "反转牌套",
                text = {
                    "卡牌选择被{C:attention}反转",
                },
            },
            sleeve_akyrs_inversion_double_inverted = {
                name = "双重反转牌套",
                text = {
                    "卡牌选择被{E:akyrs_snaking,C:dark_edition}双重{C:attention}反转{}",
                },
            },
        },
        Umbral = {
            c_akyrs_umbral_graduate = {
                name = "毕业生",
                text = {
                    "生成本赛局中",
                    "最后使用的{C:akyrs_umbral_p,X:akyrs_umbral_y}暗影{}牌",
                    "{s:0.8,C:akyrs_umbral_p,X:akyrs_umbral_y}毕业生{s:0.8}除外",
                },
            },
            c_akyrs_umbral_realist = {
                name = "现实主义者",
                text = {
                    "将最多{C:attention}#1#{}张选定牌",
                    "增强为{C:attention}曝晒牌{}",
                },
            },
            c_akyrs_umbral_tribal = {
                name = "部落",
                text = {
                    "为选定的{C:attention}牌型{}",
                    "生成一张{C:planet}星球牌{}",
                    "{C:inactive}（选定{C:attention}#1#{C:inactive} 生成{C:attention}#2#{C:inactive}）",
                },
            },
            c_akyrs_umbral_gambit = {
                name = "孤注一掷",
                text = {
                    "将手牌中最多{C:attention}#1#{}张随机牌",
                    "转换为{C:attention}K{}、{C:attention}Q{}",
                    "或{C:attention}A{}",
                },
            },
            c_akyrs_umbral_kingpin = {
                name = "核心人物",
                text = {
                    "将{C:attention}#1#{}张带蜡封的{C:attention}固定{}K",
                    "添加到手牌中",
                },
            },
            c_akyrs_umbral_tea_time = {
                name = "下午茶",
                text = {
                    "将{C:attention}#1#",
                    "张选定牌增强为",
                    "随机{C:attention}茶牌{}",
                },
            },
            c_akyrs_umbral_break_up = {
                name = "分裂",
                text = {
                    "将{C:attention}#1#{}张选定牌",
                    "分裂为{C:attention}纯净花色{}和{C:attention}点数{}牌",
                    "{C:inactive}（如果可能）",
                },
            },
            c_akyrs_umbral_public_transport = {
                name = "公共交通",
                text = {
                    "生成{C:attention}#1#{}张",
                    "{C:attention}#2#{}选定牌的副本",
                    "具有{C:attention}连续{}点数",
                    "{C:inactive}（可双向进行）",
                },
            },
            c_akyrs_umbral_corruption = {
                name = "腐化",
                text = {
                    "{C:green}50%几率{}要么{C:attention}复制",
                    "要么{C:red}摧毁{}手牌中{C:attention}半数{}的牌",
                },
            },
            c_akyrs_umbral_fomo = {
                name = "错失恐惧",
                text = {
                    "随机兑换#1#张{C:attention}之前未兑换过的{}",
                    "{C:attention}优惠券{}花费{C:money}$#2#{}",
                    "这些优惠券{C:attention}曾在商店中出现过{}",
                },
            },
            c_akyrs_umbral_misfortune = {
                name = "不幸",
                text = {
                    {
                        "将{C:attention}#1#张选定牌",
                        "增强为{C:attention}？牌{}",
                    },
                    {
                        "如果该牌已经是{C:attention}？牌{}",
                        "则改为增强为{C:attention}道具盒牌{}",
                    },
                },
            },
            c_akyrs_umbral_book_smart = {
                name = "书呆子",
                text = {
                    "生成最多{C:attention}#1#{}张随机",
                    "{C:akyrs_umbral_p,X:akyrs_umbral_y}暗影{}牌",
                    "{C:inactive}（必须有空位）{}",
                },
            },
            c_akyrs_umbral_prisoner = {
                name = "囚犯",
                text = {
                    "将{C:attention}#1#",
                    "张选定牌增强为",
                    "{C:attention}砖块牌{}",
                },
            },
            c_akyrs_umbral_overgrowth = {
                name = "过度生长",
                text = {
                    "将{C:attention}#1#",
                    "张选定牌增强为",
                    "{C:attention}华盖牌{}",
                },
            },
            c_akyrs_umbral_intrusive_thoughts = {
                name = "侵入性思维",
                text = {
                    {
                        "{X:money,C:black}$X#1#{}但有{C:green}固定#2#%几率{}",
                        "{E:1,C:red}将资金设为#3#{}",
                    },
                    {
                        "{C:attention}售出{}此牌可查看{C:attention}是否会损失资金{}",
                    },
                },
            },
            c_akyrs_umbral_intrusive_thoughts_absurd = {
                name = "侵入性思维",
                text = {
                    "{X:akyrs_money_x,C:akyrs_money_c}$^#1#{}但有{C:green}固定#2#%几率{}",
                    "{E:1,C:red}立即输掉赛局{}",
                    "{C:attention}售出{}此牌可查看{C:attention}是否会输掉{}",
                },
            },
            c_akyrs_umbral_weeping_angel = {
                name = "哭泣天使",
                text = {
                    "{C:attention}翻转当前手牌中所有卡牌{}",
                    "每张翻转后{C:attention}背面朝上的{}牌",
                    "获得{C:money}+$#1#{}",
                },
            },
            c_akyrs_umbral_bunker = {
                name = "地堡",
                text = {
                    "选择手牌中的{C:attention}#1#{}张牌",
                    "给予随机{C:attention}增强、版本、蜡封{}",
                    "但{C:attention}强制{}其被{C:attention}选中{}",
                },
            },
            c_akyrs_umbral_rock = {
                name = "岩石",
                text = {
                    "给予手牌中{C:attention}所有卡牌{}",
                    "{C:attention}永久{}{C:chips}+#1#{}筹码加成",
                },
            },
            c_akyrs_umbral_crust = {
                name = "地壳",
                text = {
                    "给予手牌中{C:attention}所有{C:clubs}梅花{}牌",
                    "{C:attention}永久{}{X:mult,C:white} X#1# {}倍率加成",
                },
            },
            c_akyrs_umbral_mantle = {
                name = "地幔",
                text = {
                    "给予手牌中{C:attention}所有{C:spades}黑桃{}牌",
                    "{C:attention}永久{}{X:chips,C:white} X#1# {}筹码加成",
                },
            },
            c_akyrs_umbral_core = {
                name = "地核",
                text = {
                    "给予手牌中{C:attention}所有{C:hearts}红桃{}牌",
                    "{C:attention}永久{}{C:money}+$#1#{}加成",
                },
            },
            c_akyrs_umbral_atmosphere = {
                name = "大气层",
                text = {
                    "给予手牌中{C:attention}所有{C:diamonds}方片{}牌",
                    "{C:attention}永久{}{C:purple}+#1#{}分数加成",
                    "{C:inactive}（下次使用将给予{C:purple}+#2#{C:inactive}分数）",
                },
            },
            c_akyrs_umbral_nyctophobia = {
                name = "黑夜恐惧症",
                text = {
                    "生成{C:attention}#1#{}张随机",
                    "{C:dark_edition}负片{C:tarot}塔罗牌{}",
                },
            },
            c_akyrs_umbral_puzzle = {
                name = "拼图",
                text = {
                    "选择{C:attention}#1#{}张牌",
                    "将{C:attention}右侧{}牌的",
                    "{C:attention}花色、版本和蜡封{}",
                    "应用到{C:attention}左侧{}牌",
                    "{C:red}摧毁{}右侧牌",
                    "{C:inactive}（拖拽重新排列）",
                },
            },
            c_akyrs_umbral_electrify = {
                name = "通电",
                text = {
                    "将{C:attention}#1#",
                    "张选定牌增强为",
                    "{C:attention}闪电牌{}",
                },
            },
            c_akyrs_umbral_d1 = {
                name = "D1",
                text = {
                    "将所有几率的{C:green}分子{}",
                    "增加{C:green}#1#{}分母增加{C:green}#2#{}",
                    "{C:inactive}（如果可能）",
                    "{C:inactive}（注：最后应用）",
                },
            },
            c_akyrs_umbral_bounce = {
                name = "弹跳",
                text = {
                    "将{C:attention}#1#",
                    "张选定牌增强为",
                    "{C:attention}网牌{}",
                },
            },
            c_akyrs_umbral_hydrate = {
                name = "水合",
                text = {
                    "将{C:attention}#1#",
                    "张选定牌增强为",
                    "{C:attention}水滴牌{}",
                },
            },
            c_akyrs_umbral_exit_plan = {
                name = "退出计划",
                text = {
                    "有{C:green}#1#/#2#{}几率",
                    "{C:attention}禁用{}盲注效果",
                },
            },
            c_akyrs_umbral_exit_plan_mp = {
                name = "退出计划",
                text = {
                    "有{C:green}#1#/#2#{}几率",
                    "获得当前{C:attention}基础盲注大小{}",
                    "的{C:purple}#3#%{}作为{C:purple}分数{}",
                    "{C:inactive}（当前{C:purple}+#4#{C:inactive}分数）",
                },
            },
            c_akyrs_umbral_free_will = {
                name = "自由意志",
                text = {
                    "{C:akyrs_playable}+#1#{}选择上限",
                },
            },
        },
        Replicant = {
            c_akyrs_replicant_forecast = {
                name = "预报",
                text = {
                    "获得最多{C:attention}#1#{}张",
                    "{C:akyrs_replicant_o}仿生{}牌",
                    "{C:inactive}（必须考虑空位）",
                },
            },
            c_akyrs_replicant_connection = {
                name = "连接",
                text = {
                    "最多允许选择{C:attention}#1#{}张牌",
                    "生成#2#张副本 这些副本与原件",
                    "在{C:attention}点数和花色上有所不同{}",
                    "随后给生成的副本应用{C:purple}结晶化{}贴纸",
                },
            },
            c_akyrs_replicant_steganography = {
                name = "隐写术",
                text = {
                    "获得最多{C:attention}#1#{}张",
                    "隐匿的{C:red}稀有{}小丑牌",
                    "{C:inactive}（必须考虑空位）",
                },
            },
            c_akyrs_replicant_database = {
                name = "数据库",
                text = {
                    "最多选择{C:attention}#1#{}张随机牌",
                    "将其{C:attention}返回{}牌组",
                    "每弃掉#3#张牌",
                    "临时获得{C:red}+#2#{}次弃牌",
                },
            },
            c_akyrs_replicant_short_form_content = {
                name = "短视频",
                text = {
                    "立即与随机{C:attention}对决盲注{}开战{}",
                    "击败后获得{C:attention}#1#{}底注",
                    "{C:inactive}（必须在选择盲注时使用）",
                },
            },
            c_akyrs_replicant_short_form_content_mp = {
                name = "短视频",
                text = {
                    "立即与随机{C:attention}对决盲注{}开战{}",
                    "击败后获得{C:attention}+#1#{}生命",
                    "{C:inactive}（必须在选择盲注时使用）",
                },
            },
            c_akyrs_replicant_smart_home = {
                name = "智能家居",
                text = {
                    "选择卡牌以创建将",
                    "被{C:attention}升级{}#1#次的{C:attention}牌型{}",
                    "然后给选定牌应用",
                    "{C:attention}注意力{}贴纸",
                    "{C:inactive}（选择{C:attention}#1#{C:inactive}）",
                },
            },
            c_akyrs_replicant_music_streaming = {
                name = "音乐流媒体",
                text = {
                    "最多选择{C:attention}#1#{}张小丑牌",
                    "应用{C:attention}易腐{}效果",
                    "然后生成{C:attention}等量{}的",
                    "{C:dark_edition}负片{C:spectral}幻灵{}牌",
                },
            },
            c_akyrs_replicant_file_sharing = {
                name = "文件共享",
                text = {
                    "恰好选择{C:attention}#1#{}张牌",
                    "交换位置",
                },
            },
            c_akyrs_replicant_ota = {
                name = "OTA技术",
                text = {
                    "选择{C:attention}#1#{}张随机小丑牌",
                    "应用{C:attention}租用{}效果",
                    "然后生成{C:attention}等量{}的",
                    "{C:dark_edition}负片{C:spectral}塔罗{}牌",
                },
            },
            c_akyrs_replicant_daw = {
                name = "数字音频工作站",
                text = {
                    "手牌中所有牌的增强状态",
                    "被{C:attention}随机化{}为一种{C:attention}音符牌{}",
                    "{C:inactive}（更可能获得长音符）",
                },
            },
            c_akyrs_replicant_instant_messaging = {
                name = "即时通讯",
                text = {
                    "手牌中{C:attention}所有卡牌{}",
                    "其点数和花色将被{C:attention}洗混{}",
                },
            },
            c_akyrs_replicant_enshittification = {
                name = "劣质化",
                text = {
                    "生成一张{C:dark_edition}负片{C:money}租用{C:purple}永恒{}小丑牌",
                },
            },
            c_akyrs_replicant_digital_art = {
                name = "数字艺术",
                text = {
                    "舍弃{C:red}#1#{}次弃牌次数",
                    "换取永久{C:attention}+#2#{}手牌上限",
                },
            },
            c_akyrs_replicant_common_scam = {
                name = "常见骗局",
                text = {
                    "舍弃{C:red}#1#{}次出牌次数",
                    "换取永久{C:dark_edition}+#2#{}个小丑牌槽位",
                    "和{C:dark_edition}+#2#{}个消耗牌槽位",
                },
            },
            c_akyrs_replicant_third_party_cookies = {
                name = "第三方Cookie",
                text = {
                    "用食物小丑牌填满你的小丑牌槽位",
                    "每张有{C:green}#1#/#2#{}几率",
                    "带有{C:purple}晶格化{}贴纸",
                },
            },
            c_akyrs_replicant_silicon_fabrication = {
                name = "硅制造",
                text = {
                    "手牌中两张随机牌",
                    "转换为{C:attention}威化牌{}",
                    "手牌中另外两张随机牌将",
                    "获得{C:dark_edition}充能{}效果",
                },
            },
            c_akyrs_replicant_get_rich_quick = {
                name = "快速致富",
                text = {
                    {
                        "{X:akyrs_money_x,C:akyrs_money_c}$^#1#{}但有{C:green}固定#2#%几率{}",
                        "{E:1,C:red}立即输掉赛局{}",
                    },
                    {
                        "{C:attention}售出{}此牌可查看{C:attention}是否会输掉{}",
                    },
                },
            },
        },
    },
    misc = {
        achievement_names = {
            ach_akyrs_spell_aikoyori = "可惜aikoyori并不存在",
            ach_akyrs_repeater_into_another_one = "循环锁定",
            ach_akyrs_happy_ghast_grown = "不安的联盟",
            ach_akyrs_both_pickaxe = "双持",
            ach_akyrs_win_klondike = "返璞归真",
            ach_akyrs_spell_very_long_word = "超绝非凡长单词",
            ach_akyrs_spell_long_word = "新芽长存",
            ach_akyrs_we_no_speak_americano = "我们不说美式英语",
            ach_akyrs_resist_the_temptation = "抵制诱惑",
            ach_akyrs_thatll_be_5_wheat = "请付5小麦",
            ach_akyrs_literally_cryptid = "字面意义的神秘生物",
            ach_akyrs_div_0_math = "#ERR# 未找到成就 ach_akyrs_div_0_math",
            ach_akyrs_average_daily_scrandle = "每日平均零食",
        },
        achievement_descriptions = {
            ach_akyrs_spell_aikoyori = "拼出Aikoyori",
            ach_akyrs_repeater_into_another_one = "将中继器的输出接入另一个中继器",
            ach_akyrs_happy_ghast_grown = "从干燥形态培育出欢乐幽灵",
            ach_akyrs_both_pickaxe = "获得两把镐",
            ach_akyrs_win_klondike = "赢得空当接龙",
            ach_akyrs_spell_very_long_word = "拼出有效的超长单词（25+字母）（需要完整词典）",
            ach_akyrs_spell_long_word = "拼出有效的长单词（12+字母）",
            ach_akyrs_we_no_speak_americano = "不拼出任何单词赢得一局字母牌组",
            ach_akyrs_resist_the_temptation = "不使用自由功能赢得一局自由牌组",
            ach_akyrs_thatll_be_5_wheat = "用小丑牌槽位填满翡翠",
            ach_akyrs_literally_cryptid = "对没有点数的卡牌使用公共交通",
            ach_akyrs_div_0_math = "你以为会发生什么",
            ach_akyrs_average_daily_scrandle = "将食物小丑牌变成爆米花",
        },
        blind_states = {},
        akyrs_balancing_wizard = {},
        challenge_names = {
            c_akyrs_space_oddity = "太空怪谈",
            c_akyrs_4_hibanas = "永恒的希巴纳",
        },
        hardcore_challenge_names = {
            hc_akyrs_spark = "火花",
            hc_akyrs_secured_two_factor = "双重验证保护",
            hc_akyrs_detroit = "底特律",
            hc_akyrs_detroit_2 = "底特律II",
            hc_akyrs_detroit_3 = "底特律III",
            hc_akyrs_detroit_4 = "底特律IV",
            hc_akyrs_detroit_5 = "底特律：变人",
            hc_akyrs_half_life = "半衰期",
            hc_akyrs_half_life_2 = "半衰期2",
            hc_akyrs_thin_yo_deck = "精简你的牌组吧兄弟",
            hc_akyrs_thin_yo_deck_2 = "看在上帝的份上精简你的牌组",
            hc_akyrs_national_debt = "国债",
            hc_akyrs_extra_defensive_bulwark = "额外防御壁垒",
            hc_akyrs_no_hints_here = "知识测验",
            hc_akyrs_no_hints_here_gold_edition = "闭卷终考",
            hc_akyrs_wordle_galore = "思维链",
            hc_akyrs_bomb_galore = "持续拼写无人爆炸",
            hc_akyrs_hatena_jokers = "????????",
            hc_akyrs_hatena_everything = "???????????????",
            hc_akyrs_bonfire_lit = "篝火已点燃",
        },
        collabs = {},
        dictionary = {
            b_umbral_cards = "暗影牌",
            b_replicant_cards = "仿生牌",
            b_scenario_cards = "情境牌",
            k_umbral = "暗影",
            k_replicant = "仿生",
            k_scenario = "情境",
            k_bet = "赌注卡",
            k_enchantment = "附魔",

            b_alphabet_cards = "字母牌",
            k_alphabet = "字母",
            b_akyrs_alphabets = "字母牌",
            k_aikoyoriextrabases = "额外基底",
            k_akyrs_alphabets = "字母",
            k_akyrs_bet = "赌注卡",
            k_akyrs_enchantment = "附魔",
            k_akyrs_current_req = "当前",
            k_akyrs_alphabets_pack = "字母包",
            k_alphabets = "字母包",
            k_created = "已创建",
            k_akyrs_up_to_sel = "倍",
            ph_aiko_beat_puzzle = "解开以下",
            ph_word_puzzle = "单词谜题",
            ph_aiko_defuse = "清除",
            ph_aiko_bomb = "单词炸弹",
            ph_akyrs_play_for = "打出以获得",
            k_akyrs_random_played_hand = "随机已打出的牌型",
            k_akyrs_must_pay_attention = "手牌中必须有注意力卡",
            k_akyrs_must_contain_word = "出牌必须包含单词",
            ph_puzzle_clear = "谜题破解",
            ph_akyrs_unknown = "???",
            k_akyrs_item_box_trigger = "?",

            akyrs_start_with = "开局拥有",
            akyrs_stored_open = "（当前",
            akyrs_stored_close = "）",
            k_akyrs_reciprocaled = "倒数化！",
            k_akyrs_centrifuged = "离心化！",
            k_akyrs_drawn_discard = "全部收回！",
            k_akyrs_2fa_generate = "已生成！",
            k_akyrs_2fa_regen = "代码已刷新！",
            k_akyrs_2fa_reset = "双重验证重置！",
            k_akyrs_extinguish = "熄灭...",
            k_akyrs_burn = "燃烧！",
            k_akyrs_constellation = "星座",
            k_words_long = "12+字母单词",
            k_akyrs_multiple_hands = "多重出牌",
            k_akyrs_hibana_change = "Nanana...",
            k_akyrs_gift_change = "新品促销！",
            k_akyrs_with = "with",
            k_akyrs_credits = "制作人员",
            k_akyrs_created_by = "创作",
            k_akyrs_additional_art_by = "特邀美术",
            k_akyrs_additional_help_by = "特别帮助",
            k_akyrs_drmonty_help = "平衡性优化",
            k_akyrs_special_thanks = "特别感谢",
            k_akyrs_cross_mods_creds = "跨模组美术鸣谢",
            k_akyrs_please_dont_kill_me = "别杀我别杀我别杀我（？意义不明）",
            k_akyrs_sharetest_cred_1 = "所有参与测试",
            k_akyrs_sharetest_cred_2 = "分享和制作模组内容的玩家",
            k_akyrs_thanks_you_for_playing = "以及你",
            k_akyrs_difficult = "困难",
            k_akyrs_dried = "干燥。。。",
            k_akyrs_moisture = "浸润! ",
            k_akyrs_growth = "成长！",
            k_akyrs_back = "逆转！",
            k_akyrs_cinema = "影院！",
            k_akyrs_received = "已获得！",
            k_akyrs_sendoff = "发射！",
            k_akyrs_yee = "咿耶！",
            k_akyrs_pissandshittium = "https://pissandshittium.org/",
            k_akyrs_pandora_give_tag = "Re:MASTER 15",
            k_akyrs_pandora_hit = "Critical！",
            k_akyrs_downgrade_ex = "降级！",
            k_akyrs_woah_undertale = "哇",
            k_akyrs_story_of_undertale = "传说之下",
            k_akyrs_value_up = "价值提升！",
            k_akyrs_ojisan = "已回复！",
            k_akyrs_gain_discard = "<溅射>",

            k_akyrs_use_from_drag = "使用",
            k_akyrs_use_from_drag_apply = "应用",
            k_akyrs_use_from_drag_voucher = "（兑换）",
            k_akyrs_use_from_drag_consumable = "（消耗牌）",
            k_akyrs_use_from_drag_joker = "（初始效果）",
            k_akyrs_use_from_drag_pcard = "（加入牌组）",
            b_akyrs_normal_jokers = "普通小丑牌",
            b_akyrs_letter_jokers = "字母小丑牌",
            k_akyrs_ate_up = "吃光了！",
            b_akyrs_words = "单词",
            k_akyrs_check_word_check = "检查",

            k_akyrs_ryo_borrowed_money = "借钱。。。",
            k_akyrs_nijika_planet = ":D",

            k_akyrs_fps = " 帧",

            k_akyrs_random_letter = "随机选择的字母",
            k_akyrs_tsunagi_absurd_wheel_nope = "1次Miss！",
            k_akyrs_umbral_intrusive_would_die = "幸运！",
            k_akyrs_umbral_intrusive_would_win = "真可惜！",
            k_akyrs_replicant_get_rich_quick_would_die = "幸运！",
            k_akyrs_replicant_get_rich_quick_would_win = "真可惜！",
            k_akyrs_solitaire = "空当接龙",

            k_akyrs_cannot_be_disabled = "无法被禁用",
            k_akyrs_cannot_be_rerolled = "无法重掷",
            k_akyrs_blind_difficult_expert = "专家盲注",
            k_akyrs_blind_difficult_master = "大师盲注",
            k_akyrs_blind_difficult_ultima = "终极盲注",
            k_akyrs_blind_difficult_remaster = "二阶：大师盲注",

            k_akyrs_confrontation_has_face_in_hand_warning = "手牌中不能留有人头牌",
            k_akyrs_crystalised_warning = "结晶化卡牌会使出牌不得分",

            k_akyrs_title = "aikoyori的恶作剧",
            k_akyrs_join_akyrs_discord = "Discord（漏洞与反馈）",

            k_akyrs_hardcore_challenge_mode = "硬核挑战模式",
            k_akyrs_hardcore_challenge_mode_flavour = "艰难且完全可选的挑战",
            k_akyrs_hardcore_challenge_mode_flavour_2 = "刻意设计的不公与不平衡",
            k_akyrs_hardcore_challenge_mode_flavour_3 = "不适合胆小者",
            k_akyrs_hardcore_challenge_mode_wish_1 = "愿幸运眷顾",
            k_akyrs_hardcore_challenge_mode_wish_2 = "选择尝试的你",
            k_akyrs_hardcore_challenge_mode_tip_1 = "或许也是一种有趣的方式",
            k_akyrs_hardcore_challenge_mode_tip_2 = "测试某张小丑牌是否过于强大",
            b_akyrs_hc_challenges = "硬核",
            b_akyrs_hc_challenges_full_txt = "硬核挑战",
            k_akyrs_hardcore_challenge_difficulty = "难度",

            k_akyrs_type_in_letter = "输入字母",
            k_akyrs_letter_btn_currently = "当前",
            k_akyrs_word_check_init = "输入单词并点击检查",
            k_akyrs_word_tab_reduced_tip_1 = "输入的单词有效但不符合预期",
            k_akyrs_word_tab_reduced_tip_2 = "尝试在配置中启用完整词典",
            k_akyrs_word_tab_reduced_tip_3 = "（可能会影响一些性能）",
            k_akyrs_letter_btn_unset = "未设置",
            k_akyrs_letter_btn_auto = "自动",
            k_akyrs_letter_btn_set = "已设置",
            k_akyrs_letter_btn_swap_case = "切换大小写",
            k_akyrs_you_tried = "你尝试了 :star:",
            k_akyrs_alphabetically = "字母",

            k_akyrs_textbox_notice = "由于游戏运行机制",
            k_akyrs_textbox_notice_2 = "你需要与文本框交互才能显示文字",

            k_akyrs_plus_alphabet = "+1字母",
            k_akyrs_plus_umbral = "+1暗影牌",
            k_akyrs_plus_replicant = "+1仿生牌",
            k_akyrs_plus_scenario = "+1情境牌",

            k_akyrs_solitaire_redeal = "重新发牌",

            ph_akyrs_math_score_1 = "得分在",
            ph_akyrs_math_score_2 = "%范围内",
            k_akyrs_power_ante = "底注",

            k_akyrs_score_mult_pre = "倍",
            k_akyrs_score_mult_append = "分数",

            k_akyrs_wild_card = "万能牌",
            k_akyrs_kitan = "Kita~n",

            k_akyrs_copper_oxidation_stage_1 = "未氧化",
            k_akyrs_copper_oxidation_stage_2 = "暴露",
            k_akyrs_copper_oxidation_stage_3 = "风化",
            k_akyrs_copper_oxidation_stage_4 = "氧化",
            k_akyrs_oxidise_ex = "已氧化！",
            k_akyrs_scrape_ex = "刮除！",
            k_akyrs_round_singular = "回合",
            k_akyrs_round_plural = "回合",
            k_consumable_type = "消耗牌类型",

            k_akyrs_balance_dialog_intro_next = "下一步",
            k_akyrs_balance_dialog_cryptid_accept = "听起来不错（结束）",
            k_akyrs_balance_dialog_cryptid_decline = "我想了解更多！",
            k_akyrs_balance_dialog_details_next = "好吧 我选择。。。",
            k_akyrs_balance_dialog_mp_accept = "确定（结束）",
            k_akyrs_balance_dialog_finish_wizard = "出发！（结束）",

            k_akyrs_wildcard_behaviour_txt = "万能牌行为",
            k_akyrs_config_balance_txt = "平衡性",

            k_akyrs_wildcard_behaviours = {
                '自动',
                '强制设置',
                '始终手动',
                '自动设置',
            },

            k_akyrs_pure_hands = "纯净出牌",

            k_akyrs_wildcard_behaviours_description = {
                { '自动为未设置字母的万能牌', '寻找一个字母（默认）' },
                { '如果选择了未设置的万能牌', '出牌按钮将被禁用' },
                { '万能牌默认没有分配字母', '打出时不会尝试寻找字母（可能有助于性能）' },
                { '自动为万能牌寻找字母', '如果目标未设置则自动设置字母' },
            },

            k_akyrs_balance_selects = {
                '适中',
                '荒诞',
            },

            k_akyrs_balance_selects_no_talisman = {
                '适中',
            },

            k_akyrs_balance_dialog_adequate_text = "适中",
            k_akyrs_balance_dialog_adequate_description = "平衡性贴近原版",
            k_akyrs_balance_dialog_absurd_text = "荒诞",
            k_akyrs_balance_dialog_absurd_description = "（需要Talisman）更大的数字 更疯狂的效果 更严重的后果",

            k_akyrs_card_preview = "启用卡牌预览",
            k_akyrs_toggle_crt = "启用CRT着色器",
            k_akyrs_restart_required = "* = 需要重启",
            k_akyrs_toggle_full_dictionary = "启用完整词典*",
            k_akyrs_toggle_experimental_feature = "启用实验性功能*",
            k_akyrs_toggle_colourblind_ui = "高对比度界面",
            k_akyrs_emerald = "翡翠",
            k_akyrs_supercommon = "超普通",
            k_akyrs_unique = "唯一",
            k_akyrs_alphabet_pack = "字母",
            k_akyrs_umbral_pack = "暗影包",
            k_akyrs_replica_pack = "仿生包",

            b_bet = "赌注卡",
            b_judgement = "判定",
            b_enchantment = "附魔",
            b_scenario = "情境",

            k_akyrs_shoveled_ex = "铲好了！",
            k_akyrs_canopy_downable_yes = "可用！",
            k_akyrs_canopy_downable_no = "已使用",
            k_akyrs_cloud_card_tally = "云朵牌",
            k_akyrs_cloud_card_tally_buffed = "多云天气",

            k_akyrs_not_used = "未使用",
            k_akyrs_used = "已使用",

            k_akyrs_shop_close = "关闭",

            k_akyrs_chicanery_round = "本回合",
            k_akyrs_chicanery_ante = "本底注",
            k_akyrs_chicanery_rolls_common = "普通",
            k_akyrs_chicanery_rolls_uncommon = "罕见",
            k_akyrs_chicanery_rolls_rare = "稀有",
            k_akyrs_chicanery_rolls_common_arrows = "▲",
            k_akyrs_chicanery_rolls_uncommon_arrows = "",
            k_akyrs_chicanery_rolls_rare_arrows = "",
            k_akyrs_chicanery_rolls_left = "剩余重掷",
            k_akyrs_chicanery_buy = "购买",
            k_akyrs_chicanery_btn = "J",

            k_akyrs_enchantment_none = "允许添加多种能力",
            k_akyrs_enchantment_none_blank = "无 :(",
            k_akyrs_edge_prism = "<棱镜>",

            f_akyrs_localize_enchantment_level = function(level)
                if math.abs(level) > 3999 then
                    return level > 0 and "+INF" or "-INF"
                end
                if level == 0 then return "0" end
                local strout = level > 0 and "" or "-"
                local ones = { "", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX" }
                local tenths = { "", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC" }
                local hundredths = { "", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM" }
                local thousandths = { "", "M", "MM", "MMM", "M?", "?", "?M", "?MM", "?MMM", "M?" }
                local places = { thousandths, hundredths, tenths, ones }
                for i, v in ipairs({ 1000, 100, 10, 1 }) do
                    strout = strout .. places[i][math.floor(math.fmod(math.abs(level), v * 10) / v) + 1]
                end
                return strout
            end,
        },
        high_scores = {},
        labels = {
            alphabet = "字母",
            akyrs_self_destructs = "自毁",
            akyrs_sigma = "西格玛",
            akyrs_oxidising = "氧化",
            akyrs_attention = "注意力",
            akyrs_concealed = "隐匿",
            akyrs_crystalised = "结晶化",
            akyrs_latticed = "晶格化",
            akyrs_sus = "可疑",
            akyrs_sale = "九折",
            akyrs_carmine_seal = "胭脂红蜡封",
            akyrs_neon_seal = "霓虹蜡封",
            akyrs_twin_seal = "双生蜡封",
            akyrs_fault_seal = "断层蜡封",
            akyrs_deformed_seal = "畸形蜡封",
            akyrs_texelated = "像素化",
            akyrs_noire = "霓虹黑",
            akyrs_sliced = "切片",
            akyrs_burnt = "烧焦",
            akyrs_charged = "充能",
            akyrs_enchanted = "附魔",
            k_akyrs_emerald = "翡翠",
            k_akyrs_supercommon = "超普通",
            k_akyrs_unique = "唯一",
            k_fakecenter = "???",
            umbral = "暗影",
            replicant = "仿生",
            scenario = "情境",
            enchantment = "附魔",
            bet = "赌注卡",
        },
        akyrs_colour = {
            yellow = "黄色",
            pink = "粉色",
            blue = "蓝色",
            dark = "深色",
            light = "浅色",
        },
        quips = {},
        ranks = {
            akyrs_non_playing = "某种"
        },
        suits_plural = {
            akyrs_joker = "小丑牌",
            akyrs_consumable = "消耗牌",
            akyrs_booster = "补充包",
            akyrs_voucher = "优惠券",
            akyrs_thing = "某物"
        },
        suits_singular = {
            akyrs_joker = "小丑牌",
            akyrs_consumable = "消耗牌",
            akyrs_booster = "补充包",
            akyrs_voucher = "优惠券",
            akyrs_thing = "某物"
        },
        tutorial = {},
        v_dictionary = {
            k_akyrs_pure = "纯净#1#",
            k_akyrs_score_add = "+#1#分数",
            k_akyrs_score_x = "X#1#分数",
            k_akyrs_score_exp = "^#1#分数",
            ph_akyrs_hand = "#1#次出牌",
            ph_akyrs_hands = "#1#次出牌",
            k_akyrs_score_minus = "-#1#分数",
            k_akyrs_word_check_valid = "#1#是有效单词",
            k_akyrs_word_check_invalid = "#1#不是有效单词",
            k_akyrs_click_for_credits_of = "点击查看#1#的制作人员",
            k_akyrs_chicanery_rolls_left = "剩余#1#/#2#次重掷",
            k_akyrs_enchantment_lvl = "#1# 等级#2#",
            k_akyrs_enchantment_lvl_single_level = "#1#",
        },
        akyrs_misc = {
            mod_label = {
                { "Aikoyori的", "恶作剧" },
                { "Aikoyori的", "死神大人" },
                { "Aikoshen" },
                { "Aikoyori的恶作剧" },
                { "恶作剧先生的Aikoyori" },
                { "Aikoyori的小丑牌" },
                { "AKYRS" },
                { "Aikomod" },
                { "新超级", "Aikoyori恶作剧" },
                { "一个Aikoyori模组" },
                { "Shenaiko" },
                { "Aikoslop", "Shenslop" },
                { "恶作剧", "Aikoyori的" },
                { "偷走", "Aikoshen" },
                { "Aikoyori大电影", "游戏 模组" },
                { "iroyokia的", "真Playbook" },
                { "aish" },
                { "Aikoyori世界中的", "古怪奇妙", "恶作剧" },
                { "Solitaireyori", "Wordlenanigans" },
                { "{f:5}アイコヨリ", "{f:5}しぇなにがんす" },
                { "aiko？" },
            },
            flavour_text = {
                { "如今别名多了1000%！" },
                { "如今自由多了100%！" },
                { "请不要游玩硬核挑战" },
                { "获得localthunk认可" },
                { "我的妻子离开了我..." },
                { "路易吉不会这么做" },
                { "也请使用Pissandshittium" },
                { "也请使用MyPayIndia" },
                { "9+10等于多少？" },
                { "也试试Phanta" },
                { "也试试Finity" },
                { "也试试Hot Potato" },
                { "也试试Stocking Stuffer" },
                { "也试试Feli's Jokeria" },
                { "别试Cold Beans...？" },
                { "也试试Paya's Terrible Additions" },
                { "也试试Entropy" },
                { "也试试Revo's Vault" },
                { "也试试Oblivion" },
                { "你已被用光" },
                { "{f:5}为什么会落到这种地步 步 步" },
                { "{f:5}挣扎到极限的人生", "{f:5}似乎比想象中更加疯狂" },
                { "{f:5}比超级偶像的笑容更加" },
                { "{f:5}比那个8月的午后更加" },
                { "{f:5}致比105℃更加闪耀的你" },
                { "无意谈论政治 但是", "燕麦粥到底他妈是什么" },
                { "Alpha测试持续了整整1年！" },
                { "盲注拉满 消耗牌入脑" },
                { "今天玩Wordle了吗？" },
                { "游戏化视频" },
                { "Cryptid也不过如此" },
                { "keys cow" },
                { "你知道我真的可以", "在这里写任何东西吗？" },
                { "想象一下做完这一切", "然后模组崩溃了 笑死" },
                { "不要除以0！" },
                { "大概是个很棒的STEM工具！" },
                { "打出时乐趣{X:dark_edition,C:white}^2{}" },
                { "\\#抵制AI垃圾" },
                { "\\#抵制生成式AI进入Vocaloid" },
                { "美术由真正的艺术家创作！" },
                { "& Knuckles" },
                { "全新FUNKY模式" },
                { "DMC的但丁特别出演" },
                { "这事确实发生过" },
                { "不会出现在Deltarune中" },
                { "{X:red,C:white}??" },
                { "\\#BringBackWotakuSnoozeSHIKIver" },
                { "喝完啤酒立刻开车上路" },
                { "*自由主题动机*" },
                { "你找不到自己的出牌次数" },
                { "你知道这里真的支持", "多行风味文本吗？", "说实话我都惊了！" },
                { "你是可爱的冒牌货吗？" },
                { "含有少许英伦风味..." },
                { "跑吧跑吧赛马娘" },
                { "包含一些梗！" },
                { "看看你身后" },
                { "正如在Twitch TV上看到的那样！" },
                { "我们还没有退出测试", "我们永远无法按时发布" },
                { "打起精神向前冲！" },
                { "猫娘天下第一", "{s:0.6}这是ivy说的 不是我" },
                { "Re:Re:MASTER 15+" },
                { "史蒂夫·乔布斯死于ligma真让人难过", "谁是史蒂夫·乔布斯？", "Ligma Balls" },
                { "为你的死亡次数感到骄傲！" },
                { "放肆作恶 大胆去爱" },
                { "*海军入侵警报*" },
                { "x = (-b[+/-]sqrt((b^2)-4ac))/2a" },
                { "释放蒙娜克隆体！" },
                { "来玩synthv" },
                { "{f:akyrs_MochiyPopOne}「[疑]ロキ」简单w" },
                { "\\#打倒冒牌货" },
                { "说真的Family Guy里的那个人", "为什么长得像Peter Griffin" },
                { "他才20岁" },
                { "靠 这个模组花了太多钱 我完蛋了" },
                { "我的一个朋友叫我迈克尔·乔丹" },
                { "去看《超时空辉夜姬》！" },
                { "百合>耽美 说真的" },
                { "Spotify太邪恶了" },
                { "收集我的页面" },
                { "与原版完全相反的", "模组该叫什么？" },
                { "搞什么鬼 aiko 这已经是你第6次重新设计了" },
                { "*笑到喘不过气*" },
                { "... ___ ...（悲伤脸）" },
                { "说真的这破事让我很火大" },
            },
        },
        v_text = {
            ch_c_sliced_space = {
                "开局时拥有一张{C:dark_edition}切片{}太空小丑牌",
            },
            ch_c_akyrs_half_debuff = {
                "每回合你的未削弱卡牌中",
                "{C:attention}半数{}被永久削弱",
            },
            ch_c_akyrs_half_self_destruct = {
                "每回合你拥有的所有东西中",
                "{C:attention}半数{}获得{C:red,T:self_destructs}自毁贴纸{}",
            },
            ch_c_akyrs_no_tarot_except_twof = {
                "不会出现{C:tarot}塔罗牌{}",
                "除了{C:tarot,T:c_wheel_of_fortune}命运之轮{}",
            },
            ch_c_akyrs_no_tarot = {
                "不会出现{C:tarot}塔罗牌{}",
            },
            ch_c_akyrs_no_planet = {
                "不会出现{C:planet}星球牌{}",
            },
            ch_c_akyrs_no_jokers = {
                "不会出现{C:red}小丑牌{}",
            },
            ch_c_akyrs_all_cards_are_stone = {
                "所有卡牌都是{C:purple}石头{}牌",
            },
            ch_c_akyrs_allow_duplicates = {
                "可能出现{C:attention}重复卡牌{}",
            },
            ch_c_akyrs_idea_by_astrapboy = {
                "创意来自{C:attention}astrapboy",
            },
            ch_c_akyrs_idea_by_missingnumber = {
                "创意来自{C:attention}missingnumber",
            },
            ch_c_akyrs_idea_by_saharabat = {
                "创意来自{C:attention}saharabat",
            },
            ch_c_akyrs_no_hints = {
                "{C:attention}所有提示{}都被{C:red}隐藏",
            },
            ch_c_akyrs_start_with_letter_deck = {
                "使用{C:attention,T:b_akyrs_letter_deck}字母牌组{}进行游戏",
            },
            ch_c_akyrs_no_skips = {
                "{C:attention}跳过盲注{}是{C:red}不允许的",
            },
            ch_c_akyrs_all_blinds_are = {
                "{C:attention}所有盲注{}都是{C:attention}#1#",
            },
            ch_c_akyrs_hatena_deck = {
                "{C:attention}所有小丑牌{}都是{C:red}隐匿的",
            },
            ch_c_akyrs_hatena_everything = {
                "{C:attention}所有卡牌{}都是{C:red}隐匿的",
            },
            ch_c_akyrs_always_skip_shops = {
                "{C:attention}商店{}会被{C:red}跳过{}",
            },
            ch_c_akyrs_shops_after_boss = {
                "{C:attention}商店{}仅在{C:red}Boss盲注{}后出现",
            },
            ch_c_akyrs_obtain_every_round = {
                "每回合{C:attention}获得{}一个{C:attention}#1#{}",
            },
        },
        poker_hand_descriptions = poker_hand_desc,
        poker_hands = poker_hands_name,
    },
}
return localization
