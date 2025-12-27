-- 译者:
-- [卿暨](https://space.bilibili.com/171440924)
-- mleaf233
return {
    translator = {
        "卿暨",
        "mleaf233",
    },
    descriptions = {
        Mod = {
            Sculio = {
                name = 'Sculio',
                text = {
                    '一个旨在为《小丑牌》添加',
                    '全新且风格契合内容的模组',
                    '（目前包含超过45张小丑牌）',
                    ' ',
                    '{C:attention}制作人员：{}',
                    '{C:money}crmykybord{}：像素画师',
                    '{C:money}BrandonE{}：开发者',
                    '{C:money}chily{}：小丑牌创意与平衡调整',
                    '{C:money}Marffe{}：创意与本地化文件',
                    ' ',
                    '{C:attention}特别鸣谢（小丑牌创意提供）：{}',
                    '{C:inactive}Spicy_burritos（愚人画像与概念）、The_Math_Hatter',
                    '{C:inactive}Different_Ad2722、reilywalker195、ekazoid213、aftyCreeper64',
                    '{C:inactive}Jazzlike_Spirit_9943、Lazy_Tutor9447、Valunar、DrBacon27',
                    '{C:inactive}mysterygift17、-Error-69、charsol1545、santh91、TheFunny64074',
                    '{C:inactive}Any_Thanks、zapirate_2020、isaaciscrying、manurosadilla',
                    '{C:inactive}Soup_can54、HumanDactyl、__Heavy_Water、Toasty、Glamdring',
                }
            }
        },
        Other = {
            Sculio_refrigerable_jokers = {
                name = '食物小丑',
                text = {
                    '{C:attention}冰淇淋{}、{C:attention}苏打水{}、{C:attention}拉面{}、',
                    '{C:attention}爆米花{}和{C:attention}黑龟豆{}'
                }
            },
            Sculio_ailments = {
                name = '负面影响',
                text = {
                    '{C:attention}永恒{}、{C:attention}租用{}',
                    '和{C:attention}易腐{}标签'
                }
            },
        },
        Joker = {
            -- 1. Schrödinger's Joker
            j_Sculio_schrodinger = {
                name = '薛定谔小丑',
                text = {
                    '{C:green}#1#/#2#{}几率',
                    '获得{X:mult,C:white}X#3#{}倍率'
                },
            },
            -- 2. Impossible Stairs
            j_Sculio_impossible_stairs = {
                name = '彭罗斯阶梯',
                text = {
                    '每次出牌这张小丑牌获得',
                    '{C:mult}+#3#{}~{C:mult}#2#{}之间的倍率',
                    '倍率到达{C:mult}+#4#{}时摧毁此牌',
                    '{C:inactive}（当前为{C:mult}+#1#{}{C:inactive}倍率）'
                },
            },
            -- 3. House Party
            j_Sculio_house_party = {
                name = '家庭聚会',
                text = {
                    '如果打出的牌',
                    '包含{C:attention}同花顺{}',
                    '这张小丑牌获得{X:mult,C:white}X#2#{}倍率',
                    '{C:inactive}（当前为{X:mult,C:white}X#1#{}{C:inactive}倍率）',
                },
            },
            -- 4. Verified User
            j_Sculio_verified = {
                name = '认证用户',
                text = {
                    '带有{C:blue}蓝色蜡封{}的牌',
                    '会被优先抽取',
                },
            },
            j_Sculio_stonks = {
                name = '华尔街小丑',
                text = {
                    '这张小丑牌的{C:mult}倍率{}数值',
                    '会在击败{C:attention}Boss盲注{}后{C:attention}翻倍{}',
                    '{C:inactive}（当前为{C:mult}+#1#{}{C:inactive}倍率）'
                },
            },
            -- 6. Gold ore
            j_Sculio_gold_ore = {
                name = '黄金矿脉',
                text = {
                    '打出并计分的{C:attention}石头牌{}',
                    '添加{C:attention}金色蜡封{}'
                },
            },
            -- 7. Pop Star
            j_Sculio_pop_star = {
                name = '巨星',
                text = {
                    '每张打出并计分的牌{}',
                    '有{C:green}#1#/#2#{}几率',
                    '获得{C:attention}全新{}',
                    '{C:attention}随机增强{}'
                },
            },
            -- 8. Addiction
            j_Sculio_addiction = {
                name = '沉迷',
                text = {
                    '打出最常用牌型时',
                    '每张打出并计分的牌永久增加{C:chips}筹码{}',
                    '其数值等于打过次数的{C:attention}#1#%{}',
                },
            },
            -- 9. Gumball Machine
            j_Sculio_gumball = {
                name = '赌博机',
                text = {
                    '{C:attention}打开补充包时{}{C:mult}+#2#{}倍率',
                    '{C:attention}跳过补充包时{}{C:mult}#3#{}倍率',
                    '当倍率到达{C:mult}+#4#{}时自毁',
                    '{C:inactive}（当前为{C:mult}+#1#{}{C:inactive}倍率）'
                },
            },
            -- 10. Anatomy
            j_Sculio_anatomy = {
                name = '解剖图',
                text = {
                    '打出的{C:attention}数字牌{}',
                    '计分时有{C:green}点数/10{}几率重新触发一次',
                }
            },
            -- 11. Handheld
            j_Sculio_handheld = {
                name = '掌机',
                text = {
                    '所有牌视为{C:attention}万能牌{}',
                },
            },
            -- 12. Crime Scene
            j_Sculio_crime_scene = {
                name = '犯罪现场',
                text = {
                    '如果回合{C:attention}第一次出牌{}',
                    '只有{C:attention}1{}张牌,',
                    '获得该牌{C:attention}基础筹码50%{}的倍率{}',
                    '{C:inactive}（当前为{C:mult}+#1#{}{C:inactive}倍率）'
                },
            },
            -- 13. Joker Cutout
            j_Sculio_cutout = {
                name = '剪影小丑',
                text = {
                    '每个{C:attention}其他{}被占用的{C:attention}小丑{}空位',
                    '给予{X:red,C:white}X#1#{}倍率',
                    '{C:inactive}（当前为{X:red,C:white} X#2# {C:inactive}倍率）',
                },
            },
            -- 14. Figurine
            j_Sculio_figurine = {
                name = '手办',
                text = {
                    '每有一张{C:attention}闪箔、镭射、多彩{}小丑牌被售出',
                    '这张小丑牌继承其数值的{C:attention}#4#%{}',
                    '{C:inactive}（当前为{C:chips}+#1#{}{C:inactive}筹码, {C:mult}+#2#{}{C:inactive}倍率, {X:mult,C:white}X#3#{}{C:inactive}倍率）'
                },
            },
            -- 15. Crooked Joker
            j_Sculio_crooked = {
                name = '骗子小丑',
                text = {
                    '手牌上限{C:attention}+#1#{}',
                    '回合结束时资金{C:money}-$#2#{}',
                    '当资金少于{C:money}$#3#{}时自毁',
                },
            },
            -- 16. Beyond Reach
            j_Sculio_beyond_reach = {
                name = '遥不可及',
                text = {
                    '可免于死亡但会{S:1.1,C:red,E:2}自毁{}',
                    '当获得的筹码至少为需求的{C:attention}#2#%{}时',
                    '永久获得手牌上限{C:blue}+#1#{}',
                    '若已击败盲注则无效果'
                },
            },
            -- 17. Mad Scientist
            j_Sculio_mad_scientist = {
                name = '疯狂科学家',
                text = {
                    '当选择{C:attention}盲注{}时',
                    '将右侧的小丑牌',
                    '转变为另一张',
                    '同{C:attention}稀有度{}的小丑牌'
                }
            },
            -- 18. Chicken Coupon
            j_Sculio_kfc = {
                name = 'JFC优惠券',
                text = {
                    '在盲注结束时窃取其他每张',
                    '{C:attention}小丑牌{}的{C:attention}售价{}的{C:money}$#2#{}',
                    '每窃取{C:money}$#4#{}获得{X:mult,C:white}X#3#{}倍率',
                    '{C:inactive}（当前为{X:mult,C:white}X#1#{C:inactive}倍率）'
                }
            },
            -- 19. Dunce
            j_Sculio_dunce = {
                name = '迟钝小丑',
                text = {
                    '复制{C:attention}最右边{}小丑牌的能力',
                    '触发时使{C:attention}右侧{}小丑牌的能力无效',
                }
            },
            -- 20. Frequent Flyer
            j_Sculio_frequent_flyer = {
                name = '经常出差',
                text = {
                    '每在商店消费{C:money}$#4#{}',
                    '则获得{C:money}$#1#{}',
                    '同时这张小丑牌获得{C:mult}+#3#{}倍率',
                    '{C:inactive}（当前为{C:mult}+#2#{}{C:inactive}倍率）'
                },
            },
            -- 21. Sticky Keys
            j_Sculio_sticky_keys = {
                name = '粘滞键',
                text = {
                    '每第{C:attention}#2#{}次出牌',
                    '{C:mult}倍率{}变为{C:attention}第一张计分牌{}的',
                    '{C:attention}基础筹码值{}',
                    '{C:inactive}剩余#3#次激活{}',
                    '{C:inactive}（当前为{C:mult}+#1#{}{C:inactive}倍率）',
                }
            },
            -- 22. Signage
            j_Sculio_signage = {
                name = '路标',
                text = {
                    '商店只刷新{C:attention}小丑牌{}',
                },
            },
            -- 23. Jokerium
            j_Sculio_jokerium = {
                name = '小丑元素',
                text = {
                    '每击败{C:attention}#2#{C:attention}次Boss盲注{}',
                    '生成{C:attention}#1#{}张{C:dark_edition}负片{}{C:spectral}黑洞{}',
                    '剩余{C:inactive}#3#次激活{}',
                },
            },
            -- 24. Effigy
            j_Sculio_effigy = {
                name = '肖像',
                text = {
                    '复制一张{C:attention}随机小丑牌{}的能力',
                },
            },
            -- 25. Bad Trip
            j_Sculio_bad_trip = {
                name = '吃菌子',
                text = {
                    '{C:attention}#1#{}回合后售出此牌',
                    '牌组中每张牌的{C:attention}点数和花色{}',
                    '{C:attention}全部随机{}',
                    '{C:inactive}（当前为{C:attention}#2#{C:inactive}/#1#）'
                },
            },
            -- 26. Receipt
            j_Sculio_receipt = {
                name = '小票',
                text = {
                    '售出此小丑牌',
                    '可以创建一个免费的{C:attention}优惠券标签{}',
                },
            },
            -- 27. Unstoppable Force
            j_Sculio_unstoppable = {
                name = '无阻之力',
                text = {
                    '此小丑牌被{C:attention}售出时{}',
                    '获得{X:mult,C:white}X#2#{}倍率',
                    '但会在{C:attention}下次商店刷新时出现{}',
                    '{C:attention}售价为{}{C:money}$#3#{}',
                    '{C:inactive}（当前为{X:mult,C:white}X#1#{C:inactive}倍率）',
                },
            },
            -- 28. Refrigerator
            j_Sculio_refrigerator = {
                name = '冰箱',
                text = {
                    '使所有{C:attention}右侧{}的食物小丑牌保持新鲜',
                    '不会{C:attention}变质{}或者{C:attention}无效{}'
                },
            },
            -- 29. Hammer and Chisel
            j_Sculio_hammer_and_chisel = {
                name = '锤和凿',
                text = {
                    '打出的{C:attention}石头牌{}计分时',
                    '永久增加{C:chips}+#3#{}筹码',
                    '有{C:green}#1#/#2#{}几率{C:attention}被摧毁',
                },
            },
            -- 30. Prescription
            j_Sculio_prescription = {
                name = '处方药',
                text = {
                    '在{C:attention}#1#{}回合后消除',
                    '所有小丑牌的{C:attention}负面影响{}并随机{C:attention}增幅{}',
                    '{C:inactive}（当前为{C:attention}#2#{C:inactive}/#1#）'
                },
            },
            -- 31. Intuition
            j_Sculio_intuition = {
                name = '直觉',
                text = {
                    '打出的{C:attention}黄金牌{}计分时给予{C:money}$#1#{}',
                    '打出的{C:attention}钢铁牌{}计分时给予{X:mult,C:white}X#2#{}倍率'
                },
            },
            -- 32. Sensory Overload
            j_Sculio_sensory_overload = {
                name = '感官超载',
                text = {
                    '每{C:attention}#2#{}{C:inactive}[#3#]{}次',
                    '其他小丑牌{C:attention}被触发时{}',
                    '获得{C:money}$#1#{}',
                },
            },
            -- 33. Cloning Vat
            j_Sculio_cloning_vat = {
                name = '克隆槽',
                text = {
                    '当{C:attention}游戏牌{}',
                    '被{C:attention}购买{}时',
                    '向牌组中额外添加一张',
                    '{C:attention}复制品{}'
                },
            },
            -- 34. Rorschach
            j_Sculio_rorschach = {
                name = '罗夏墨迹测验',
                text = {
                    '此小丑牌放置在{C:attention}最右侧时{},',
                    '本回合{C:attention}第一次弃掉的牌{},',
                    '会在{C:attention}下一轮盲注{}中被优先抽取'
                },
            },
            -- 35. Critical Failure
            j_Sculio_critical_failure = {
                name = '关键故障',
                text = {
                    '每次{C:attention}幸运{}牌概率未触发时',
                    '这张小丑牌获得{X:mult,C:white}X#2#{}倍率',
                    '{C:attention}幸运{}牌{C:green}概率判定成功时重置倍率',
                    '{C:inactive}(当前为{X:mult,C:white}X#1#{C:inactive}倍率）'
                },
            },
            -- 36. Pyromaniac
            j_Sculio_pyromaniac = {
                name = '纵火狂',
                text = {
                    '如果本回合{C:attention}第一次出牌{}',
                    '是{C:attention}最常用牌型{}',
                    '则{C:attention}升级该牌型#1#次{}',
                    '然后{C:attention}摧毁计分的牌{}'
                },
            },
            -- 37. Pharaoh
            j_Sculio_pharaoh = {
                name = '法老',
                text = {
                    '所有{C:attention}数字牌{}无效',
                    '所有{C:attention}人头牌{}计分时获得{X:mult,C:white}X#1#{}倍率',
                },
            },
            -- 38. Soup Can
            j_Sculio_soup = {
                name = '罐头汤',
                text = {
                    '每次出牌获得{X:mult,C:white}X#2#{}倍率',
                    '{C:attention}最多{}{X:mult,C:white}X#3#{}倍率',
                    '{C:inactive}（当前为{X:mult,C:white}X#1#{}{C:inactive}倍率）',
                },
            },
            -- 39. Treachery
            j_Sculio_pipe = {
                name = '背叛',
                text = {
                    '经过{C:attention}#1#{}回合后',
                    '售出此牌可为随机一张',
                    '{C:attention}小丑牌{}添加{C:dark_edition}负片{}效果',
                    '{C:inactive}（当前为{C:attention}#2#{C:inactive}/#1#）'
                },
            },
            -- 40. Nametag
            j_Sculio_nametag = {
                name = '名牌',
                text = {
                    '每当一张{C:attention}小丑牌{}被售出时',
                    '此小丑牌获得{X:mult,C:white}X#2#{}倍率',
                    '{C:inactive}（当前为{X:mult,C:white}X#1#{C:inactive}倍率）'
                },
            },
            -- 41. Binary Joker
            j_Sculio_binary = {
                name = '二进制小丑',
                text = {
                    '这张小丑牌有',
                    '{C:green}#1#/#2#{}几率',
                    '在每个盲注结束时获得',
                    '{C:chips}+#3#{}筹码和{C:mult}+#4#{}倍率',
                    '{C:inactive}（当前为{C:chips}+#5#{C:inactive}筹码和{C:mult}+#6#{C:inactive}倍率）'
                },
            },
            -- 42. 红中
            j_Sculio_mahjong = {
                name = '红中',
                text = {
                    '如果打出的牌包含{C:attention}偶数张牌{}',
                    '且{C:attention}恰好一半{}小于{C:attention}#3#{}',
                    '则这张小丑牌获得{C:chips}+#2#{}筹码',
                    '{C:inactive}（当前为{C:chips}+#1#{C:inactive}筹码）',
                },
            },
            -- 43. 自动战斗
            j_Sculio_earthbound = {
                name = '自动战斗',
                text = {
                    '自动选择{C:attention}最高{}',
                    '{C:attention}等级{}的可用牌型'
                },
            },
            -- 44. 充气吉祥物
            j_Sculio_wacky = {
                name = '充气吉祥物',
                text = {
                    '如果出牌获得至少需求筹码的{C:attention}#1#%{}',
                    '则生成一张{C:tarot}愚者{}的复制牌',
                    '{C:inactive}（必须有空位）{}'
                }
            },
            -- 100. 庞克
            j_Sculio_puck = {
                name = '庞克',
                text = {
                    '当一张带有{C:attention}版本{}的卡牌被计分时',
                    '这张小丑牌获得该{C:attention}版本加成{}的{C:attention}#4#%{}',
                    '{C:inactive}（当前为{C:chips}+#1#{C:inactive}筹码、{C:mult}+#2#{C:inactive}倍率和{X:mult,C:white}X#3#{C:inactive}倍率）'
                }
            },
        },
        Tag = {
            tag_Sculio_unstoppable = {
                name = '无阻之力标签',
                text = {
                    '商店中会出现',
                    '拥有{X:mult,C:white}X#1#{}倍率的',
                    '{C:attention}无阻之力{}小丑牌',
                },
            }
        },
    }
}
