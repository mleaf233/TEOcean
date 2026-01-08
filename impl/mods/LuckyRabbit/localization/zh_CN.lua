-- @Treasure 来自QQ
return {
    translator = {
        "Treasure",
        "mleaf233"
    },
    descriptions = {
        Joker = {
            j_fmod_generator = {
                name = "发电机",
                text = {
                    "重新触发所有的{C:attention}打出的牌{}",
                    "回合开始时{C:red}摧毁{}",
                    "最左则的{C:attention}消耗牌{}",
                    "无可摧毁的消耗牌则{C:red}自毁{}"
                },
            },
            j_fmod_fennex = {
                name = "芬尼克",
                text = {
                    "每{C:attention}#1#{}次重掷",
                    "商店添加1张",
                    "{C:attention}优惠券{}",
                    "{C:inactive,s:0.8}（剩余#2#次触发）"
                }
            },
            j_fmod_terminal_velocity = {
                name = "末速度",
                text = {
                    "计分的{C:attention}万能牌{}永久",
                    "获得{X:mult,C:white}X#1#{}倍率"
                }
            },
            j_fmod_low_hanging_fruit = {
                name = "低垂茄子",
                text = {
                    "每张打出的{C:attention}6{}或{C:attention}9{}",
                    "计分时给予{C:mult}+#2#{}倍率和",
                    "{C:chips}+#1#{}筹码"
                }
            },
            j_fmod_nerdcubed = {
                name = "立方极客",
                text = {
                    "每张打出的{C:attention}3{}",
                    "重新触发{C:attention}3{}次"
                }
            },
            j_fmod_penny_joker = {
                name = "便士小丑",
                text = {
                    "每张计分牌给予",
                    "{C:chips}+#2#{}筹码",
                    "{C:inactive}(当前{C:chips}+#1#{}筹码)"
                }
            },
            j_fmod_countdown = {
                name = "倒计时",
                text = {
                    "下次计分{C:attention}#1#{}时给予{C:mult}+#2#{}倍率，",
                    "随后需求点数降低{C:attention}1{}",
                    "当计分到{C:attention}#3#{}时，",
                    "给予{X:mult,C:white}X#4#{}倍率"
                }
            },
            j_fmod_countdown = {
                name = "倒计时",
                text = {
                    "下一次计分的{C:attention}#1#{}给予{C:mult}+#2#{}倍率",
                    "然后所需点数减少{C:attention}1{}",
                    "当点数减少到{C:attention}#3#{}并计分时",
                    "{X:mult,C:white}X#4#{}倍率"
                }
            },
            j_fmod_despicable_bear = {
                name = "卑鄙小熊",
                text = {
                    "如果打出的{C:attention}两对{}牌型",
                    "正好打出{C:attention}4{}张牌",
                    "则视为{C:attention}四条{}"
                }
            },
            j_fmod_negativejoker = {
                name = "负片小丑",
                text = {
                    "{C:chips}+#1#{}筹码",
                    "{C:attention}#2#{}回合后为自身",
                    "添加{C:attention}负片{}版本"
                }
            },
            j_fmod_passport = {
                name = "护照",
                text = {
                    "每打出过一种{C:attention}不重复的牌型{}",
                    "获得{C:mult}+#1#{}倍率",
                    "击败{C:attention}Boss盲注{}后重置",
                    "{C:inactive}(当前为{C:mult}+#2#{}倍率)"
                }
            },
            j_fmod_steve = {
                name = "史蒂夫",
                text = {
                    "选择盲注时生成一张",
                    "随机{C:dark_edition}负片{C:attention}食物小丑{}"
                }
            },
            j_fmod_blue_angel_mushroom = {
                name = "蓝天使菇",
                text = {
                    "当你即将{C:attention}死亡{}时",
                    "{C:blue}+1{}出牌次数以继续该回合",
                    "剩余{C:attention}#2#{}次",
                }
            },
            j_fmod_impractical_joker = {
                name = "柴浩",
                text = {
                    "打出并计分的牌中",
                    "第一张{C:attention}点数最低{}的牌",
                    "给予{X:mult,C:white}X#1#{}倍率"
                }
            },
            j_fmod_ferromancy = {
                name = "铁炼术",
                text = {
                    "留在手牌中的{C:attention}黄金牌{}",
                    "给予{X:mult,C:white}X#1#{}倍率",
                    "{C:attention}钢铁牌{}在回合结束时",
                    "给予{C:money}$#2#{}",
                    "{C:inactive}（覆盖默认效果）"
                }
            },
            j_fmod_jazzercise = {
                name = "爵士健美操",
                text = {
                    "每摧毁{C:attention}#2#{}张牌{C:inactive}[#3#]{}",
                    "手牌上限{C:attention}+#1#{}",
                    "{C:inactive}（当前手牌上限{C:attention}+#4#{C:inactive}）"
                }
            },
            j_fmod_pomni = {
                name = "帕姆尼",
                text = {
                    "跳过{C:attention}#2#{}次盲注后",
                    "底注减少{C:attention}#1#{}",
                    "{C:green}25%{}几率改为减少{C:attention}#3#{}次底注",
                    "{C:inactive}（当前{C:attention}#4#{C:inactive}/#2#）"
                }
            },
            j_fmod_loonette = {
                name = "露奈特",
                text = {
                    "计分的{C:attention}数字牌{}",
                    "给予{X:mult,C:white}X#1#{}倍率",
                    "每连续计分一张{C:attention}数字牌{}",
                    "额外增加{X:mult,C:white}X#2#{}倍率",
                    "{C:inactive}（出牌后重置）"
                }
            },
            j_fmod_wordle = {
                name = "字谜游戏",
                text = {
                    "打出的牌中每有一张计分的",
                    "{C:attention}3{}、{C:attention}7{}、{C:attention}8{}或{C:attention}Q{}",
                    "获得{C:chips}+#1#{}筹码",
                    "{C:inactive}（当前为{C:chips}+#2#{C:inactive}筹码）"
                }
            },
            j_fmod_hyperfixation = {
                name = "高度专注",
                text = {
                    "每张打出的{V:1}#2#{C:attention}#1#{}",
                    "重新触发{C:attention}#3#{}次",
                    "每计分{C:attention}#5#次{C:inactive}[#6#]{}",
                    "该回合的{C:attention}所需点数（{C:attention}#4#{}）",
                    "并获得{C:attention}1{}次额外触发次数",
                    "{C:inactive}（所需点数每回合改变）"
                }
            },
            j_fmod_fragile_sticker = {
                name = "易碎贴纸",
                text = {
                    "{C:attention}玻璃牌{}不再",
                    "因使用而破碎"
                }
            },
            j_fmod_ghost_trick = {
                name = "幽灵戏法",
                text = {
                    "打出的牌有{C:green}#1#/#2#{}几率",
                    "在{C:attention}重新触发{}时",
                    "生成一张{C:dark_edition}负片{C:spectral}幻灵牌{}"
                }
            },
            j_fmod_rabbit = {
                name = "兔子",
                text = {
                    "每回合前{C:attention}#1#{}次",
                    "打出{C:attention}五条{}时",
                    "复制最左侧打出的牌",
                    "并将其{C:attention}弃掉{}",
                    "{C:inactive}（当前剩余{C:attention}#2#{C:inactive}次）"
                }
            },
            j_fmod_crazy_neils_crazy_deals = {
                name = "疯狂尼尔的疯狂交易",
                text = {
                    "每家商店内",
                    "随机一件商品享受{C:attention}#1#%{}折扣"
                }
            },
            j_fmod_pop_idol_cat = {
                name = "爱豆基米",
                text = {
                    "每{C:green}成功{}触发一次",
                    "{C:attention}幸运牌{}后",
                    "其{C:green}概率{}提高{C:green}#1#{}",
                    "{C:attention}出牌后重置{}"
                }
            },
            j_fmod_pub_burger = {
                name = "酒吧汉堡",
                text = {
                    "弃牌次数{C:attention}+#1#{}",
                    "首次出牌后每多出一次牌",
                    "其数值{C:red}-#2#{}"
                }
            },
            j_fmod_orbit = {
                name = "天体轨道",
                text = {
                    "回合结束时如果持有",
                    "非{C:dark_edition}负片{C:planet}星球牌{}",
                    "生成一张随机{C:dark_edition}负片{C:planet}星球牌{}",
                    "其售出价值{C:attention}减半{}"
                }
            },
            j_fmod_calculator = {
                name = "计算器",
                text = {
                    "给予等于{C:attention}首张{}与{C:attention}末张{}",
                    "{C:attention}计分牌{}点数差值的{X:mult,C:white}X倍率{}",
                    "随后该小丑{C:red}禁用{}对应回合数",
                    "{C:inactive}（差值≤1时无效）",
                    "{C:inactive}（#1#{C:attention}#2#{C:inactive}#3#）"
                }
            },
            j_fmod_tax_return = {
                name = "退税单",
                text = {
                    "打出的牌中每有一张",
                    "{C:attention}未计分{}的牌",
                    "获得{C:money}$#1#{}"
                }
            },
            j_fmod_civic_secretary = {
                name = "公民秘书",
                text = {
                    "当另一张小丑牌",
                    "给予{C:chips}+筹码{}或{C:mult}+倍率{}时",
                    "本张小丑牌{C:attention}同步{}该效果"
                }
            },
            j_fmod_trans_joker = {
                name = "变幻小丑",
                text = {
                    "当一张游戏牌改变",
                    "{C:attention,V:1}点数{}或{C:attention,V:2}花色{}时",
                    "永久获得{C:mult}+#1#{}倍率"
                }
            },
            j_fmod_litterbug = {
                name = "垃圾虫",
                text = {
                    "出牌时这张小丑牌",
                    "随机{C:attention}弃掉{}一张牌",
                    "并以其{C:attention}点数{}获得{X:mult,C:white}X#2#{}倍率",
                    "{C:inactive}（当前为{X:mult,C:white}X#1#{C:inactive}倍率）"
                }
            },
            j_fmod_sad_clown = {
                name = "悲伤小丑",
                text = {
                    "每弃掉{C:attention}#1#张牌{C:inactive}[#2#]{}",
                    "生成一张随机{V:1}滑稽{}牌",
                    "{C:inactive}（必须有空位）"
                }
            },
            j_fmod_claw_machine = {
                name = "抓娃娃机",
                text = {
                    "手牌中的每张{C:attention}7{}给予",
                    "{X:mult,C:white}X#1#{}倍率，且有",
                    "{C:green}#2#/#3#{}几率额外给予",
                    "{X:mult,C:white}X#4#{}倍率"
                }
            },
            j_fmod_fennex_the_clown = {
                name = "传奇芬尼克",
                text = {
                    "每持有一张{C:attention}优惠券{}",
                    "这张小丑牌给予{X:mult,C:white}X#1#{}倍率",
                    "{C:inactive}(当前为{X:mult,C:white}X#2#{}倍率)"
                }
            },
            j_fmod_dating_sim = {
                name = "恋爱模拟",
                text = {
                    "打出的{C:hearts}红桃{}牌",
                    "计分时永久获得{C:chips}+#1#{}筹码"
                }
            },
            j_fmod_rhythm_game = {
                name = "节奏游戏",
                text = {
                    "重新触发",
                    "所有计分的{C:diamonds}方块{}牌"
                }
            },
            j_fmod_dungeon_crawler = {
                name = "地牢探索",
                text = {
                    "如果打出的牌包含计分的{C:spades}黑桃{}",
                    "就随机为一张牌添加",
                    "{C:attention}增强{}、{C:attention}蜡封{}或{C:attention}标记{}",
                    "{C:inactive}(不覆盖现有效果)"
                }
            },
            j_fmod_fighting_game = {
                name = "双人格斗",
                text = {
                    "打出的{C:clubs}梅花{}牌有",
                    "{C:green}#1#/#2#{}概率给予",
                    "{C:attention}+#3#{}手牌上限，",
                    "持续至回合结束"
                }
            },
            j_fmod_free_shipping = {
                name = "免费配送",
                text = {
                    "{C:attention}奖券牌{}生成的",
                    "消耗牌变为{C:dark_edition}负片{}版本"
                }
            },
            j_fmod_comic_book_ad = {
                name = "漫画广告",
                text = {
                    "{C:attention}奖券牌{}总是",
                    "生成{V:1}滑稽牌{}"
                }
            },
            j_fmod_lottery = {
                name = "抽奖",
                text = {
                    "{C:green}#1#/#2#{}几率获得价值",
                    "{C:money}$#3#-{}${C:money}#4#{}的出售收益",
                    "回合结束时结算"
                }
            },
            j_fmod_detective = {
                name = "密探",
                text = {
                    "每张本{C:attention}底注{}中已打出过的牌",
                    "给予{C:money}$#1#{}"
                }
            },
            j_fmod_strange_dreams = {
                name = "奇异梦境",
                text = {
                    "每次出牌后随机将1张",
                    "{C:attention}未计分牌{}变为最右",
                    "{C:attention}计分牌{}"
                }
            },
            j_fmod_ransome = {
                name = "兰塞姆",
                text = {
                    "当一张牌被{C:attention}摧毁{}时，",
                    "生成带有{C:red}红色蜡封{}的",
                    "{C:dark_edition}多彩{}复制品"
                }
            },
            j_fmod_feline_fleecer = {
                name = "诈骗犯哈吉米",
                text = {
                    "击败1个{C:attention}盲注{}后，",
                    "商店添加1个免费",
                    "{C:attention}混音包{}"
                }
            },
            j_fmod_tem_shop = {
                name = "提米的商店",
                text = {
                    "所有卡牌的{C:attention}售出价值{}",
                    "初始为其{C:attention}基础{}价格的",
                    "{C:attention}75%{}"
                }
            },
            j_fmod_debut_album = {
                name = "首张专辑",
                text = {
                    "{X:mult,C:white}X#1#{}倍率",
                    "每次出牌{X:mult,C:white}-X#2#{}倍率",
                    "{C:inactive}({X:mult,C:white}X1{}时自毁)"
                }
            },
            j_fmod_zany_to_the_max = {
                name = "极致滑稽",
                text = {
                    "若出牌为{C:attention}三条{}，此小丑牌获得",
                    "{C:chips}+#1#{}筹码、{C:mult}+#2#{}倍率或{X:mult,C:white}+X#3#{}倍率",
                    "{C:inactive}(当前为{C:chips}+#4#{}、{C:mult}+#5#{}和{X:mult,C:white}X#6#{})"
                }
            },
            j_fmod_ghostly_joker = {
                name = "灵体小丑",
                text = {
                    "每第{C:attention}4{}次计分{C:attention}4{}（当前#1#次）",
                    "生成1张{C:attention}死神{}塔罗牌",
                    "{C:inactive}(需有空位)"
                }
            },
            j_fmod_friend_inside_me = {
                name = "心中挚友",
                text = {
                    "若回合{C:attention}第一次弃牌{}只有一张牌",
                    "则将其{C:attention}摧毁{}并创建",
                    "{C:attention}#1#{}张临时副本",
                    "{C:inactive}(回合结束时摧毁副本)"
                }
            },
            j_fmod_prismatic_joker = {
                name = "棱镜小丑",
                text = {
                    "若出牌包含{C:attention}四条{}，",
                    "所有{C:attention}计分牌{}变为",
                    "{C:attention}模仿牌{}"
                }
            },
            j_fmod_newtons_cradle = {
                name = "牛顿摆",
                text = {
                    "最右计分牌重新触发{C:attention}#2#{}次，",
                    "当打出全为{V:1}#1#{}花色的非{C:attention}高牌{}牌型时，",
                    "重新触发次数增加{C:attention}#3#{}次",
                    "{C:inactive,s:0.8}(重新触发次数重置，花色每回合结束变化)"
                }
            },
            j_fmod_working_joker = {
                name = "打工小丑",
                text = {
                    "每张打出的",
                    "{C:attention}5{}、{C:attention}6{}、{C:attention}7{}、{C:attention}8{}、{C:attention}9{}",
                    "计分时给予{C:mult}+#1#{}倍率"
                }
            },
            j_fmod_hypeman = {
                name = "气氛组小丑",
                text = {
                    "完整牌组每张{C:attention}倍率牌{}",
                    "给予{C:mult}+#1#{}倍率",
                    "{C:inactive}(当前为{C:mult}+#2#{}倍率)"
                }
            },
            j_fmod_and_thats_not_all = {
                name = "还没完呢！",
                text = {
                    "每张{C:attention}奖励牌{}计分给予",
                    "{C:mult}+#1#{}倍率",
                    "每张{C:attention}奖励牌{}弃掉失去",
                    "{C:mult}#1#{}倍率",
                    "{C:inactive}(当前为{C:mult}+#2#{}倍率)"
                }
            },
            j_fmod_double_down = {
                name = "双倍下注",
                text = {
                    "{C:attention}蜡封{}效果",
                    "会触发{C:attention}2{}次"
                    -- TODO 讨论：用“重新触发”可能更直观，需确认蓝图兼容性
                }
            },
            j_fmod_skee_ball = {
                name = "滑雪球",
                text = {
                    "若出牌恰好有{C:attention}5张以上方块{}或",
                    "{C:attention}5张以上梅花{}",
                    "所有打出的牌变为{C:attention}奖券牌{}"
                },
            },
            j_fmod_bouncer = {
                name = "保镖小丑",
                text = {
                    "{C:blue}普通{}稀有度的{C:attention}小丑牌{}",
                    "不再自然出现在商店"
                }
            },
            j_fmod_unorthodox_doctor = {
                name = "非主流医生",
                text = {
                    "如果打出的牌为{C:attention}葫芦{}，",
                    "这张小丑牌{C:attention}复制{}1张已拥有的",
                    "兼容小丑牌的能力"
                }
            },
            j_fmod_edibles = {
                name = "食用道具",
                text = {
                    "若打出的牌包含{C:attention}四条{}",
                    "所有{C:attention}计分牌{}点数",
                    "{C:attention}+1{}",
                    "{C:inactive}(剩余{C:attention}#1#{}次使用)"
                }
            },
            j_fmod_assassin = {
                name = "刺客小丑",
                text = {
                    "回合的{C:attention}最后一次{}出牌时",
                    "{C:attention}摧毁{}留在手中最左边的牌"
                }
            },
            j_fmod_pet_rock = {
                name = "宠物石头",
                text = {
                    "打出的{C:attention}石头牌{}",
                    "获得随机{C:attention}蜡封{}"
                }
            },
            j_fmod_falling_up = {
                name = "向上坠落",
                text = {
                    "出牌有{C:green}#1#/#2#{}几率不计分",
                    "给予的倍率增加{X:mult,C:white}X#3#{}",
                    "{C:inactive}(当前为{X:mult,C:white}X#4#{}倍率)",
                    "{C:inactive}(不会无效化最后一次出牌)"
                }
            },
            j_fmod_elimination_game = {
                name = "淘汰游戏",
                text = {
                    "每当售出一张{C:attention}小丑牌{}",
                    "这张小丑牌获得{C:mult}+#1#{}倍率",
                    "{C:inactive}（当前为{C:mult}+#2#{C:inactive}倍率）"
                }
            },
            --[[j_fmod_geiru = { -- 暂添加，效果目前无法实现
                name = "鬼龙院皋月",
                text = {
                    "小丑生成卡牌时获得{X:mult,C:white}X#1#{}倍率，",
                    "蜡封生成卡牌时获得{X:mult,C:white}X#2#{}倍率，",
                    "消耗牌生成卡牌时获得{X:mult,C:white}X#3#{}倍率",
                    "{C:inactive}(当前{X:mult,C:white}X#4#{}倍率)"
                }
            }]]
            j_fmod_girl_next_door = {
                name = "邻家女孩",
                text = {
                    "游戏牌花色变为{C:diamonds}方块{}时，",
                    "获得{X:mult,C:white}X#2#{}倍率",
                    "若{C:attention}K{}或{C:attention}Q{}计分时",
                    "扣除{X:mult,C:white}X#3#{}倍率",
                    "{C:inactive}(当前为{X:mult,C:white}X#1#{}倍率)"
                }
            },
            j_fmod_gumball_machine = {
                name = "口香糖机",
                text = {
                    "{V:1}滑稽包{}总会",
                    "包含一张{C:attention}杂耍师{}牌"
                }
            },
            j_fmod_premium_currency = {
                name = "高级货币",
                text = {
                    "{C:attention}重掷{}时也会",
                    "重掷未购买的{C:attention}补充包{}"
                }
            },
            j_fmod_master_of_disguise = {
                name = "伪装大师",
                text = {
                    "如果打出的牌是{C:attention}高牌{}",
                    "生成一张{C:attention}转化{}成",
                    "对应{C:attention}花色{}的{C:tarot}塔罗牌{}",
                    "{C:inactive}（必须有空位）"
                }
            },
            j_fmod_ufo_sighting = {
                name = "目击UFO",
                text = {
                    "如果使用{C:money}$#1#{}或更少资金",
                    "进行回合的{C:attention}第一次出牌{}",
                    "则提升对应的牌型等级"
                }
            },
            j_fmod_actually_useful_gun_mode = {
                name = "实用枪模式",
                text = {
                    "{C:dark_edition}版本{}效果",
                    "对{C:attention}留在手牌中的{}牌触发"
                }
            },
            j_fmod_prodigy_child = {
                name = "神童",
                text = {
                    "{C:mult}+#1#{}倍率",
                    "{C:attention}计分{}的牌有{C:green}#2#/#3#{}几率",
                    "随机改变其点数、花色、{C:attention}增强效果{}",
                    "或{C:attention}蜡封{}（如果存在）"
                }
            },
            j_fmod_sleazy_joker = {
                name = "猥琐小丑",
                text = {
                    "{C:attention}完整牌组{}中每有一张{C:attention}标记牌{}",
                    "获得{C:mult}+#1#{}倍率",
                    "{C:inactive}（当前为{C:mult}+#2#{C:inactive}倍率）"
                }
            },
            j_fmod_speedrun = {
                name = "速通",
                text = {
                    "如果在{C:attention}30{}秒内结束一个回合",
                    "给予{C:money}$#2#{}和{C:attention}+#1#{}临时{C:attention}手牌上限{}",
                    "如果回合用时超过{C:attention}60{}秒",
                    "{C:attention}-#3#{}临时手牌上限{C:red}重新开始{}本回合"
                }
            },
            j_fmod_metal_face_villain = {
                name = "金属脸恶棍",
                text = {
                    "打出的{C:attention}钢铁牌{}给予的倍率",
                    "等于其{C:attention}点数{}",
                    "{C:attention}X#1#{}"
                }
            },
            j_fmod_life_star = {
                name = "生命星",
                text = {
                    "当一张{C:attention}小丑牌{}或{C:attention}游戏牌{}",
                    "被{C:attention}摧毁{}时，生成一张带有",
                    "随机{C:dark_edition}版本{}的复制牌，并将基础{C:attention}盲注{}得分要求",
                    "倍率{X:purple,C:white}+X#1#{} {C:inactive}（当前为{X:purple,C:white}X#2#{C:inactive}）",
                    "{C:inactive}（必须有空位）"
                }
            },
            j_fmod_nightmare_eyes = {
                name = "噩梦之眼",
                text = {
                    "如果在回合的{C:attention}最后一次出牌{}",
                    "没有剩余{C:attention}弃牌次数{}",
                    "牌组中每剩一张牌给予{X:mult,C:white}X#1#{}倍率",
                    "{C:inactive}（当前为{X:mult,C:white}X#2#{C:inactive}倍率）"
                }
            },
            j_fmod_drummer_joker = {
                name = "鼓手小丑",
                text = {
                    "每当一张{C:attention}模仿牌{}被计分时",
                    "获得{X:mult,C:white}X#1#{}倍率",
                    "{C:inactive}（当前为{X:mult,C:white}X#2#{C:inactive}倍率）"
                }
            },
            j_fmod_commission = {
                name = "佣金",
                text = {
                    "选择{C:attention}盲注{}时，摧毁左侧小丑牌",
                    "并获得其{C:attention}售出价值{}",
                    "资金达到{C:money}$#1#{}时自毁",
                    "并{C:attention}复制{}右侧小丑牌"
                }
            },
            j_fmod_true_gluttony = {
                name = "真正的暴食",
                text = {
                    "任何影响{C:attention}花色{}的{C:attention}效果{}",
                    "现在仅影响{C:clubs}梅花{}"
                }
            },
            j_fmod_balancing_act = {
                name = "平衡表演",
                text = {
                    "如果本回合没有使用过",
                    "{C:attention}弃牌次数{}",
                    "{C:chips}+#1#{}筹码"
                }
            },
            j_fmod_gas_pump = {
                name = "加油泵",
                text = {
                    "每出牌一次获得{C:mult}+#1#{}倍率",
                    "出牌得分{C:attention}超过盲注要求分数{}（即分数指示器起火）时{C:attention}重置{}",
                    "{C:inactive}（当前为{C:mult}+#2#{C:inactive}倍率）"
                }
            },
            j_fmod_wedding_ring = {
                name = "结婚戒指",
                text = {
                    "如果持有{C:attention}#2#{}个回合",
                    "给予{X:mult,C:white}X#1#{}倍率"
                }
            },
            j_fmod_555_hotline = {
                name = "555热线",
                text = {
                    "计分{C:attention}5张{C:inactive}[#2#]{}",
                    "{C:attention}5{}后给予{C:money}$#1#{}"
                }
            },
            j_fmod_defenestration = {
                name = "抛出窗外",
                text = {
                    "如果当前盲注是",
                    "{C:attention}Boss盲注{}",
                    "获得{C:mult}+#1#{}倍率"
                }
            },
            j_fmod_backpack_hero = {
                name = "背包英雄",
                text = {
                    "每种不重复的{C:attention}花色/点数组合{}计分时",
                    "此小丑牌获得{X:mult,C:white}X#1#{}倍率",
                    "{C:inactive}（当前为{X:mult,C:white}X#2#{C:inactive}倍率）"
                }
            },
            j_fmod_barbershop_joker = {
                name = "理发店小丑",
                text = {
                    "平衡{C:purple}#1#%{}的{C:chips}筹码{}和{C:mult}倍率{}",
                    "每次{C:attention}相邻小丑牌{}触发时",
                    "数值增加{C:purple}#2#%{} {C:inactive}（出牌后重置）"
                }
            },
        },
        Tag = {
            tag_fmod_appraisal = {
                name = "鉴定标签",
                text = {
                    "你{C:attention}完整牌组{}中",
                    "每有一张{C:attention}强化牌{}",
                    "给予{C:money}$#1#{}",
                    "{C:inactive}（将给予{C:money}$#2#{C:inactive}）"
                }
            },
            tag_fmod_lunchbreak = {
                name = "午休标签",
                text = {
                    "生成一张随机",
                    "{C:dark_edition}负片{C:attention}食物小丑牌{}"
                }
            },
            tag_fmod_boost = {
                name = "助力标签",
                text = {
                    "为下一家商店添加",
                    "两个{C:attention}免费{}",
                    "{C:attention}补充包{}"
                }
            },
            tag_fmod_goofy = {
                name = "滑稽标签",
                text = {
                    "给予一个免费的",
                    "{V:1}超级滑稽包{}"
                }
            },
            tag_fmod_vinyl = {
                name = "黑胶标签",
                text = {
                    "给予一个免费的",
                    "{C:attention}超级混音包{}"
                }
            },
        },
        Blind = {
            bl_fmod_hoard = {
                name = "囤积",
                text = {
                    "所有数字牌",
                    "以背面朝上方式抽取"
                }
            },
            bl_fmod_tool = {
                name = "工具",
                text = {
                    "所有消耗牌",
                    "都被削弱"
                }
            },
            bl_fmod_baby = {
                name = "婴儿",
                text = {
                    "所有增强卡牌",
                    "以背面朝上方式抽取"
                }
            },
            bl_fmod_priest = {
                name = "牧师",
                text = {
                    "不能打出",
                    "超过4张牌"
                }
            },
            bl_fmod_dice = {
                name = "骰子",
                text = {
                    "所有概率",
                    "归零"
                }
            },
            bl_fmod_final_sword = {
                name = "象牙白剑",
                text = {
                    "无法打出",
                    "{C:attention}#1#{}"
                }
            },
            bl_fmod_light = {
                name = "光明",
                text = {
                    "打出的增强卡牌",
                    "失去其增强效果"
                }
            },
            bl_fmod_elder = {
                name = "长老",
                text = {
                    "所有未增强牌",
                    "以背面朝上方式抽取"
                }
            },
            bl_fmod_flux = {
                name = "涨落",
                text = {
                    "每次出牌时",
                    "随机两种花色被削弱"
                }
            },
            bl_fmod_final_shield = {
                name = "藏红花盾",
                text = {
                    "所有{C:attention}#1#{}",
                    "都被削弱"
                }
            },
            bl_fmod_final_horn = {
                name = "薰衣草号角",
                text = {
                    "所有牌",
                    "以背面朝上方式抽取"
                }
            },
            bl_fmod_thorn = {
                name = "荆棘",
                text = {
                    "带有蜡封的牌",
                    "都被削弱"
                }
            },
            bl_fmod_rhythm = {
                name = "节奏",
                text = {
                    "每触发一张小丑牌",
                    "损失$1"
                }
            }
        },
        Back = {
            b_fmod_recursive = {
                name = "递归牌组",
                text = {
                    "{C:attention}小丑牌{}、{C:tarot}塔罗牌{}、{C:planet}星球牌{}",
                    "和{C:spectral}幻灵牌{}",
                    "可以同时出现复数张"
                }
            },
            b_fmod_fennex = {
                name = "芬尼克牌组",
                text = {
                    "开局时拥有",
                    "{C:attention,T:j_fmod_fennex}芬尼克{}小丑牌",
                    "{C:legendary}Lucky-Rabbit模组{C:attention}小丑{}",
                    "出现概率{X:green,C:white}3X{}"
                }
            },
            b_fmod_clown = {
                name = "开局时拥有",
                text = {
                    "开局携带",
                    "{V:1,T:v_fmod_circus}#1#{}优惠券"
                }
            },
            b_fmod_reaper = {
                name = "死神牌组",
                text = {
                    "所有Boss盲注变为{C:attention}最终Boss盲注{}且",
                    "盲注得分要求{X:mult,C:white}X2{}",
                    "出牌次数{C:blue}+1{}",
                    "弃牌次数{C:red}+1{}",
                    "手牌上限{C:attention}+1{}",
                    "小丑牌槽位{C:attention}+1{}"
                }
            },
            b_fmod_harmony = {
                name = "和谐牌组",
                text = {
                    "牌组所有卡牌",
                    "拥有相同{C:attention}点数{}和{C:attention}花色{}",
                    "{C:red}-2{}次弃牌"
                }
            },
            b_fmod_tricky = {
                name = "诡计牌组",
                text = {
                    "牌组中随机13张牌",
                    "被{C:attention}标记{}",
                    "初始资金减少{C:money}$2{}"
                }
            },
            b_fmod_remix = {
                name = "混音牌组",
                text = {
                    "开局时拥有{C:planet,T:v_fmod_grab_bag}福袋{}",
                    "和{C:attention,T:v_fmod_gachapon}扭蛋{}优惠券"
                }
            },
        },
        Silly = {
            c_fmod_pie = {
                name = "馅饼",
                text = {
                    "选择{C:attention}#1#{}张牌",
                    "将最左侧牌的{C:attention}点数{}",
                    "复制到最右侧牌",
                }
            },
            c_fmod_clown_car = {
                name = "花车",
                text = {
                    "生成1张随机{C:dark_edition}负片{}",
                    "{C:attention}小丑牌{}，每持有1张负片小丑牌",
                    "扣除{C:money}$#1#{}",
                    "{C:inactive}(该小丑无{C:attention}出售价值{})"
                }
            },
            c_fmod_bang_gun = {
                name = "砰砰枪",
                text = {
                    "选择{C:attention}#1#{}张牌，将最左侧牌的",
                    "{C:attention}花色{}复制到",
                    "最右侧牌"
                }
            },
            c_fmod_squirt_flower = {
                name = "滋水花",
                text = {
                    "选择{C:attention}#1#{}张牌，将最左侧牌的",
                    "{C:attention}蜡封{}复制到",
                    "最右侧牌"
                }
            },
            c_fmod_whoopie_cushion = {
                name = "放屁垫",
                text = {
                    "选择{C:attention}#1#{}张牌，将最左侧牌的",
                    "{C:attention}增强效果{}复制到",
                    "最右侧牌"
                }
            },
            c_fmod_joy_buzzer = {
                name = "欢乐蜂鸣器",
                text = {
                    "选择{C:attention}#1#{}张牌，将最左侧牌的",
                    "{C:dark_edition}版本{}复制到",
                    "最右侧牌"
                }
            },
            c_fmod_midway_games = {
                name = "游园游戏",
                text = {
                    "获得1个{C:attention}标准标签{}、",
                    "{C:tarot}吊饰标签{}、{C:planet}流星标签{}",
                    "或{C:inactive}小丑标签{}"
                }
            },
            c_fmod_juggler = {
                name = "杂技表演",
                text = {
                    "获得{C:money}$#1#{}",
                    "本赛局每使用一次杂耍师",
                    "此金额增加{C:money}+$#2#{}"
                }
            },
            c_fmod_balloons = {
                name = "气球",
                text = {
                    "{C:attention}翻倍{}手牌中",
                    "所有牌的{C:chips}筹码值{}",
                    "{C:inactive}（不包括{C:dark_edition}版本{C:inactive}）"
                }
            },
            c_fmod_split_pants = {
                name = "开裆裤",
                text = {
                    "降低最多{C:attention}#1#{}张",
                    "选定牌的点数各{C:attention}1{}点"
                }
            },
            c_fmod_balloon_animal = {
                name = "气球动物",
                text = {
                    "手牌中每有一种",
                    "不同的{C:attention}点数{}",
                    "获得{C:money}$#1#{}",
                    "{C:inactive}（当前为{C:money}$#2#{C:inactive}）"
                }
            },
            c_fmod_soully = {
                name = "魂石",
                text = {
                    "生成1张来自{C:attention}Lucky-Rabbit{}模组的",
                    "{C:legendary,E:1}传奇{}小丑牌",
                    "{C:inactive}（必须有空位）"
                }
            },
            c_fmod_tightrope = {
                name = "走钢丝",
                text = {
                    "{C:green}50%{}概率生成",
                    "{C:attention}#2#{}张选定牌的{C:attention}#2#{}张复制",
                    "{C:green}25%{}概率生成",
                    "{C:attention}#3#{}张复制",
                    "{C:green}25%{}概率{C:red}摧毁{}",
                    "选定牌",
                    "{C:inactive}（几率不可改变）"
                }
            },
            c_fmod_fire_breath = {
                name = "吐火球",
                text = {
                    "摧毁选定的{C:attention}小丑牌{}",
                    "然后将其{C:dark_edition}版本{}",
                    "复制到其右侧的{C:attention}小丑牌{}上"
                }
            },
            c_fmod_rodeo = {
                name = "牛仔竞技",
                text = {
                    "选择{C:attention}#1#{}张牌",
                    "随机一张获得{C:dark_edition}闪箔{}、{C:dark_edition}镭射{}或{C:dark_edition}多彩{}",
                    "其余的牌被{C:red}摧毁{}"
                }
            },
            c_fmod_endless_scarf = {
                name = "无尽围巾",
                text = {
                    "直到回合结束前",
                    "手牌上限{C:attention}+#1#{}"
                }
            },
            c_fmod_knife_throw = {
                name = "扔飞刀",
                text = {
                    "选择最多{C:attention}#1#{}张牌",
                    "每张选定牌随机获得",
                    "一个{C:attention}蜡封{}",
                    "或被摧毁"
                }
            },
            c_fmod_trapeze = {
                name = "高空秋千",
                text = {
                    "使用高空秋千{C:attention}#2#{}次后",
                    "其下一次出现",
                    "替换为一张{C:attention}魂灵牌{}",
                    "{C:inactive}(当前{C:attention}#1#/#2#)"
                }
            },
            c_fmod_greasepaint = {
                name = "油彩",
                text = {
                    "选择最多{C:attention}#1#{}张牌",
                    "将其{C:attention}标记{}为{C:attention}墨迹{}"
                }
            },
            c_fmod_unicycle = {
                name = "独轮车",
                text = {
                    "选择{C:attention}#1#{}张牌",
                    "将其{C:attention}标记{}为{C:attention}折痕{}"
                }
            },
            c_fmod_cannon = {
                name = "加农炮",
                text = {
                    "选择最多{C:attention}#1#{}张牌",
                    "将其{C:attention}标记{}为{C:attention}针孔{}"
                }
            },
            c_fmod_barker = {
                name = "售票员",
                text = {
                    "将{C:attention}#1#{}张",
                    "选定牌增强为",
                    "{C:attention}抽奖券{}"
                }
            },
            c_fmod_suspenders = {
                name = "吊带裤",
                text = {
                    "选择{C:attention}#1#{}张牌，将{C:attention}左侧{}牌",
                    "的{C:attention}别针{}复制到",
                    "{C:attention}右侧{}牌上"
                }
            },
            c_fmod_hall_of_mirrors = {
                name = "镜室",
                text = {
                    "将{C:attention}#1#{}张",
                    "选定牌增强为",
                    "{C:attention}模仿牌{}"
                }
            },
            c_fmod_crisis = {
                name = "危机",
                text = {
                    "将{C:attention}底注{}设为{C:attention}1{}"
                }
            },
            c_fmod_crisis_col = {
                name = "危机",
                text = {
                    "...?"
                }
            },
            c_fmod_showgirl = {
                name = "歌舞女郎",
                text = {
                    "选择最多{C:attention}#1#{}张牌",
                    "将其{C:attention}标记{}为{C:attention}镀金{}"
                }
            },
            c_fmod_laughter = {
                name = "欢笑",
                text = {
                    "生成本赛局中",
                    "上一次使用的{V:1}滑稽牌{}",
                    "{s:0.8}不包括{s:0.8,V:1}欢笑{s:0.8}"
                }
            },
        },
        Voucher = {
            v_fmod_circus = {
                name = "马戏团",
                text = {
                    "{V:1}滑稽牌{}可能",
                    "出现在任意",
                    "{C:tarot}秘术包{}中"
                }
            },
            v_fmod_showtime = {
                name = "演出时间",
                text = {
                    "{V:1}滑稽牌{}可在",
                    "{C:attention}商店{}中",
                    "购买"
                }
            },
            v_fmod_reroll_superfluity = {
                name = "过度重掷",
                text = {
                    "重掷费用仅",
                    "{C:attention}每隔一次{}",
                    "才会上涨"
                }
            },
            v_fmod_buffet = {
                name = "自助餐",
                text = {
                    "永久增加",
                    "额外{C:blue}+#1#{}次",
                    "每回合出牌次数"
                }
            },
            v_fmod_dumpster_ritual = {
                name = "垃圾桶仪式",
                text = {
                    "永久增加",
                    "额外{C:red}+#1#{}次",
                    "每回合弃牌次数"
                }
            },
            v_fmod_anti_higgs_boson = {
                name = "反希格斯玻色子",
                text = {
                    "{C:dark_edition}+1{}小丑牌槽位",
                    "将{C:inactive}空白{}和",
                    "{C:dark_edition}反物质{}优惠券{C:attention}",
                    "返还到{C:attention}优惠券{}池"
                }
            },
            v_fmod_big_bang = {
                name = "大爆炸",
                text = {
                    "{C:attention}-#1#{}底注",
                    "{C:attention}-#2#{}手牌上限"
                }
            },
            v_fmod_color_swatches = {
                name = "色板",
                text = {
                    "{C:attention}+#1#{}手牌上限"
                }
            },
            v_fmod_fire_sale = {
                name = "清仓甩卖",
                text = {
                    "{C:attention}+#1#{}卡牌槽位",
                    "出现在商店中的",
                    "{C:attention}补充包{}槽位{C:attention}+#2#{}",
                }
            },
            v_fmod_coupon = {
                name = "优惠券",
                text = {
                    "{C:attention}+#1#{}消耗牌槽位"
                }
            },
            v_fmod_extreme_couponing = {
                name = "极致优惠",
                text = {
                    "{C:attention}+#1#{}额外消耗牌槽位"
                }
            },
            v_fmod_shopaholic = {
                name = "购物狂",
                text = {
                    "每家商店添加一个",
                    "{C:attention}免费{}",
                    "{C:attention}补充包{}"
                }
            },
            v_fmod_grab_bag = {
                name = "福袋",
                text = {
                    "击败{C:attention}Boss盲注{}后",
                    "打开一个免费{C:attention}混音包{}"
                }
            },
            v_fmod_gachapon = {
                name = "扭蛋",
                text = {
                    "{C:attention}混音包{}",
                    "出现在{C:attention}商店{}中"
                }
            },
            v_fmod_mystery_box = {
                name = "神秘盒",
                text = {
                    "商店中提供",
                    "{C:attention}+1个补充包{}槽位"
                }
            }
        },
        Enhanced = {
            m_fmod_raffle_card = {
                name = "抽奖券",
                text = {
                    "计分时有{C:green}#1#/#2#{}几率",
                    "生成一张随机{C:attention}消耗牌{}",
                    "{C:inactive}（必须有空位）"
                }
            },
            m_fmod_copycat_card = {
                name = "模仿牌",
                text = {
                    "所有{C:attention}模仿牌{}",
                    "在计分后变为",
                    "相同的随机{C:attention}点数{}"
                }
            }
        },
        Other = {
            p_fmod_silly_small = {
                name = "滑稽包",
                text = {
                    "从最多{C:attention}#2#张{V:1}滑稽牌{}中",
                    "选择{C:attention}#1#{}张",
                    "即选即用"
                }
            },
            p_fmod_silly_small_2 = {
                name = "滑稽包",
                text = {
                    "从最多{C:attention}#2#张{V:1}滑稽牌{}中",
                    "选择{C:attention}#1#{}张",
                    "即选即用"
                }
            },
            p_fmod_silly_small_3 = {
                name = "滑稽包",
                text = {
                    "从最多{C:attention}#2#张{V:1}滑稽牌{}中",
                    "选择{C:attention}#1#{}张",
                    "即选即用"
                }
            },
            p_fmod_silly_small_4 = {
                name = "滑稽包",
                text = {
                    "从最多{C:attention}#2#张{V:1}滑稽牌{}中",
                    "选择{C:attention}#1#{}张",
                    "即选即用"
                }
            },
            p_fmod_silly_jumbo = {
                name = "巨型滑稽包",
                text = {
                    "从最多{C:attention}#2#张{V:1}滑稽牌{}中",
                    "选择{C:attention}#1#{}张",
                    "即选即用"
                }
            },
            p_fmod_silly_jumbo_2 = {
                name = "巨型滑稽包",
                text = {
                    "从最多{C:attention}#2#张{V:1}滑稽牌{}中",
                    "选择{C:attention}#1#{}张",
                    "即选即用"
                }
            },
            p_fmod_silly_mega = {
                name = "超级滑稽包",
                text = {
                    "从最多{C:attention}#2#张{V:1}滑稽牌{}中",
                    "选择{C:attention}#1#{}张",
                    "即选即用"
                }
            },
            p_fmod_silly_mega_2 = {
                name = "超级滑稽包",
                text = {
                    "从最多{C:attention}#2#张{V:1}滑稽牌{}中",
                    "选择{C:attention}#1#{}张",
                    "即选即用"
                }
            },
            p_fmod_remix_small_1 = {
                name = "混音包",
                text = {
                    "从最多{C:attention}#2#张",
                    "{C:attention}小丑牌{}、{C:attention}游戏牌{}、",
                    "或{C:attention}消耗牌{}中",
                    "选择{C:attention}#1#{}张以添加或使用"
                }
            },
            p_fmod_remix_small_2 = {
                name = "混音包",
                text = {
                    "从最多{C:attention}#2#张",
                    "{C:attention}小丑牌{}、{C:attention}游戏牌{}、",
                    "或{C:attention}消耗牌{}中",
                    "选择{C:attention}#1#{}张以添加或使用"
                }
            },
            p_fmod_remix_jumbo = {
                name = "巨型混音包",
                text = {
                    "从最多{C:attention}#2#张",
                    "{C:attention}小丑牌{}、{C:attention}游戏牌{}、",
                    "或{C:attention}消耗牌{}中",
                    "选择{C:attention}#1#{}张以添加或使用"
                }
            },
            p_fmod_remix_mega = {
                name = "超级混音包",
                text = {
                    "从最多{C:attention}#2#张",
                    "{C:attention}小丑牌{}、{C:attention}游戏牌{}、",
                    "或{C:attention}消耗牌{}中",
                    "选择{C:attention}#1#{}张以添加或使用"
                }
            },
            fmod_ink_mark = {
                name = "墨迹标记",
                text = {
                    "无法被",
                    "{C:attention}削弱{}",
                    "或{C:attention}翻转{}"
                }
            },
            fmod_crease_mark = {
                name = "折痕标记",
                text = {
                    "总是洗入牌组",
                    "的{C:attention}顶部{}"
                }
            },
            fmod_pinhole_mark = {
                name = "针孔标记",
                text = {
                    "打出后{C:attention}返回{}",
                    "到牌组中"
                }
            },
            fmod_gilded_mark = {
                name = "镀金标记",
                text = {
                    "此卡牌的{C:green,E:1}几率{}判定",
                    "{C:attention}翻倍{}"
                }
            }
        },
        Sleeve = {
            sleeve_fmod_clown = {
                name = "小丑牌套",
                text = {
                    "开局时拥有",
                    "{V:1,T:v_fmod_circus}#1#{}优惠券"
                }
            },
            sleeve_fmod_clown_alt = {
                name = "小丑牌套",
                text = {
                    "开局时拥有",
                    "{V:1,T:v_fmod_circus}#1#{}和{V:1,T:v_fmod_showtime}#2#",
                    "优惠券"
                }
            },
            sleeve_fmod_fennex = {
                name = "芬尼克牌套",
                text = {
                    "开局时拥有",
                    "{C:attention,T:j_fmod_fennex}芬尼克{}小丑牌",
                    "{C:legendary}Lucky-Rabbit模组{C:attention}小丑牌{}",
                    "出现频率{X:green,C:white}#1#X{}"
                }
            },
            sleeve_fmod_fennex_alt = {
                name = "芬尼克牌套",
                text = {
                    "开局时拥有",
                    "{C:dark_edition}负片{C:attention,T:j_fmod_fennex}芬尼克{}小丑牌",
                    "{C:legendary}Lucky-Rabbit模组{C:attention}小丑牌{}",
                    "出现频率{X:green,C:white}#1#X{}"
                }
            }
        },
    },
    misc = {
        dictionary = {
            k_fmod_fuel = "充能！",
            k_fmod_drained = "耗尽！",
            k_fmod_neil_deal = "已打折！",
            k_fmod_sillypack = "滑稽包",
            k_fmod_remixpack = "混音包",
            r_fmod_mostplayed = "（最常打出点数）",
            k_fmod_config_restart = "需要重启生效",
            k_fmod_config_jokers = "启用小丑牌",
            k_fmod_config_silly = "启用滑稽牌",
            k_fmod_config_vouchers = "启用优惠券",
            k_fmod_config_blinds = "启用盲注",
            k_fmod_config_tags = "启用标签",
            k_fmod_config_decks = "启用牌组",
            k_fmod_config_markings = "启用标记",
            k_fmod_config_enhancements = "启用增强牌",
            k_fmod_config_remix = "启用混音包",
            k_fmod_planet_orbit = "+1星球牌",
            k_fmod_debut_destruct = "完成！",
            k_fmod_copycat = "复制！",
            k_fmod_copied = "已复制！",
            k_fmod_destroyed = "已摧毁！",
        },
        v_dictionary = {
            a_fmod_discards = "+#1#次弃牌",
            a_fmod_silly_card = "+#1#滑稽牌",
            a_fmod_money = "+$#1#",
            a_fmod_booster = "+#1#补充包",
            a_fmod_skee = "+#1#张票！",
            a_fmod_uses = "-#1#次使用",
            a_fmod_hsize_loss = "-#1#手牌上限",
            a_fmod_balance = "#1#%"
        },
        labels = {
            fmod_ink_mark = "墨渍",
            fmod_crease_mark = "折痕",
            fmod_pinhole_mark = "针孔",
            fmod_gilded_mark = "镀金",
        },
    }
}
