-- Cryptid 属于热门模组，一般更新较快，这里仅对缺失的翻译进行填充
return {
    descriptions = {
        Back = {
            b_cry_antimatter_custom = {
                unlock = {
                    "使用{C:attention}空白牌组{}",
                    "在{C:attention}金注{}难度下",
                    "赢得一局"
                },
                name = "反物质牌组",
                text = {
                    "获得所有使用",
                    "{C:gold}金注{}难度",
                    "获胜的{C:attention}部分牌组{}",
                    "的{C:legendary,E:1}正面{}效果"
                }
            },
        },
        Code = {
            c_cry_exploit = {
                name = "://利用",
                text = {
                    "{C:cry_code}选中{}一个{C:cry_code}当前可见{}的牌型",
                    "下一手牌将{C:cry_code}被计算{}为该牌型",
                    "并获得{C:cry_code}1{}点临时{C:cry_code}晋升强度{}"
                }
            },
        },
        Planet = {
            c_cry_perkele = {
                name = "Perkele",
                text = {
                    "（{V:1}等级#4#{}）（{V:2}等级#5#{}）（{V:3}等级#6#{}）",
                    "提升以下牌型等级：",
                    "{C:attention}#1#{}",
                    "{C:attention}#2#{}",
                    "与{C:attention}#3#{}",
                    "{C:inactive}（当前为{X:gold,C:white}X#7#{C:inactive} {C:chips}筹码{}+{C:mult}倍率{C:inactive}倍乘",
                    "{C:inactive}每{C:attention}1{C:inactive}点升阶强度）"
                }
            },
            c_cry_sunplanet2 = {
                name = "Sol",
                text = {
                    "{S:0.8}（{S:0.8,V:1}等级#1#{S:0.8}）{}",
                    "{C:attention}已升阶{}牌型的",
                    "升阶系数提升{X:gold,C:white}#2#{}",
                    "{C:inactive}（当前为{X:gold,C:white}+#3#{C:inactive} {C:chips}筹码{}+{C:mult}倍率{C:inactive}倍乘",
                    "{C:inactive}每{C:attention}1{C:inactive}点升阶强度）"
                }
            },
        },
        Other = {
            asc_misc2 = {
                name = "升阶手牌信息",
                text = {
                    "{C:gold}#1#{} 点升阶强度",
                    "{X:gold,C:white}X#2#{C:chips} 筹码{}与{C:mult}倍率",
                    "{C:inactive}（{C:gold}#3#{C:inactive} X {C:gold}#1#{C:inactive}）"
                }
            },
            cry_hooked_2 = {
                name = "已钩住",
                text = {
                    "当此小丑牌被{C:cry_code}触发{}时",
                    "触发{C:cry_code}#1#",
                    "{C:inactive}并非所有卡牌都能以此方式触发{}",
                    "{C:inactive}但所有小丑牌都能触发彼此{}"
                }
            },
            o_sunplanet = {
                name = "天文台效果"
            },
            o_nstar = {
                name = "天文台效果"
            },
            asc_misc = {
                name = "升华手牌信息"
            },
            o_planetlua = {
                name = "天文台效果",
                text = {
                    ""
                }
            },
            ev_cry_choco0 = {
                name = "可能事件",
                text = {
                    "{T:ev_cry_choco1}1{} {T:ev_cry_choco2}2{} {T:ev_cry_choco3}3{} {T:ev_cry_choco4}4{} {T:ev_cry_choco5}5{}",
                    "{T:ev_cry_choco6}6{} {T:ev_cry_choco7}7{} {T:ev_cry_choco8}8{} {T:ev_cry_choco9}9{} {T:ev_cry_choco10}10{}",
                    "{C:inactive}（悬停查看信息）"
                }
            },
            o_perkele = {
                name = "天文台效果"
            }
        },
        Joker = {
            j_cry_broken_sync_catalyst = {
                name = "破碎同步催化剂",
                text = {
                    "将 {C:chips}筹码{}的 {C:attention}#1#%{}",
                    "与 {C:mult}倍率{}的 {C:attention}#1#%{} 交换",
                    "{C:inactive,s:0.8}我见过这东西...",
                    "{C:inactive,s:0.8}...当年可比现在风光。"
                }
            },
            j_cry_thalia = {
                name = "Thalia and Melpomeme",
                text = {
                    "每对不同的稀有度",
                    "给予{C:white,X:mult}X#1#{}倍率",
                    "{C:inactive}（当前为{C:white,X:mult}X#2#{C:inactive}）{}"
                }
            },
            j_cry_keychange = {
                name = "移调",
                text = {
                    "如果{C:attention}牌型{}",
                    "本回合尚未打出过",
                    "则获得{C:white,X:mult}X#1#{}",
                    "在{C:attention}回合结束时{}重置",
                    "{C:inactive}（当前为{C:white,X:mult}X#2#{C:inactive}）{}"
                }
            },
            j_cry_caeruleum = {
                name = "蔚蓝",
                text = {
                    "相邻的{C:chips}筹码{}修正小丑牌",
                    "计分时使用高一级的{C:attention}运算方式{}",
                    "{C:inactive}（最高为乘方运算）"
                }
            },
        },
    },
    misc = {
        v_dictionary = {
            tax_hand = {
                "最高为所需筹码的#1#%"
            }
        },
        labels = {
            cry_global_sticker = "全局",
            cry_absolute = "绝对",
            pinned = "固定"
        },
        achievement_descriptions = {
            ach_cry_stoned = "将ERROR提升至5252级",
            ach_cry_youre_fucking_kidding = "弃掉ERROR",
            ach_cry_technically_positive = "获得一张负负小丑牌",
            ach_cry_fucked = "将ERROR提升至69级",
            ach_cry_pin = "因“别针”盲注输掉一局"
        },
        poker_hands = {
            ["cry-Cluster Bulwark"] = "碉堡群",
            cry_None = "空气"
        },
        dictionary = {
            cry_gameset_custom = "自定义",
            k_content_set = "主题合集",
            cry_divorced = "离婚！",
            cry_destroyed_ex = "已摧毁！",
            cry_sapling_a = "一株",
            cry_code_suitless = "手牌无需特定花色",
            cry_family = "家庭友好模式",
            b_planet_rate = "星球牌出现率",
            cry_gameset_modest = "轻度",
            cry_plus_code = "+1 代码牌",
            cry_blind_baneful_pack = "回合结束后",
            "打开一个{C:attention}厄运小丑包",
            k_cry_baneful_pack = "厄运小丑包",
            rush_hour_reminder = "启用钟表与薰衣草循环",
            "以游玩尖峰时刻模式",
            cry_joke_placeholder = "（8的倍数）",
            b_tag = "标签",
            cry_plus_card = "+1 卡牌",
            cry_demicolon = "触发半边！",
            k_planet_nibiru = "无",
            cry_gameset_madness = "疯狂",
            b_playing_cards = "游戏牌",
            cry_gameset_mainline = "主线",
            cry_mus_alt_bg = "背景音乐（作者：MathIsFun_）",
            cry_experimental = "实验模式",
            cry_force_tooltips = "强制显示提示",
            b_store = "商店",
            cry_baneful_warning = "跳过会放逐最右侧的小丑牌",
            cry_gameset_Custom = "自定义",
            k_cry_shiny = "闪亮",
            cry_sapling_an = "一株",
            b_tarot_rate = "塔罗牌出现率",
            cry_highfive_ex = "击掌！",
            cry_tax_placeholder = "（X0.4盲注要求）",
            k_downgraded_ex = "降级！",
            b_content_sets = "主题合集",
            b_blind = "盲注",
            cry_balanced_q = "平衡...？"
        },
        achievement_names = {
            ach_cry_stoned = "石化",
            ach_cry_despaired = "绝望",
            ach_cry_pin = "耻辱之钉",
            ach_cry_fucked = "Fucked",
            ach_cry_youre_fucking_kidding = "你tm在逗我",
            ach_cry_technically_positive = "理论正数",
            ach_cry_decked = "重装上阵"
        },
    }
}
