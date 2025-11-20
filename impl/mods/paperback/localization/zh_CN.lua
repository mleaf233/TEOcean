return {
    descriptions = {
        Back = {
            b_paperback_passionate = {
                name = "热忱牌组",
                text = {
                    "每击败一次",
                    "{C:attention}Boss盲注{}后，获得",
                    "{C:attention,T:tag_paperback_high_risk}#1#",
                    "不获得任何{C:money}利息"
                }
            },
            b_paperback_antique = {
                name = "古旧牌组",
                text = {
                    "{C:tarot}秘术包{}将不再",
                    "出现在商店中",
                    "{C:paperback_minor_arcana}秘仪包",
                    "出现频率提升为{C:attention}3X{}"
                }
            },
            b_paperback_dreamer = {
                name = "追梦者牌组",
                text = {
                    "开局时获得一张{C:paperback_temporary}临时{}的",
                    "{C:paperback_minor_arcana,T:c_paperback_apostle_of_wands}#1#",
                    "{C:attention}#2#{}个小丑牌槽位"
                }
            },
            b_paperback_paper = {
                name = "纸制牌组",
                text = {
                    "{C:legendary}Paperback{C:attention} 小丑{}有{C:attention}3X{}的可能出现",
                    "开局时获得",
                    "{C:attention,T:j_paperback_shopping_center}#1#{}"
                }
            }
        },

        Blind = {
            bl_paperback_quarter = {
                name = "四等分",
                text = {
                    "#1# / #2# 的游戏牌",
                    "会被削弱"
                }
            },
            bl_paperback_rest = {
                name = "安息",
                text = {
                    "#1# / #2# 的数字牌",
                    "将以背面朝上方式抽取"
                }
            },
            bl_paperback_sharp = {
                name = "升调",
                text = {
                    "提升打出牌的",
                    "点数"
                }
            },
            bl_paperback_half = {
                name = "折半",
                text = {
                    "所有列出的",
                    "概率均减半"
                }
            },
            bl_paperback_whole = {
                name = "整体",
                text = {
                    "在本底注中此前计分过的",
                    "点数都会被削弱"
                }
            },
            bl_paperback_flat = {
                name = "平面",
                text = {
                    "降低打出牌的",
                    "点数等级"
                }
            },
            bl_paperback_taupe_treble = {
                name = "灰褐三连",
                text = {
                    "必须打出",
                    "一张增强牌"
                }
            },
            bl_paperback_coda = {
                name = "终章",
                text = {
                    "游戏牌与小丑牌",
                    "均不可移动"
                }
            },
            bl_paperback_natural = {
                name = "自然",
                text = {
                    "牌型中高于你最低",
                    "牌型等级的游戏牌",
                    "都会被削弱"
                }
            }
        },
        paperback_minor_arcana = {
            c_paperback_queen_of_swords = {
                name = "宝剑皇后",
                text = {
                    "将完整牌组中{C:attention}#1#{}张随机",
                    "且{C:attention}花色不同{}的游戏牌",
                    "转换为选定牌的{C:attention}花色"
                }
            },
            c_paperback_ten_of_swords = {
                name = "宝剑十",
                text = {
                    "{C:attention}摧毁{}牌组中",
                    "与选定牌{C:attention}点数相同{}的",
                    "所有游戏牌"
                }
            },
            c_paperback_eight_of_swords = {
                name = "宝剑八",
                text = {
                    "为最多{C:attention}#1#{}张选定的游戏牌",
                    "添加随机{C:attention}别针"
                }
            },
            c_paperback_seven_of_swords = {
                name = "宝剑七",
                text = {
                    "为最多{C:attention}#1#{}张选定的游戏牌",
                    "添加{C:attention}金色别针"
                }
            },
            c_paperback_five_of_wands = {
                name = "宝剑五",
                text = {
                    "摧毁所有",
                    "{C:attention}留在手牌中的游戏牌{}，",
                    "将资金设为{C:money}$0"
                }
            },
            c_paperback_knight_of_swords = {
                name = "宝剑骑士",
                text = {
                    "生成一张随机{C:paperback_minor_arcana}塔罗辅牌{}",
                    "和一张随机{C:tarot}塔罗牌{}",
                    "{C:inactive}（必须有空位）"
                }
            },
            c_paperback_five_of_swords = {
                name = "宝剑五",
                text = {
                    "选择{C:attention}#1#{}张游戏牌，摧毁",
                    "最右侧两张并为",
                    "最左侧一张添加随机{C:attention}版本{}、",
                    "{C:attention}蜡封{}或{C:attention}增强效果",
                    "{C:inactive}（可拖动调整位置）"
                }
            },
            c_paperback_page_of_swords = {
                name = "宝剑侍从",
                text = {
                    "将{C:attention}#1#{}张选定",
                    "游戏牌增强为",
                    "{C:attention}#2#"
                }
            },
            c_paperback_six_of_swords = {
                name = "宝剑六",
                text = {
                    "为{C:attention}#1#{}张选定游戏牌",
                    "添加{C:attention}黄色别针"
                }
            },
            c_paperback_nine_of_swords = {
                name = "宝剑九",
                text = {
                    "摧毁选定小丑牌",
                    "{C:attention}本局游戏{}",
                    "此牌{C:red}无法{}再次出现"
                }
            },
            c_paperback_four_of_swords = {
                name = "宝剑四",
                text = {
                    "将最多{C:attention}#1#{}张",
                    "选定游戏牌转换为",
                    "随机{C:attention}人头牌"
                }
            },
            c_paperback_king_of_swords = {
                name = "宝剑国王",
                text = {
                    "移除选定小丑牌的",
                    "{C:money}租用{}和{C:paperback_perishable}易腐{}贴纸"
                }
            },
            c_paperback_two_of_swords = {
                name = "宝剑二",
                text = {
                    "将最多",
                    "{C:attention}#1#{}张选定游戏牌",
                    "转换为上次{C:attention}计分{}的花色",
                    "{C:inactive}（当前：{V:1}#2#{C:inactive}）"
                }
            },
            c_paperback_three_of_swords = {
                name = "宝剑三",
                text = {
                    "将{C:attention}#1#{}张选定",
                    "游戏牌增强为",
                    "{C:attention}#2#"
                }
            }
        },
        Partner = {
            pnr_paperback_faker_buffed = {
                text = {
                    "如果打出的牌是",
                    "{C:attention}单张牌{}，则将其摧毁"
                }
            },
            pnr_paperback_faker = {
                name = "伪装者",
                text = {
                    "{C:attention}每回合一次{}，",
                    "如果打出的牌是",
                    "{C:attention}单张牌{}，则将其摧毁"
                }
            },
            pnr_paperback_virtual = {
                name = "虚拟",
                text = {
                    "重新触发每手牌中",
                    "第一个计分的{C:paperback_light_suit}亮花色{}",
                    "（当未打出{C:paperback_dark_suit}暗花色{}时）"
                }
            },
            pnr_paperback_aftermath = {
                name = "余波",
                text = {
                    "{C:attention}人头牌{}在计分时",
                    "{C:chips}+#1#{}筹码"
                }
            }
        },
        Sleeve = {
            sleeve_paperback_paper = {
                name = "纸制牌套",
                text = {
                    "{C:legendary}Paperback{C:attention}小丑{}出现概率",
                    "{C:attention}3X{}，开局时拥有",
                    "{C:attention,T:j_paperback_shopping_center}#1#{}"
                }
            },
            sleeve_paperback_antique = {
                name = "古风牌套",
                text = {
                    "{C:tarot}秘术包{}不再",
                    "出现在商店中",
                    "{C:paperback_minor_arcana}秘仪包",
                    "出现概率{C:attention}3X{}"
                }
            },
            sleeve_paperback_paper_buff = {
                name = "纸制牌套",
                text = {
                    "开局时拥有{C:dark_edition}负片{}",
                    "{C:attention,T:j_paperback_shopping_center}#1#{}小丑牌"
                }
            },
            sleeve_paperback_dreamer_buff = {
                name = "追梦者牌套",
                text = {
                    "开局时拥有每种花色",
                    "各一张{C:attention}#1#"
                }
            },
            sleeve_paperback_proud = {
                name = "骄傲牌套",
                text = {
                    "开局时拥有全套",
                    "{C:hearts}红桃{}、{C:diamonds}方片{}、{C:spades}黑桃{}",
                    "{C:clubs}梅花{}、{C:paperback_crowns}皇冠{}和{C:paperback_stars}银星{}",
                }
            },
            sleeve_paperback_proud_buff = {
                name = "骄傲牌套",
                text = {
                    "所有初始{C:attention}A",
                    "均为{C:dark_edition}多彩{}"
                }
            },
            sleeve_paperback_silver_buff = {
                name = "银色牌套",
                text = {
                    "开局时拥有",
                    "{C:paperback_minor_arcana,T:v_paperback_soothsay}#1#{}优惠券"
                }
            },
            sleeve_paperback_passionate_buff = {
                name = "热忱牌套",
                text = {
                    "每隔一个{C:attention}Boss盲注{}",
                    "替换为{C:attention}决胜盲注{}",
                    "击败{C:attention}决胜盲注{}",
                    "获得一个{C:dark_edition,T:tag_negative}负片{}标签"
                }
            },
            sleeve_paperback_dreamer = {
                name = "追梦者牌套",
                text = {
                    "开局时拥有一个{C:paperback_temporary}临时",
                    "{C:paperback_minor_arcana,T:c_paperback_apostle_of_wands}#1#",
                    "{C:attention}#2#{}个小丑牌槽位"
                }
            },
            sleeve_paperback_silver = {
                name = "银色牌套",
                text = {
                    "开局时拥有",
                    "{C:paperback_minor_arcana,T:v_paperback_celtic_cross}#1#{}优惠券",
                    "和一张{C:paperback_minor_arcana,T:c_paperback_nine_of_cups}#2#"
                }
            },
            sleeve_paperback_antique_buff = {
                name = "古旧牌套",
                text = {
                    "{C:paperback_minor_arcana}秘仪包{}均{C:money}免费"
                }
            },
            sleeve_paperback_passionate = {
                name = "热忱牌套",
                text = {
                    "每次击败{C:attention}Boss盲注{}后",
                    "获得一个{C:attention,T:tag_paperback_high_risk}#1#",
                    "不赚取任何{C:money}利息"
                }
            }
        },
        Enhanced = {
            m_paperback_ceramic = {
                name = "陶器牌",
                text = {
                    "计分时随机获得{C:money}$#1#{}~{C:money}$#2#{}",
                    "如果{C:mult}倍率{}最终",
                    "{C:attention}高于{} {C:chips}筹码{}",
                    "则{C:red}摧毁{}此牌",
                    "（打出或留在手牌时生效）"
                }
            },
            m_paperback_stained = {
                name = "染色牌",
                text = {
                    "如果{C:attention}留在手牌中{}",
                    "且本回合已出牌，则计分的游戏牌",
                    "永久获得{C:mult}#1#{}倍率"
                }
            },
            m_paperback_domino = {
                name = "多米诺牌",
                text = {
                    "本回合每打出或弃掉",
                    "一个点数，获得{C:mult}+#1#{}倍率",
                    "{C:inactive}（当前为{C:mult}+#2#{C:inactive}倍率）"
                }
            }
        },
        Spectral = {
            c_paperback_apostle_of_cups = {
                name = "圣杯使徒",
                text = {
                    "将选中的{C:attention}游戏牌{}",
                    "变为{C:dark_edition}负片{}版本",
                    "{C:attention}#1#{}个小丑牌槽位"
                }
            },
            c_paperback_apostle_of_swords = {
                name = "宝剑使徒",
                text = {
                    "摧毁选中的{C:attention}小丑牌{}，",
                    "{C:attention}#1#{}底注"
                }
            },
            c_paperback_apostle_of_wands = {
                name = "权杖使徒",
                text = {
                    "从列表选择并生成一张",
                    "{C:legendary}传奇{}以下（不包含）稀有度的小丑牌",
                    "{C:inactive}（不会重复）"
                }
            }
        },
        Joker = {
            j_paperback_boundary_of_death = {
                name = "生死境界",
                text = {
                    "{C:attention}#1#{}有",
                    "{C:green}#2#/#3#{}的几率",
                    "额外给予{C:red}+#4#{}倍率"
                }
            },
            j_paperback_inner_peace = {
                name = "内心宁静",
                text = {
                    "本回合{C:attention}首次出牌{}之前",
                    "{C:attention}+3{}手牌上限"
                }
            },
        },
    },
    misc = {

    },
}
