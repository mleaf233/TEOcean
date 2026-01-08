return {
    translator = {
        "来自QQ群：755944835"
    },
    descriptions = {
        Back = {
            b_mmj_n64deck = {
                name = "N64牌组",
                text = {
                    "在游戏开始时",
                    "获得一张随机{C:attention}马里奥{}小丑牌"
                }
            }
        },
        Sleeve = {
            sleeve_mmj_n64sleeve = {
                name = "N64卡套",
                text = {
                    "开始时获得一张随机马里奥小丑牌和+5个小丑牌槽位"
                }
            }
        },
        Voucher = {
            v_mmj_planet_bounce = {
                name = "行星弹跳",
                text = {
                    "当你打开{C:Planet}天体{}包时",
                    "生成一张随机{C:attention}鲁米{}卡",
                    "{C:inactive}不需要空位{}"
                }
            },
            v_mmj_planet_hopp = {
                name = "行星跳跃",
                text = {
                    "允许在{C:Planet}天体{}包中",
                    "找到{C:attention}鲁米{}卡"
                }
            }
        },
        Code = {
            c_mmj_miyamoto = {
                name = "宫本茂",
                text = {
                    "摧毁选中的{C:cry_candy}传说{}小丑牌",
                    "并生成一张随机{C:attention}马里奥{}小丑牌"
                }
            }
        },
        Spectral = {
            c_mmj_beemushroom = {
                name = "蜜蜂蘑菇",
                text = {
                    "为1张选中的可用马里奥小丑牌赋予{C:attention}蜜蜂强化{}"
                }
            }
        },
        Joker = {
            j_mmj_beepeach = {
                name = "蜜蜂桃花公主",
                text = {
                    "进入{C:attention}盲注{}时，所有小丑牌",
                    "将{C:attention}盲注{}所需分数减少{C:attention}(#2# * 蜜蜂数量)%{}",
                    "{C:inactive}(乘法计算){}",
                    "{C:inactive}(当前#1#%){}",
                    "{C:inactive}此牌算作蜜蜂小丑"
                }
            },
            j_mmj_toad = {
                name = "奇诺比奥",
                text = {
                    "进入{C:attention}盲注{}时，将一半",
                    "{C:attention}可变{}小丑牌的效果减半",
                    "直到回合结束"
                }
            },
            j_mmj_luigi = {
                name = "路易吉",
                text = {
                    "所有小丑牌为基础{C:attention}列出{}的",
                    "{C:green}概率增加 X#1# {}"
                }
            },
            j_mmj_yoshi = {
                name = "耀西",
                text = {
                    "所有小丑牌触发时",
                    "获得{C:money}$#1#{}的{C:attention}出售价值{}"
                }
            },
            j_mmj_daisy = {
                name = "黛西",
                text = {
                    "每有一个小丑牌，",
                    "就{C:attention}重新触发{}每个{C:attention}4{}和{C:attention}3{}",
                    "{C:attention}#1#{}次"
                }
            },
            j_mmj_nluigi = {
                name = "路易吉",
                text = {
                    "所有小丑牌提供",
                    "{X:chips,C:white} X#1# {}筹码",
                    "{C:inactive}即将重构!!{} "
                }
            },
            j_mmj_beeluigi = {
                name = "蜜蜂路易吉",
                text = {
                    "所有小丑牌为基础{C:attention}列出{}的",
                    "{C:green}概率增加 X(#1#+(蜜蜂数量/#2#)) {}",
                    "{C:inactive}(当前 x#3# ){}",
                    "{C:inactive}此牌算作蜜蜂小丑"
                }
            },
            j_mmj_peach = {
                name = "桃花公主",
                text = {
                    "进入{C:attention}盲注{}时，所有小丑牌",
                    "将{C:attention}盲注{}所需分数减少{C:attention}5%{}",
                    "{C:inactive}(乘法计算){}"
                }
            },
            j_mmj_beerosalina = {
                name = "蜜蜂罗莎塔",
                text = {
                    "所有小丑牌有{C:green}#1#次中#2#次{}几率",
                    "在回合结束时将所有{C:attention}牌型提升(蜜蜂数量 * #3#){}级",
                    "向上取整",
                    "{C:inactive}(当前#4#次){}",
                    "{C:inactive}此牌算作蜜蜂小丑"
                }
            },
            j_mmj_beemario = {
                name = "蜜蜂马里奥",
                text = {
                    "重新触发所有小丑牌",
                    "每有一个蜜蜂小丑就触发一次",
                    "{C:inactive}(当前#1#次重新触发){}",
                    "{C:inactive}此牌算作蜜蜂小丑"
                }
            },
            j_mmj_king_boo = {
                name = "鬼王",
                text = {
                    "小丑牌触发时有{C:green}#1#次中#2#次{}几率",
                    "升级版本",
                    "{C:green}#1#次中#3#次{}几率重置为基础版",
                    "{C:inactive}(例如: 基础版 -> 箔闪 -> 全息 -> 多彩 等){}"
                }
            },
            j_mmj_donkeykong = {
                name = "大金刚",
                text = {
                    "所有小丑牌提供",
                    "{C:attention}#1#{}手牌上限"
                }
            },
            j_mmj_lakitu = {
                name = "拉基图",
                text = {
                    "回合结束时，每有一个小丑牌",
                    "此小丑牌就获得{C:dark_edition}+#1#{}个小丑牌槽位",
                    "{C:inactive}(当前{C:dark_edition}+#2#{C:inactive}个小丑牌槽位#3#)"
                }
            },
            j_mmj_mario = {
                name = "马里奥",
                text = {
                    "重新触发所有小丑牌",
                    "额外{C:attention}#1#{}次"
                }
            },
            j_mmj_rosalina = {
                name = "罗莎塔",
                text = {
                    "所有小丑牌有{C:green}#1#次中#2#次{}几率",
                    "在回合结束时提升所有{C:attention}牌型{}等级"
                }
            },
            j_mmj_shyguy = {
                name = "害羞鬼",
                text = {
                    "打出的数字牌永久获得{X:mult,C:white}X(n*#1#){}倍数，",
                    "其中{C:attention}n{}等于你拥有的小丑牌数量"
                }
            }
        },
        Other = {
            card_extra_xmult = {
                text = {
                    "{X:mult,C:white}x#1#{}额外倍数"
                }
            }
        },
        Luma = {
            c_mmj_red_luma = {
                name = "红色鲁米",
                text = {
                    "将所有牌型的倍数",
                    "乘以{X:red,C:white}X#1#{}"
                }
            },
            c_mmj_orange_luma = {
                name = "橙色鲁米",
                text = {
                    "将{C:attention}升天{}牌型",
                    "的能力乘以{X:gold,C:white}X#1#{}",
                    "{C:inactive}(当前{X:gold,C:white}X(#2#^升天){C:inactive})"
                }
            },
            c_mmj_black_luma = {
                name = "黑色鲁米",
                text = {
                    "将所有牌型提升{C:attention}#1#{}级",
                    "本局游戏中每使用一个消耗品",
                    "就增加{C:attention}#2#{}级",
                    "{C:inactive}当前#3#{}"
                }
            },
            c_mmj_blue_luma = {
                name = "蓝色鲁米",
                text = {
                    "将所有牌型的筹码",
                    "乘以{X:blue,C:white}X#1#{}"
                }
            },
            c_mmj_apricot_luma = {
                name = "杏色鲁米",
                text = {
                    "{C:attention}交换{}所有牌型的筹码和倍数",
                    "然后乘以{X:dark_edition,C:white}X#1#{}"
                }
            }
        }
    },
    misc = {
        dictionary = {
            mmj_asc_luma = "升阶强度",
            mmj_beepeach = "-#1#%盲注大小",
            k_mmj_mariojoker = "马里奥",
            mmj_config_features = "功能",
            mmj_config_nostalgic_luigi = "怀旧路易吉",
            mmj_daisy_give = "拿取此消耗品",
            mmj_config_more_mario_jokers = "更多马里奥小丑牌"
        },
        labels = {
            k_mmj_mariojoker = "超级兄弟"
        }
    }
}
