--ALOPHRINE的个人汉化修正！如遇到问题请联系我。QQ与B站同名
--vergenti Q群：奇小苦、:)，对部分汉化进行了修正，包括需要代码修改的丑
--mleaf233 [github](https://github.com/mleaf233/TEOcean) ，对部分汉化进行了修正, 修复了部分错误
local All_in_Jest = SMODS.find_mod("allinjest")[1]
return {
    translator = {
        "ALOPHRINE",
        "奇小苦",
        "mleaf233",
    },
    misc = {
        v_text = {
            ch_c_aij_sharpest_tool_2 = {
                "出现在{C:attention}商店{}或{C:attention}小丑包{}中时"
            },
            ch_c_aij_sharpest_tool_1 = {
                "只有{C:common}普通{}小丑牌可能出现"
            },
            ch_c_aij_all_pit_blinds = {
                "底注1之后的所有常规Boss盲注",
                "均为{C:attention}陷阱盲注{}"
            },
        },
        v_dictionary = {
            a_aij_percent_balance = "+%#1#",
            a_aij_exp_mult = "^#1#倍率",
            a_aij_jokers = "+#1#小丑牌",
            a_aij_percent_balance_minus = "-%#1#",
            a_aij_win_ante_plus = "+#1#胜出底注",
            a_aij_joker_slots_minus = "-#1#小丑牌槽位",
            a_aij_odds = "+#1#几率",
            a_aij_hands_minus = "-#1#次出牌",
            a_aij_ante_minus = "-#1#底注",
            a_aij_mult_equal = "=#1#倍率",
            a_aij_joker_slots = "+#1#小丑牌槽位",
        },
        labels = {
            aij_silver = "银箔",
            aij_unusual_doubled = "翻倍",
            aij_recherche_doubled = "翻倍",
            aij_marked = "标记",
            aij_melted_seal = "熔融蜡封",
            aij_aureate = "鎏金",
            aij_smiley_seal = "笑脸蜡封",
            aij_jest_chaotic_card = "混沌",
            aij_torn = "撕裂",
        },
        extra_joker_dictionary = {
            k_aij_youve_got_mail = "你有新邮件！",
            k_aij_youve_got_mail_mult_text = "倍率",
            k_aij_youve_got_mail_xmult_prefix = "X",
            k_aij_overdesigned_diamond = "方片",
            k_aij_youve_got_mail_dollars_text = "每手出牌",
            k_aij_jerko_times = "次",
            k_aij_jerko_retrigger = "重新触发",
            k_aij_overdesigned_club = "梅花",
            k_aij_overdesigned_spade = "黑桃",
            k_aij_blacklist_more = "更多",
            k_aij_overdesigned_heart = "红桃",
            k_aij_overdesigned_earn_prefix = "赚取",
            k_aij_youve_got_mail_dollar_prefix = "$",
            k_aij_blacklist_empty = "无",
            k_aij_youve_got_mail_plus_prefix = "+",
            k_aij_youve_got_mail_none = "没有任何效果...",
            k_aij_overdesigned_give_prefix = "给予",
            k_aij_youve_got_mail_chip_text = "筹码",
            k_aij_youve_got_mail_goodbye = "再见",
            k_aij_blacklist_and = "和"
        },
        poker_hands = {
            ["aij_Royal Flush"] = "皇家同花顺"
        },
        challenge_names = {
            c_aij_sharpest_tool = "最锋利的工具",
            c_aij_bananarama = "香蕉狂热",
            c_aij_the_pit = "深渊"
        },
        dictionary = {
            aij_upgraded_tags = "黄金标签",
            k_aij_blood_spilt_ex = "鲜血飞溅！",
            k_aij_merry_christmas = "圣诞快乐！",
            k_aij_two_into_one_ex = "二合一！",
            k_aij_triple_ex = "翻三倍！",
            k_aij_plus_two_moons = "+2卫星牌",
            k_active = "已激活",
            aij_alter_trypophobia_tooltip = {
                "{C:attention}更改{}“密集恐惧”的贴图",
                "使其{C:attention}不那么",
                "令人不适"
            },
            k_aij_does_not_score_ex = "不计分！",
            aij_no_copy_neg_tooltip = {
                "允许{C:dark_edition}负片{}版本",
                "被复制到{C:attention}游戏牌{}上",
                "若设为{C:attention}关闭{}（默认）",
                "被复制的{C:dark_edition}负片{}卡牌将{C:red}失去{}其版本效果"
            },
            k_aij_change_ex = "变幻！",
            k_tag = "标签",
            k_coder_badge = "程序员徽章",
            aij_random_deck_skins = "随机牌套皮肤",
            k_aij_p_arcana = "+1塔罗牌",
            k_inactive = "未激活",
            aij_enable_moons_tooltip = {
                "启用可提供{C:chips}筹码{}和{C:mult}倍率{}的",
                "{C:planet}卫星牌{}出现"
            },
            k_aij_foiled_again = "又是闪箔！",
            k_aij_polychrome_ex = "多彩！",
            k_tarot_q = "塔罗牌？",
            k_aij_chaos_ex = "混沌！",
            aij_doesnt_requires_restart = "无需重启",
            aij_blue_stake_rework_tooltip = {
                "{C:attention}更改{}蓝注",
                "以使用新的{C:attention}陷阱盲注{}机制",
                "取代原有的{C:red}-1{}弃牌"
            },
            aij_refreshed = "已刷新",
            aij_random_deck_skins_tooltip = {
                "添加到牌组中的{C:attention}游戏牌{}",
                "拥有随机的{C:attention}牌套皮肤"
            },
            k_aij_double_ex = "翻倍！",
            k_artist_badge = "艺术家徽章",
            aij_blue_stake_rework = "蓝注重做",
            aij_paid_off = "偿清"
        },
        poker_hand_descriptions = {
            ["aij_Royal Flush"] = {
                "5张连续点数的牌",
                "且所有牌花色相同",
                "且最小点数为10",
            }
        },
    },
    descriptions = {
        Blind = {
            --普通盲注
            bl_aij_the_beith = {
                name = "白桦",
                text = {
                    "所有{C:diamonds}方片{}牌",
                    "最后被抽出"
                },
            },
            bl_aij_the_elm = {
                name = "榆树",
                text = {
                    "所有{C:clubs}梅花{}牌",
                    "最后被抽出"
                },
            },
            bl_aij_the_alder = {
                name = "赤杨",
                text = {
                    "所有{C:hearts}红桃{}牌",
                    "最后被抽出"
                },
            },
            bl_aij_the_willow = {
                name = "柳树",
                text = {
                    "所有{C:spades}黑桃{}牌",
                    "最后被抽出"
                },
            },
            bl_aij_the_branch = {
                name = "枝桠",
                text = {
                    "所有{C:attention}人头牌{}",
                    "最后被抽出"
                },
            },
            bl_aij_the_horror = {
                name = "惊骇",
                text = {
                    "在回合的最后一次出牌时",
                    "为一张随机{C:attention}小丑牌{}",
                    "添加{C:perishable}易腐{}贴纸"
                },
            },
            bl_aij_the_oak = {
                name = "橡树",
                text = {
                    "削弱最右侧的",
                    "{C:attention}小丑牌{}"
                },
            },
            bl_aij_the_ingot = {
                name = "锭块",
                text = {
                    "在回合的最后一次出牌时",
                    "为所有{C:attention}小丑牌{}",
                    "添加{C:eternal}永恒{}贴纸"
                },
            },
            bl_aij_the_hazel = {
                name = "榛树",
                text = {
                    "击败此盲注时",
                    "为一张随机{C:attention}小丑牌{}",
                    "添加{C:rental}租用{}贴纸"
                },
            },
            bl_aij_the_apple = {
                name = "苹果",
                text = {
                    "如果回合的第一次出牌",
                    "就击败此盲注",
                    "则摧毁最左侧的小丑牌"
                },
            },
            bl_aij_the_neck = {
                name = "颈项",
                text = {
                    "每次只能弃掉",
                    "1张牌"
                },
            },
            bl_aij_the_groan = {
                name = "呻吟",
                text = {
                    "每次出牌后",
                    "盲注要求分数的基础倍率+1X"
                },
            },
            bl_aij_the_ash = {
                name = "灰烬",
                text = {
                    "完整牌组中每比",
                    "{C:attention}#1#少一张牌",
                    "盲注要求分数的基础倍率+0.2X"
                },
            },
            bl_aij_the_clay = {
                name = "黏土",
                text = {
                    "随机大盲注"
                },
            },
            bl_aij_the_aspen = {
                name = "白杨",
                text = {
                    "本底注中每击败一个盲注",
                    "盲注要求分数的基础倍率+2X"
                },
            },
            bl_aij_the_evergreen = {
                name = "常青",
                text = {
                    "完整牌组中每比",
                    "{C:attention}#1#张多一张牌",
                    "盲注要求分数的基础倍率+0.2X"
                },
            },
            bl_aij_the_enigma = {
                name = "谜题",
                text = {
                    "所有{C:enhanced}增强{}牌",
                    "最后被抽出"
                },
            },
            bl_aij_the_bullion = {
                name = "金条",
                text = {
                    "每打出一张增强牌",
                    "损失{C:money}$5{}"
                },
            },
            bl_aij_the_elbow = {
                name = "手肘",
                text = {
                    "打出的增强效果",
                    "会随机变化"
                },
            },
            bl_aij_the_thorn = {
                name = "荆棘",
                text = {
                    "削弱所有",
                    "{C:enhanced}增强牌{}"
                },
            },
            bl_aij_the_twin = {
                name = "双子",
                text = {
                    "{C:enhanced}增强牌{}",
                    "以背面朝上方式抽出"
                },
            },
            bl_aij_the_giant = {
                name = "巨人",
                text = {
                    "超大盲注",
                    "{C:blue}+2{}出牌次数"
                },
            },
            bl_aij_the_auroch = {
                name = "原牛",
                text = {
                    "所有{C:attention}#1#{}和{C:attention}#2#{}",
                    "以背面朝上方式抽出"
                },
            },
            bl_aij_the_journey = {
                name = "旅程",
                text = {
                    "如果本回合有",
                    "{C:attention}#1#{}花色牌计分",
                    "{C:attention}+1{}通关胜利底注"
                },
            },
            bl_aij_the_gift = {
                name = "赠礼",
                text = {
                    "将资金设为{C:money}$0{}",
                    "每打出或弃掉一张牌",
                    "获得{C:money}$1{}"
                },
            },
            bl_aij_the_ancestor = {
                name = "先祖",
                text = {
                    "本回合{C:attention}弃掉{}过的",
                    "{C:attention}牌型{}",
                    "不能再被{C:attention}打出{}"
                },
            },
            bl_aij_the_god = {
                name = "神祇",
                text = {
                    "所有打出的牌",
                    "都必须计分"
                },
            },
            bl_aij_the_beast = {
                name = "野兽",
                text = {
                    "击败此盲注时",
                    "摧毁所有{C:attention}食物{}小丑牌"
                },
            },
            bl_aij_the_ulcer = {
                name = "溃疡",
                text = {
                    "{C:blue}-1{}出牌次数",
                    "{C:red}-1{}弃牌次数"
                },
            },
            bl_aij_the_need = {
                name = "需求",
                text = {
                    "必须至少有{C:money}$20{}的资金",
                    "出牌才能计分"
                },
            },
            bl_aij_the_day = {
                name = "白昼",
                text = {
                    "出牌必须包含",
                    "{C:hearts}红桃{}或{C:diamonds}方片{}"
                },
            },
            bl_aij_the_celebration = {
                name = "庆典",
                text = {
                    "本底注中每剩一次",
                    "出牌或弃牌次数",
                    "盲注要求分数的基础倍率+0.2X"
                },
            },
            bl_aij_the_storm = {
                name = "风暴",
                text = {
                    "摧毁所有打出但",
                    "未计分的牌"
                },
            },
            bl_aij_the_frost = {
                name = "霜冻",
                text = {
                    "出牌后随机摧毁",
                    "留在手牌中的一张牌"
                },
            },
            bl_aij_the_yew = {
                name = "紫杉",
                text = {
                    "所有{C:attention}奇数点{}牌",
                    "都被削弱"
                },
            },
            bl_aij_the_hoard = {
                name = "囤积",
                text = {
                    "本底注中超出盲注通关需求的分数",
                    "会在选择此盲注时",
                    "添加到其需求上"
                },
            },
            bl_aij_the_pear = {
                name = "梨子",
                text = {
                    "计分后随机改变",
                    "留在手中的牌的",
                    "点数与花色"
                },
            },
            bl_aij_the_elk = {
                name = "麋鹿",
                text = {
                    "不能打出本底注中",
                    "已打出过的",
                    "牌型"
                },
            },
            bl_aij_the_birch = {
                name = "桦木",
                text = {
                    "所有{C:attention}偶数点{}牌",
                    "都被削弱"
                },
            },
            bl_aij_the_sun = {
                name = "太阳",
                text = {
                    "{C:spades}黑桃{}和{C:clubs}梅花{}",
                    "以背面朝上",
                    "方式抽出"
                },
            },
            bl_aij_the_spear = {
                name = "长矛",
                text = {
                    "击败盲注所",
                    "打出的牌型",
                    "被永久削弱"
                },
            },
            bl_aij_the_steed = {
                name = "骏马",
                text = {
                    "出牌时削弱",
                    "留在手中的",
                    "所有牌"
                },
            },
            bl_aij_the_figure = {
                name = "人偶",
                text = {
                    "出牌不能包含",
                    "3张或以上的人头牌"
                },
            },
            bl_aij_the_lake = {
                name = "湖泊",
                text = {
                    "本底注中打出过的牌",
                    "最后被",
                    "抽出"
                },
            },
            bl_aij_the_field = {
                name = "原野",
                text = {
                    "所有牌都被削弱",
                    "直到弃掉{C:attention}#1#{}张牌"
                },
            },
            bl_aij_the_wound = {
                name = "创伤",
                text = {
                    "直到弃牌次数",
                    "为0时",
                    "出牌才能计分"
                },
            },
            bl_aij_the_brimstone = {
                name = "硫磺",
                text = {
                    "每次弃牌",
                    "损失一半",
                    "资金"
                },
            },
            bl_aij_the_blush = {
                name = "赧颜",
                text = {
                    "每次必须弃掉",
                    "5张牌"
                },
            },
            --陷阱盲注
            bl_aij_the_heart = {
                name = "心脏",
                text = {
                    "必须先打出包含",
                    "{C:attention}#1#{}的牌型",
                    "后续出牌才能计分"
                },
            },
            bl_aij_the_rains = {
                name = "雨幕",
                text = {
                    "如果出牌击败此盲注",
                    "所有计分牌会失去",
                    "增强效果、版本",
                    "和蜡封"
                },
            },
            bl_aij_the_child = {
                name = "孩童",
                text = {
                    "将所有计分牌的",
                    "点数降低1级"
                },
            },
            bl_aij_the_moon = {
                name = "月亮",
                text = {
                    "所有奇数次出牌",
                    "中的牌都被削弱"
                },
            },
            bl_aij_the_shell = {
                name = "外壳",
                text = {
                    "每{C:attention}#2#张牌中有{C:attention}#1#张{}被削弱",
                    "每{C:attention}#4#张牌中有{C:attention}#3#张{}",
                    "以背面朝上方式抽出"
                },
            },
            bl_aij_the_earth = {
                name = "大地",
                text = {
                    "计分后",
                    "将所有手牌",
                    "变为{C:attention}石头牌{}"
                },
            },
            bl_aij_the_dragon = {
                name = "巨龙",
                text = {
                    "在手牌清空前",
                    "无法抽任何牌"
                },
            },
            bl_aij_the_mountain = {
                name = "山峦",
                text = {
                    "超大盲注",
                    "手牌上限{C:attention}+1{}"
                },
            },
            bl_aij_the_conflagration = {
                name = "烈焰",
                text = {
                    "如果出牌击败此盲注",
                    "摧毁所有打出的牌",
                    "以及手牌"
                },
            },
            bl_aij_the_umbilical = {
                name = "脐带",
                text = {
                    "每次出牌标记一张随机牌",
                    "被标记的牌不能",
                    "被打出或弃掉"
                },
            },
            bl_aij_the_divine = {
                name = "圣洁",
                text = {
                    "出牌必须包含",
                    "一张增强牌"
                },
            },
            bl_aij_the_bird = {
                name = "飞鸟",
                text = {
                    "计分前洗乱",
                    "1张随机小丑牌"
                },
            },
            bl_aij_the_arrow = {
                name = "箭矢",
                text = {
                    "出牌的分数必须",
                    "超过之前所有",
                    "出牌的分数"
                },
            },
            bl_aij_the_brilliance = {
                name = "光辉",
                text = {
                    "必须达到分数要求两次",
                    "{C:blue}+2{}出牌次数"
                },
            },
            --决胜盲注
            bl_aij_obsidian_blade = {
                name = "黑曜石刃",
                text = {
                    "{C:blue}-1{}出牌次数",
                    "{C:red}-1{}弃牌次数",
                    "手牌上限{C:attention}-1{}",
                    "大盲注"
                },
            },
            bl_aij_aureate_coin = {
                name = "鎏金币",
                text = {
                    "本底注中每花费{C:money}$1{}",
                    "盲注要求分数的基础倍率+0.1X"
                },
            },
        },
        Back = {
            b_aij_fabled = {
                name = '传奇牌组',
                text = {
                    '{C:legendary,E:1}传奇{}小丑牌可能',
                    '出现在{C:attention}商店{}',
                    '小丑牌槽位{C:attention}-1{}'
                },
                unlock = {
                    '解锁一张',
                    '{C:legendary,E:1}传奇{}小丑牌'
                }
            },
            b_aij_fabled_hidden = {
                name = '传奇牌组',
                text = {},
                unlock = {
                    '解锁一张',
                    '{C:legendary,E:1}传奇{}小丑牌'
                }
            },
            b_aij_branching = {
                name = '分岔牌组',
                text = {
                    '跳过后可从{C:attention}3{}个',
                    '{C:attention}标签{}中选择一个'
                },
                unlock = {
                    '在一局游戏中至少',
                    '跳过{C:attention}5{}个盲注'
                }
            },
            b_aij_branching_hidden = {
                name = '分岔牌组',
                text = {},
                unlock = {
                    '在一局游戏中至少',
                    '跳过{C:attention}5{}个盲注'
                }
            },
            b_aij_patchwork = {
                name = '拼布牌组',
                text = {
                    '所有游戏牌{C:attention}均带有',
                    '随机{C:attention}花色{}补丁'
                },
                unlock = {
                    '同时拥有至少{C:attention}13张',
                    '带有{C:attention}花色补丁{}的',
                    '卡牌'
                }
            },
            b_aij_patchwork_hidden = {
                name = '拼布牌组',
                text = {},
                unlock = {
                    '同时拥有至少{C:attention}13张',
                    '带有{C:attention}花色补丁{}的',
                    '卡牌'
                }
            }
        },
        Tag = {
            tag_aij_glimmer = {
                name = '微光标签',
                text = {
                    '下一个商店中的基础版本小丑牌',
                    '将会免费且变为{C:aij_plasma}微光{}版本'
                }
            },
            tag_aij_silver = {
                name = '银箔标签',
                text = {
                    '下一个商店中的基础版本小丑牌',
                    '将会免费且变为{C:aij_silver}银箔{}版本'
                }
            },
            tag_aij_stellar = {
                name = '星辰标签',
                text = {
                    '下一个商店中的基础版本小丑牌',
                    '将会免费且变为{C:aij_stellar}星辰{}版本'
                }
            },
            tag_aij_aureate = {
                name = '鎏金标签',
                text = {
                    '下一个商店中的基础版本小丑牌',
                    '将会免费且变为{C:money}鎏金{}版本'
                }
            },
            tag_aij_soulbound = {
                name = '灵魂绑定标签',
                text = {
                    '生成一张随机{C:attention}易腐{}的',
                    '{C:legendary}传奇{}小丑牌',
                    '{C:inactive}（必须有空位）'
                }
            },
            tag_aij_fortunate = {
                name = '幸运标签',
                text = {
                    '可选择生成一张任意{C:tarot}塔罗牌{}',
                    '{C:inactive}（必须有空位）'
                }
            },
            tag_aij_overstuffed = {
                name = '超载标签',
                text = {
                    '下一个开启的{C:attention}补充包{}',
                    '选择数量和可选数量都{C:attention}翻倍{}'
                }
            },
            tag_aij_chaos = {
                name = '混沌标签',
                text = {
                    '拥有{C:red}随机{}效果'
                }
            },
            -- 黄金标签
            tag_aij_windfall = {
                name = '横财标签',
                text = {
                    '{C:money}资金翻三倍{}'
                    -- TODO 需要上限
                }
            },
            tag_aij_unusual = {
                name = '非凡标签',
                text = {
                    '商店中有一张免费的',
                    '{C:uncommon}罕见小丑牌{}',
                    '且其数值{C:attention}翻倍{}'
                }
            },
            tag_aij_recherche = {
                name = '珍稀标签',
                text = {
                    '商店中有一张免费的',
                    '{C:rare}稀有小丑牌{}',
                    '且其数值{C:attention}翻倍{}'
                }
            },
            tag_aij_hermetic = {
                name = '秘传标签',
                text = {
                    '可选择生成一张任意',
                    '非隐藏的{C:spectral}幻灵牌{}',
                    '{C:inactive}（必须有空位）'
                }
            },
            tag_aij_dark_matter = {
                name = '暗物质标签',
                text = {
                    '为一张{C:attention}随机{}的',
                    '无版本小丑牌',
                    '添加{C:dark_edition}负片{}效果'
                }
            },
            tag_aij_crystal = {
                name = '水晶标签',
                text = {
                    '为一张{C:attention}随机{}小丑牌',
                    '和牌组中{C:attention}#1#{}张',
                    '无版本卡牌添加{C:dark_edition}闪箔{}效果'
                }
            },
            tag_aij_iridescent = {
                name = '虹彩标签',
                text = {
                    '为一张{C:attention}随机{}小丑牌',
                    '和牌组中{C:attention}#1#{}张',
                    '无版本卡牌添加{C:dark_edition}镭射{}效果'
                }
            },
            tag_aij_omnichrome = {
                name = '全彩标签',
                text = {
                    '为最右侧的',
                    '基础版本小丑牌',
                    '添加{C:dark_edition}多彩{}效果'
                }
            },
            tag_aij_circumplanetary = {
                name = '环星标签',
                text = {
                    '将最常用的{C:attention}牌型{}',
                    '提升{C:attention}#1#个等级',
                    '{C:inactive}（当前为#2#级）'
                }
            },
            tag_aij_velocity = {
                name = '速度标签',
                text = {
                    '给予{C:money}$#1#{}，每回合减少{C:money}$#2#{}',
                    '{C:inactive}（将获得{C:money}$#3#{C:inactive}）'
                }
            },
            tag_aij_capital = {
                name = '资本标签',
                text = {
                    '击败',
                    'Boss盲注后',
                    '获得{C:money}$#1#{}'
                }
            },
            tag_aij_bierstiefel = {
                name = '啤酒靴标签',
                text = {
                    '用随机的{C:common}普通{}或',
                    '{C:uncommon}罕见{}小丑牌',
                    '填满所有空的',
                    '{C:attention}小丑牌槽位{}'
                }
            },
            tag_aij_ticket = {
                name = '门票标签',
                text = {
                    '{C:attention}兑换{}一张随机',
                    '优惠券及其',
                    '{C:attention}升级版{}'
                }
            },
            tag_aij_galloping_domino = {
                name = '奔腾骨牌标签',
                text = {
                    '下一个商店中{C:attention}所有{}重掷',
                    '费用为{C:money}$#1#{}'
                    -- TODO 由于可能产生二次方资金增长，需要限制
                }
            },
            tag_aij_gioco = {
                name = '游戏标签',
                text = {
                    '下一回合',
                    '手牌上限{C:attention}翻倍{}'
                }
            },
            tag_aij_stereoscopic = {
                name = '立体标签',
                text = {
                    '给予下一个选择的{C:attention}标签{}',
                    '一个{C:money}金色{}复制品',
                    '{s:0.8}双倍标签{s:0.8}除外'
                }
            },
            tag_aij_frugal = {
                name = '节俭标签',
                text = {
                    '下一个商店中{C:attention}所有{}',
                    '卡牌和补充包',
                    '均为免费'
                }
            },
            tag_aij_dominus = {
                name = '主宰标签',
                text = {
                    '可选择任意{C:attention}Boss盲注{}',
                    '替换当前盲注'
                }
            },
            tag_aij_nonstandard = {
                name = '非标标签',
                text = {
                    '创建任意游戏牌的',
                    '{C:attention}2个复制品{}'
                }
            },
            tag_aij_ignoramus = {
                name = '无知标签',
                text = {
                    '可选择生成任意一张',
                    '{C:common}普通{}或{C:uncommon}罕见{}小丑牌',
                    '{C:inactive}（必须有空位）'
                }
            },
            tag_aij_occult = {
                name = '神秘标签',
                text = {
                    '创建{C:attention}3张{C:tarot}塔罗牌{}',
                    '和{C:attention}2张{C:spectral}幻灵牌{}',
                    '{s:0.8}它们均为{s:0.8,C:dark_edition}负片{}版本'
                }
            },
            tag_aij_asteroid = {
                name = '小行星标签',
                text = {
                    '给予一个免费的',
                    '{C:planet}天体包{}',
                    '其中包含{C:dark_edition}黑洞{}、',
                    '{C:dark_edition}脉冲星{}和{C:dark_edition}真空星{}'
                }
            },
            tag_aij_polydactyly = {
                name = '多指症标签',
                text = {
                    '本赛局每剩一次{C:blue}出牌{}次数',
                    '下一回合{C:blue}+1出牌{}',
                    '{C:inactive}（将给予{C:blue}+#1#{C:inactive}次出牌）'
                }
            },
            tag_aij_landfill = {
                name = '填埋场标签',
                text = {
                    '本赛局每{C:red}弃掉{}一张牌',
                    '获得{C:money}$1{}',
                    '{C:inactive}（将获得{C:money}$#1#{C:inactive}）'
                }
            },
            tag_aij_cinema = {
                name = '影院标签',
                text = {
                    '为最左侧的',
                    '基础版本小丑牌',
                    '添加{C:aij_silver}银箔{}效果'
                }
            },
            tag_aij_ventripotent = {
                name = '大腹便便标签',
                text = {
                    '下一个开启的{C:attention}补充包{}',
                    '选项数量{C:attention}翻倍{}',
                    '且可选数量{C:attention}无限制{}'
                }
            },
            tag_aij_timelost = {
                name = '失落时光标签',
                text = {
                    '给予一个免费的{C:purple}笑语猜谜包{}',
                    '包含{C:attention}5{}个易腐选项'
                }
            },
            tag_aij_auspicious = {
                name = '吉祥标签',
                text = {
                    '创建一张你选择的',
                    '{C:tarot}塔罗牌{}的',
                    '{C:attention}3个{C:dark_edition}负片{}复制品'
                }
            },
            tag_aij_glamour = {
                name = '魅力标签',
                text = {
                    '为{C:attention}2张随机{}的',
                    '无版本小丑牌',
                    '添加{C:aij_plasma}微光{}效果'
                }
            },
            tag_aij_superlunary = {
                name = '超月标签',
                text = {
                    '为一张{C:attention}随机{}小丑牌',
                    '和牌组中{C:attention}#1#{}张',
                    '无版本卡牌添加{C:aij_stellar}星辰{}效果'
                }
            },
            tag_aij_gold_dust = {
                name = '金粉标签',
                text = {
                    '为牌组中{C:attention}#1#{}张',
                    '无版本卡牌添加{C:money}鎏金{}效果'
                }
            },
            tag_aij_anarchy = {
                name = '无政府标签',
                text = {
                    '拥有{C:red}随机{}效果{C:red}！！！'
                }
            },
        },
        Stake = All_in_Jest.config.blue_stake_rework and {
            stake_blue = {
                name = "蓝注",
                text = {
                    '第{C:attention}4{}或{C:attention}5{}底注的',
                    'Boss盲注变为{C:attention}陷阱盲注{}',
                    '{s:0.8}之前所有赌注也都起效'
                }
            },
        } or {},
        Tarot = {
            c_aij_magus = {
                name = '魔术师',
                text = {
                    "将所选{C:attention}#1#{}张牌",
                    "增强为",
                    "{C:attention}#2#{}"
                }
            },
            c_aij_sanctuary_gate = {
                name = '圣殿之门',
                text = {
                    "将所选{C:attention}#1#{}张",
                    "牌增强为",
                    "{C:attention}#2#{}"
                }
            },
            c_aij_isis_urania = {
                name = '伊西斯-乌拉尼亚',
                text = {
                    "将所选{C:attention}#1#{}张牌",
                    "增强为",
                    "{C:attention}#2#{}"
                }
            },
            c_aij_cubic_stone = {
                name = '立方石',
                text = {
                    "将所选{C:attention}#1#{}张牌",
                    "增强为",
                    "{C:attention}#2#{}"
                }
            },
            c_aij_master_arcanes = {
                name = '秘法大师',
                text = {
                    "有{C:green}#1#/#2#{}几率",
                    "生成一张随机",
                    "{C:spectral}幻灵牌{}",
                    "{C:inactive}（必须有空位）"
                }
            },
            c_aij_two_ways = {
                name = '双途',
                text = {
                    "将所选{C:attention}#1#{}张牌",
                    "拆分为{C:attention}2{}张复制牌",
                    "牌面点数为原始牌的{C:attention}一半{}",
                    "{C:inactive}（单数牌会尽可能平均拆分）",
                    "{C:inactive}（A=14, K=13, Q=12, J=11）"
                }
            },
            c_aij_osiris = {
                name = '欧西里斯',
                text = {
                    "{C:red}摧毁{}所选{C:attention}1{}张",
                    "{C:attention}小丑牌{}并获得其",
                    "{C:money}出售价值{}的{C:attention}3倍{}",
                    "{C:inactive}（当前为{C:money}$#1#{C:inactive}）"
                }
            },
            c_aij_osiris_controller = {
                name = '欧西里斯',
                text = {
                    "{C:red}摧毁{}最右侧的",
                    "{C:attention}小丑牌{}并获得其",
                    "{C:money}出售价值{}的{C:attention}3倍{}",
                    "{C:inactive}（当前为{C:money}$#1#{C:inactive}）"
                }
            },
            c_aij_balance_and_blade = {
                name = '天平与刀刃',
                text = {
                    "为{C:attention}#1#{}张所选牌",
                    "{C:attention}补丁{}一个随机花色"
                }
            },
            c_aij_veiled_lamp = {
                name = '蒙纱之灯',
                text = {
                    "将所选{C:attention}#1#{}张牌",
                    "增强为",
                    "{C:attention}#2#{}"
                }
            },
            c_aij_sphinx = {
                name = '斯芬克斯',
                text = {
                    "将所选{C:attention}#1#{}张牌",
                    "增强为",
                    "{C:attention}#2#{}"
                }
            },
            c_aij_tamed_lion = {
                name = '驯服的狮子',
                text = {
                    "将所选{C:attention}#1#{}张牌",
                    "增强为",
                    "{C:attention}#2#{}"
                }
            },
            c_aij_broken_fate = {
                name = '破碎命运',
                text = {
                    "将最左侧消耗品的数值",
                    "随机调整至{C:attention}X0.75{}到{C:attention}X2.5{}之间"
                }
            },
        },
        Voucher = {
            v_aij_fairy_dust = {
                name = "精灵之尘",
                text = {
                    "{C:dark_edition}微光{}、{C:dark_edition}银箔{}和",
                    "{C:dark_edition}星辰{}卡牌",
                    "出现几率提高{C:attention}#1#X{}"
                },
            },
            v_aij_live_pixie = {
                name = "精灵显化",
                text = {
                    "{C:dark_edition}微光{}、{C:dark_edition}银箔{}和",
                    "{C:dark_edition}星辰{}卡牌",
                    "出现几率提高{C:attention}#1#X{}"
                },
            },
            v_aij_gold_medal = {
                name = "金牌",
                text = {
                    "{C:money}黄金{}标签出现",
                    "几率提高{C:attention}#1#X{}"
                },
            },
            v_aij_trophy = {
                name = "奖杯",
                text = {
                    "{C:attention}大盲注{}跳过标签",
                    "有{C:green}#1#/#2#{}几率",
                    "变为{C:money}黄金{}标签"
                },
            },
            v_aij_sticker_sheet = {
                name = "贴纸簿",
                text = {
                    "{C:attention}减轻{}",
                    "{C:red}负面{}",
                    "{C:attention}贴纸{}的效果"
                },
            },
            v_aij_polkadot = {
                name = "波点",
                text = {
                    "{C:attention}大幅减轻{}",
                    "{C:red}负面{}",
                    "{C:attention}贴纸{}的效果"
                },
            },
        },
        Edition = {
            e_aij_negative_playing_card = {
                name = "负片",
                text = {
                    "手牌上限{C:dark_edition}+#1#{}",
                    "{C:inactive}（复制时会移除）"
                },
            },
            e_aij_glimmer = {
                name = "微光",
                text = {
                    "{C:aij_plasma}平衡{}{C:attention}#1#%{}的",
                    "{C:chips}筹码{}和{C:mult}倍率{}"
                }
            },
            e_aij_silver = {
                name = "银箔",
                text = {
                    "效果{C:attention}X#1#{}"
                }
            },
            e_aij_stellar = {
                name = "星辰",
                text = {
                    "根据打出牌型的{C:attention}等级{}",
                    "每级{C:chips}+#1#{}筹码和{C:mult}+#2#{}倍率"
                }
            },
            e_aij_aureate = {
                name = "鎏金",
                text = {
                    "资金{C:money}X#1#{}",
                    "{C:inactive}（上限为{C:money}$#2#{C:inactive}）"
                }
            },
            e_aij_torn = {
                name = "撕裂",
                text = {

                }
            },
        },
        Planet = {
            c_aij_sol = {
                name = "太阳",
                text = {
                    "{S:0.8}（等级#1#）{}",
                    "提升{C:attention}#2#{}",
                    "{C:mult}+#4#{}倍率并且",
                    "{C:chips}+#3#{}筹码"
                }
            },
            c_aij_rogue = {
                name = "流浪行星",
                text = {
                    "提升所有你拥有的",
                    "{C:attention}小丑牌{}所提到的",
                    "{C:attention}牌型{}等级"
                }
            },
            c_aij_dark_star = {
                name = "暗星",
                text = {
                    "提升所有尚未",
                    "{C:attention}打出{}过的",
                    "{C:attention}牌型{}等级"
                }
            },
        },
        Enhanced = {
            m_aij_ice = {
                name = "冰牌",
                text = {
                    "{C:attention}总是{}会计分且",
                    "{C:red}无视{}出牌选择限制",
                    "{C:inactive}多余的冰牌不会",
                    "{C:inactive}影响牌型判定"
                }
            },
            m_aij_wood = {
                name = "木牌",
                text = {
                    "留在手牌中时给予{C:chips}+#3#{}筹码",
                    "手牌中每多一张{C:attention}木牌{}",
                    "额外给予{C:chips}+#2#{}筹码",
                    "{C:inactive}（当前为{C:chips}+#1#{C:inactive}筹码）"
                }
            },
            m_aij_simulated = {
                name = "模拟牌",
                text = {
                    "每回合{C:attention}第一次{}打出时",
                    "会{C:attention}返回{}",
                    "手牌"
                }
            },
            m_aij_canvas = {
                name = "画布牌",
                text = {
                    "{C:attention}复制{}右侧",
                    "游戏牌的点数和花色"
                }
            },
        },
        Spectral = {
            c_aij_gravastar = {
                name = '真空星',
                text = {
                    '提升所有',
                    '{C:legendary,E:1}牌型{}的',
                    '{C:chips}筹码{}等级'
                }
            },
            c_aij_pulsar = {
                name = '脉冲星',
                text = {
                    '提升所有',
                    '{C:legendary,E:1}牌型{}的',
                    '{C:mult}倍率{}等级'
                }
            },
            c_aij_shade = {
                name = '暗影',
                text = {
                    '为手牌中{C:attention}1{}张',
                    '随机卡牌',
                    '添加{C:dark_edition}负片{}版本'
                }
            },
            c_aij_trefle = {
                name = '三叶草',
                text = {
                    '{C:attention}重掷{}一张',
                    '选定的小丑牌',
                    "{C:inactive}（无法对永恒小丑牌使用）"
                }
            },
            c_aij_trefle_controller = {
                name = '三叶草',
                text = {
                    '{C:attention}重掷{}',
                    '最右侧的小丑牌',
                    "{C:inactive}（无法对永恒小丑牌使用）"
                }
            },
            c_aij_scopophobia = {
                name = '视线恐惧',
                text = {
                    '{C:red}摧毁{}一张随机{C:attention}小丑牌',
                    '及手牌中{C:attention}所有卡牌{}'
                }
            },
            c_aij_reshape = {
                name = '重塑',
                text = {
                    '将所有{C:attention}小丑牌{}变为',
                    '一张随机持有小丑牌的复制品',
                    '{C:inactive}（小丑牌保留其原始',
                    '{C:inactive}贴纸和版本效果）'
                }
            },
            c_aij_palmistry = {
                name = '手相术',
                text = {
                    '为手牌中所有卡牌',
                    '添加随机{C:attention}增强{}效果',
                    '手牌上限{C:red}-#1#{}'
                }
            },
            c_aij_gegenschein = {
                name = "对日照",
                text = {
                    '将所有{C:attention}打出{}过的',
                    '{C:dark_edition}隐藏牌型{}等级',
                    '设为它们被{C:attention}打出{}的',
                    '次数'
                }
            },
            c_aij_mirth = {
                name = '欢愉',
                text = {
                    '为你手牌中的',
                    '{C:attention}#1#{}张所选牌',
                    '添加一张{V:1}#2#{}'
                }
            },
        },
        Partner = {
            pnr_aij_simply = {
                name = "辛普莉",
                text = {
                    "回合结束时获得{C:mult}+#1#{}倍率",
                    "{C:inactive}（当前为{C:mult}+#2#{C:inactive}倍率）"
                },
                unlock = {
                    "在{C:attention}金注{}难度下",
                    "使用{C:attention}傻蛋西蒙{}",
                    "赢得一局"
                },
            },
            pnr_aij_fourwarning = {
                name = "四警",
                text = {
                    "如果弃牌中包含一张{C:attention}4{}",
                    "则获得{C:chips}+#1#{}筹码",
                    "{C:inactive}（当前为{C:chips}+#2#{C:inactive}筹码）"
                },
                unlock = {
                    "在{C:attention}金注{}难度下",
                    "使用{C:attention}惧四症{}",
                    "赢得一局"
                },
            },
            pnr_aij_nellie = {
                name = "内莉",
                text = {
                    "{C:dark_edition}负片{}小丑牌",
                    "出现几率提高{C:attention}#1#X{}"
                },
                unlock = {
                    "在{C:attention}金注{}难度下",
                    "使用{C:attention}负面南希{}",
                    "赢得一局"
                },
            },
            pnr_aij_scratch = {
                name = "刮刮",
                text = {
                    "在第{C:blue}奇数{}回合",
                    "{C:attention}重新触发{}最左侧",
                    "{C:attention}#1#张最右侧的小丑牌"
                },
                unlock = {
                    "在{C:attention}金注{}难度下",
                    "使用{C:attention}涂鸦{}",
                    "赢得一局"
                },
            },
            pnr_aij_banger = {
                name = "重击",
                text = {
                    "{C:green}重掷{}费用减少{C:money}$#1#{}",
                    "{C:inactive}（最低为{C:money}$0{C:inactive}）"
                },
                unlock = {
                    "在{C:attention}金注{}难度下",
                    "使用{C:attention}蠢蠢香肠{}",
                    "赢得一局"
                },
            },
            pnr_aij_flub = {
                name = "弗拉布",
                text = {
                    "{C:attention}永恒{}小丑牌",
                    "变为{C:money}#1#{}"
                },
                unlock = {
                    "在{C:attention}金注{}难度下",
                    "使用{C:attention}错误{}",
                    "赢得一局"
                },
            },
        },
        Sleeve = {
            sleeve_aij_fabled = {
                name = "传奇牌套",
                text = {
                    '{C:legendary,E:1}传奇{}小丑牌可能',
                    '出现在{C:attention}商店{}',
                    '小丑牌槽位{C:attention}-1{}'
                }
            },
            sleeve_aij_fabled_alt = {
                name = "传奇牌套",
                text = {
                    '{C:legendary,E:1}传奇{}小丑牌',
                    '出现得更{C:attention}频繁{}'
                },
            },
            sleeve_aij_patchwork = {
                name = "拼布牌套",
                text = {
                    '所有游戏牌{C:attention}均带有',
                    '随机{C:attention}花色{}补丁'
                }
            },
            sleeve_aij_patchwork_alt = {
                name = "拼布牌套",
                text = {
                    '所有游戏牌{C:attention}均带有',
                    '{C:attention}2个{}随机{C:attention}花色{}补丁'
                },
            },
        },
        Other = {
            -- 其他
            aij_patches_suit = {
                name = "补丁",
                text = {
                    "{C:attention}补丁{}花色为{V:1}#1#"
                }
            },
            aij_jest_mark_of_the_spear = {
                name = "长矛印记",
                text = {
                    '此{C:attention}牌{}已被',
                    '{C:attention}长矛{}',
                    '永久{C:red}削弱{}'
                }
            },
            card_extra_retriggers = {
                text = {
                    "此卡牌额外重新触发{C:attention}#1#{}次",
                },
            },
            showdown_blind = {
                name = "决胜盲注",
                text = {
                    "每{C:attention}#1#{}个底注",
                    "出现一次的",
                    "{C:attention}Boss盲注{}"
                }
            },
            reroll_joker = {
                name = "重掷",
                text = {
                    '将小丑牌替换为',
                    '同稀有度的',
                    '随机小丑牌'
                }
            },
            office_assistant_perishable = {
                name = "易腐",
                text = {
                    '花费{C:money}$3{}',
                    '{C:attention}重置{}所有',
                    '{C:attention}易腐{}小丑牌的倒计时'
                }
            },
            office_assistant_rental = {
                name = "租用",
                text = {
                    '支付小丑牌的',
                    '{C:money}基础售价{}',
                    '移除其{C:attention}租用{}贴纸'
                }
            },
            overdesigned_club = {
                name = "梅花",
                text = {
                    "计分的{C:clubs}梅花{}",
                    "给予{C:mult}+#1#{}倍率"
                }
            },
            overdesigned_spade = {
                name = "黑桃",
                text = {
                    "计分的{C:spades}黑桃{}",
                    "给予{C:chips}+#1#{}筹码"
                }
            },
            overdesigned_diamond = {
                name = "方片",
                text = {
                    "计分的{C:diamonds}方片{}",
                    "赚取{C:money}$#1#{}"
                }
            },
            overdesigned_heart = {
                name = "红桃",
                text = {
                    "计分的{C:hearts}红桃{}",
                    "给予{X:mult,C:white}X#1#{}倍率"
                }
            },
            p_aij_guess_the_jest = {
                name = "笑语猜谜包",
                text = {
                    '从{C:attention}#2#{}张隐藏的',
                    '{C:legendary,E:2}传奇{}小丑牌中选择{C:attention}#1#{}张'
                }
            },
            m_aij_dyscalcular_numbered_rank = {
                name = "数字点数",
                text = {
                    "{C:attention}2{}、{C:attention}3{}、{C:attention}4{}、{C:attention}5{}、{C:attention}6{}、",
                    "{C:attention}7{}、{C:attention}8{}、{C:attention}9{}和{C:attention}10{}"
                }
            },
            palindrome = {
                name = "回文数",
                text = {
                    "多位数且{C:attention}正反对称{}",
                    "{C:inactive}例如：33, 151, 3003"
                }
            },
            -- 贴纸
            aij_marked = {
                name = "标记",
                text = {
                    '不能{C:blue}打出{}',
                    '或{C:red}弃掉{}'
                }
            },
            aij_unusual_doubled = {
                name = "加倍",
                text = {
                    '效果{C:attention}X2{}',
                    '{C:inactive,s:0.8}（由非凡标签赋予）'
                }
            },
            aij_recherche_doubled = {
                name = "翻倍",
                text = {
                    '效果{C:attention}X2{}',
                    '{C:inactive,s:0.8}（由珍稀标签赋予）'
                }
            },
            -- （非贴纸但按贴纸处理）
            aij_jest_chaotic_card = {
                name = "混沌",
                text = {
                    "{X:mult,C:white} X#1# {}倍率",
                    "打出后其{C:edition}增强{}效果",
                    "会{C:attention}随机{}"
                }
            },
            -- 蜡封
            aij_smiley_seal = {
                name = "笑脸蜡封",
                text = {
                    '被{C:red}摧毁{}时',
                    '为{C:attention}#1#{}张随机',
                    '{C:attention}小丑牌添加版本效果'
                }
            },
            aij_melted_seal = {
                name = "熔融蜡封",
                text = {
                    '在{C:attention}手牌{}中时',
                    '会{C:attention}转变{}为第一张',
                    '计分的非{V:1}熔融{} {C:attention}蜡封{}'
                }
            },
            nevernamed_credits_info = {
                name = "信息",
                text = {
                    "{s:0.8}-制作了所有美术素材",
                    "{s:0.8}-构思了约半数效果",
                    "{s:0.8}-2024年12月开始参与Balatro美术"
                }
            },
            survivalaren_credits_info = {
                name = "信息",
                text = {
                    "{s:0.8}-编写了约半数内容代码",
                    "{s:0.8}-构思了约半数效果",
                    "{s:0.8}-最初创立了此模组",
                    "{s:0.8}-2025年4月初创建此模组"
                }
            },
            rattling_snow_credits_info = {
                name = "信息",
                text = {
                    "{s:0.8}-编写了大部分高级功能代码",
                    "{s:0.8}-编写了几乎所有UI代码",
                    "{s:0.8}-编写了所有着色器代码",
                    "{s:0.8}-2025年4月底加入团队"
                }
            },
            jumbocarrot_credits_info = {
                name = "信息",
                text = {
                    "{s:0.8}-协助了大量错误修复和优化",
                    "{s:0.8}-真的，修复了超多错误",
                    "{s:0.8}-主要游戏测试者",
                    "{s:0.8}-2025年9月加入团队"
                }
            },
        },
        Joker = {
            j_aij_saucy_jacky = {
                name = "风骚杰基",
                text = {
                    "暂无效果"
                }
            },
            j_aij_privelege_fabled = {
                name = "弄臣特权",
                text = {
                    "{C:legendary}传奇{}小丑牌",
                    "出现得{C:attention}更频繁{}",
                },
            },
            j_aij_baddata = {
                name = "坏数据",
                text = {
                    "获得随机效果和数值",
                    "{C:inactive}（基于种子生成）{}"
                }
            },
            j_aij_weatherman = {
                name = "气象员",
                text = {
                    "暂无效果"
                }
            },
            j_aij_rock_n_roll_clown = {
                name = "Rock n' Roll Clown",
                text = {
                    "暂无效果"
                }
            },
            j_aij_colquhoun = {
                name = "科尔霍恩",
                text = {
                    "所有牌计分时赚取{C:money}$#1#{}",
                    "击败{C:attention}Boss盲注{}时",
                    "此金额增加{C:money}$#2#{}"
                },
                unlock = {
                    "?????"
                }
            },
            j_aij_cut_here = {
                name = "从此处剪开",
                text = {
                    "当此小丑牌被{C:red}摧毁{}时",
                    "生成一张随机{C:red}稀有{}小丑牌"
                }
            },
            j_aij_cavalier = {
                name = "骑士",
                text = {
                    "每次出牌获得{C:mult}+#2#{}倍率",
                    "回合结束时重置",
                    "{C:inactive}（当前为{C:mult}+#1#{C:inactive}倍率）"
                }
            },
            j_aij_chromatist = {
                name = "彩绘师",
                text = {
                    "当{C:attention}多彩{}版本",
                    "效果触发时",
                    "{X:mult,C:white}X#1#{}倍率"
                }
            },
            j_aij_firework = {
                name = "烟花",
                text = {
                    "第一张打出的{C:attention}倍率牌{}",
                    "计分时给予{X:mult,C:white}X#1#{}倍率"
                }
            },
            j_aij_graffiti = {
                name = "涂鸦",
                text = {
                    {
                        '{B:1,C:white,s:0.8}主动能力',
                        '支付{C:money}$#1#{}获得一个',
                        '随机{C:attention}标签'
                    },
                    {
                        '每次支付后{C:money}费用{}{C:red}X#2#',
                        '击败{C:attention}Boss盲注{}后',
                        '重置'
                    }
                }
            },
            j_aij_survivalaren_credits_joker = {
                name = "Survivalaren",
                text = {
                    '{C:inactive}"放松点"'
                },
            },
            j_aij_rattling_snow_credits_joker = {
                name = "RattlingSnow353",
                text = {
                    '{C:inactive}样样通，却样样不精，',
                    '{C:inactive}但往往仍胜过',
                    '{C:inactive}只精通一事之人。'
                },
            },
            j_aij_jumbocarrot_credits_joker = {
                name = "Jumbocarrot",
                text = {
                    '{C:inactive}"Hi Alex"'
                },
            },
            j_aij_pink_slip = {
                name = "解雇通知单",
                text = {
                    "{C:attention}弃牌{}的",
                    "选择上限{C:red}+#1#{}"
                }
            },
            j_aij_death_of_a_salesman = {
                name = "推销员之死",
                text = {
                    "每个{C:money}商店{}中",
                    "有{C:attention}#1#{}个{C:red}混沌{}或{C:red}无政府{}",
                    "{C:attention}标签{}可供购买"
                }
            },
            j_aij_rudolph = {
                name = "鲁道夫",
                text = { "暂无效果" }
            },
            j_aij_stage_production = {
                name = "舞台制作",
                text = {
                    '{B:1,C:white,s:0.8}主动能力',
                    '每回合一次，{C:attention}临时',
                    '{C:attention}重掷{}右侧的小丑牌',
                    '持续到选择下一个盲注',
                    '{C:inactive}#1#'
                }
            },
            j_aij_elder = {
                name = "长老",
                text = {
                    '复制你持有时间',
                    '{C:attention}最长{}的',
                    '{C:attention}小丑牌{}能力',
                    '{C:inactive}（当前为#1#）'
                }
            },
            j_aij_bad_guy = {
                name = "坏家伙",
                text = {
                    '击败{C:attention}Boss盲注{}时',
                    '为手牌中一张随机',
                    '游戏牌添加{C:attention}闪箔{}版本'
                }
            },
            j_aij_youve_got_mail = {
                name = "你有新邮件",
                text = {
                    {
                        '如果此小丑牌{C:red}不是{}{C:dark_edition}负片{}版本',
                        '选择{C:attention}盲注{}时',
                        '创建一个此小丑牌的',
                        '{C:dark_edition}负片{}复制品，售价{C:money}$0{}'
                    },
                    {
                        '{V:1}{B:3,V:2}#1##2#{}{V:1}#3#',
                    }
                }
            },
            j_aij_vecchio_dolore = {
                name = "旧日伤痛",
                text = {
                    '暂无效果',
                }
            },
            j_aij_infamous_machine = {
                name = "臭名昭著的机器",
                text = {
                    '暂无效果',
                }
            },
            j_aij_mp_blind_drawn = {
                name = "盲抽",
                text = {
                    "{X:mult,C:white}X#1#{}倍率",
                    "在{C:attention}PvP盲注{}期间",
                    "无法查看{X:purple,C:white}对手{}的",
                    "分数或剩余出牌次数"
                }
            },
            j_aij_bozo = {
                name = "波佐",
                text = {
                    "击败{C:attention}Boss盲注{}时",
                    "生成{C:attention}#1#{}张随机",
                    "{C:dark_edition}负片{}小丑牌"
                },
                unlock = { "?????" }
            },
            j_aij_pencil_drawing = {
                name = {
                    "铅笔画",
                },
                text = {
                    '{B:1,C:white,s:0.8}主动能力',
                    '支付{C:money}$#1#{}将一张随机',
                    '{C:attention}游戏牌{}加入手牌'
                }
            },
            j_aij_headfooter = {
                name = "页眉页脚"
            },
            j_aij_thalia = {
                name = "塔利亚",
                text = {
                    "如果回合的{C:attention}第一次弃牌{}",
                    "只有{C:attention}1{}张牌",
                    "这张牌永久获得{C:attention}+#1#{}次重新触发"
                },
                unlock = { "?????" }
            },
            j_aij_czar = {
                name = "沙皇",
                text = {
                    "复制你的{C:attention}收藏{}中",
                    "一张已发现的",
                    "随机小丑牌的",
                    "{C:attention}能力{}",
                    "{C:inactive}（商店重掷时改变）"
                }
            },
            j_aij_fleshgait = {
                name = "血肉步态",
                text = {
                    "如果计分的牌{C:red}没有{}",
                    "{C:attention}花色补丁{}",
                    "会获得一个随机{C:attention}花色补丁"
                }
            },
            j_aij_pure_baseball_card = {
                name = "纯粹棒球卡",
                text = {

                }
            },
            j_aij_historian = {
                name = "历史学家",
                text = {
                    "添加等同于最后售出",
                    "小丑牌{C:money}售价{}",
                    "{C:attention}三倍{}的{C:mult}倍率{}",
                    "{C:inactive}（当前为{C:mult}+#1#{C:inactive}倍率）"
                }
            },
            j_aij_tool = {
                name = "工具",
                text = {
                    "游戏牌改变{C:attention}花色{}时",
                    "永久获得{C:mult}+#1#{}倍率"
                }
            },
            j_aij_mike_check = {
                name = "麦克风测试",
                text = { "暂无效果" }
            },
            j_aij_a_young_hamlet = {
                name = "少年哈姆雷特",
                text = {
                    "每{C:red}弃掉{C:attention}#3#{}{C:inactive} [#4#]{}张牌",
                    "此小丑牌获得{C:mult}+#2#{}倍率",
                    "{C:inactive}（当前为{C:mult}+#1#{C:inactive}倍率）"
                }
            },
            j_aij_parking_space = {
                name = "停车位",
                text = {
                    "如果此小丑牌位于",
                    "{C:attention}小丑牌槽位#2#{}",
                    "则{X:mult,C:white}X#1#{}倍率",
                    "{C:inactive}（回合结束时槽位改变）"
                }
            },
            j_aij_mp_fall_of_count_chaligny = {
                name = "沙利尼伯爵之陨",
                text = {
                    "将所有{C:attention}盲注{}的",
                    "{C:attention}所需分数{}设为",
                    "{C:attention}1X{}基础倍率",
                    "{C:inactive}（不影响PvP盲注）"
                }
            },
            j_aij_office_assistant = {
                name = "办公室助手",
                text = {
                    '{B:1,C:white,s:0.8}主动能力',
                    '修复右侧小丑牌的',
                    '{C:attention}易腐{}或{C:attention}租用{}贴纸效果'
                }
            },
            j_aij_hei_tiki = {
                name = "毛利玉饰",
                text = {
                    "如果出牌的最终{C:chips}筹码{}",
                    "超过{C:mult}倍率{}",
                    "此{C:attention}小丑牌{}获得{X:mult,C:white}X#2#{}倍率",
                    "{C:inactive}（当前为{X:mult,C:white}X#1#{C:inactive}倍率）"
                }
            },
            j_aij_kasperle = {
                name = "卡斯佩尔",
                text = {
                    "若{C:attention}本回合{}购买了{C:attention}优惠券",
                    "{X:mult,C:white}X#1#{}倍率",
                    "{C:inactive}#2#"
                }
            },
            j_aij_columbina = {
                name = "科伦比娜",
                text = {
                    "{C:aij_plasma}平衡{}{C:attention}#1#%{}的{C:mult}倍率{}和{C:chips}筹码{}",
                    "使用{C:spectral}幻灵牌{}时",
                    "数值增加{C:attention}#2#%{}"
                }
            },
            j_aij_heidelberg_tun = {
                name = "海德堡酒桶",
                text = {
                    "为每个商店中",
                    "第一张购买的{C:attention}消耗牌{}",
                    "添加{C:dark_edition}负片{}效果",
                    "{C:inactive}#1#"
                },
            },
            j_aij_kilroy = {
                name = "基尔罗伊",
                text = {
                    "{C:money}售出{}此小丑牌时",
                    "其{C:chips}筹码{}价值{C:attention}翻倍{}",
                    "{C:inactive}（当前为{C:chips}+#1#{C:inactive}筹码）",
                }
            },
            j_aij_jumbo_joker = {
                name = "巨型小丑",
                text = {
                    "只会出现{C:attention}巨型{}",
                    "和{C:attention}超级{}补充包",
                }
            },
            j_aij_straight_to_hell = {
                name = "顺子地狱",  -- Straight to Hell 为双关翻译
                text = {
                    "如果弃牌中包含{C:attention}顺子{}",
                    "此{C:attention}小丑牌{}获得{X:mult,C:white}X#1#{}倍率",
                    "{C:inactive}（当前为{X:mult,C:white}X#2#{C:inactive}倍率）"
                },
            },
            j_aij_cesar = {
                name = "凯撒大帝",
                text = {
                    "每次出牌获得{C:money}$#1#{}",
                    "如果出牌仅为{C:diamonds}方片{}{C:attention}K{}",
                    "则额外增加{C:money}$#2#{}"
                },
            },
            j_aij_charles = {
                name = "查理大帝",
                text = {
                    "如果{C:attention}打出的牌{}仅有一张",
                    "{C:hearts}红桃{}{C:attention}K{}",
                    "此小丑牌获得{X:mult,C:white}X#1#{}倍率",
                    "{C:inactive}（当前为{X:mult,C:white}X#2#{C:inactive}倍率）"
                },
            },
            j_aij_alexandre = {
                name = "亚历山大大帝",
                text = {
                    "如果{C:attention}打出的牌{}仅有一张",
                    "{C:clubs}梅花{}{C:attention}K{}",
                    "此小丑牌获得{C:mult}+#1#{}倍率",
                    "{C:inactive}（当前为{C:mult}+#2#{C:inactive}倍率）"
                },
            },
            j_aij_david = {
                name = "大卫王",
                text = {
                    "如果{C:attention}打出的牌{}仅有一张",
                    "{C:spades}黑桃{}{C:attention}K{}",
                    "此小丑牌获得{C:chips}+#1#{}筹码",
                    "{C:inactive}（当前为{C:chips}+#2#{C:inactive}筹码）"
                },
            },
            j_aij_fou_du_roi = {
                name = "宫廷弄臣",
                text = {
                    "如果打出的牌包含{C:attention}K{}或{C:attention}Q{}",
                    "有{C:green}#1#/#2#{}几率",
                    "生成一张{C:tarot}塔罗牌{}",
                    "{C:inactive}（必须有空位）"
                },
                -- 可能的歧义：计分/打出
            },
            j_aij_animatronic = {
                name = "机械玩偶",
                text = {
                    "连续打出包含{C:attention}顺子{}的牌型",
                    "手牌上限{C:attention}+#1#{}",
                    "{C:inactive}（当前为{C:attention}+#2#{C:inactive}手牌上限）",
                    "{C:inactive}（上限为{C:attention}+#3#{C:inactive}）"
                }
            },
            j_aij_hofnarr_the_barbarian = {
                name = "野蛮人霍夫纳尔",
                text = {
                    "{C:mult}+#1#{}倍率",
                    "在{C:attention}决胜Boss盲注{}中",
                    "{C:attention}消除盲注的限制条件{}",
                    "并给予{X:mult,C:white}X#2#{}倍率"
                },
            },
        },

    },
}
