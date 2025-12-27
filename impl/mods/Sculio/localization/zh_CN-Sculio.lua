return {
  descriptions = {
    Mod = {
      Sculio = {
        name = 'Sculio',
        text = {
          'A vanilla-esque mod that aims to add',
          'new and faithful content to Balatro',
          '(Currently contains 45+ Jokers)',
          ' ',
          '{C:attention}Credits:{}',
          '{C:money}crmykybord{}: Sprite Artist',
          '{C:money}BrandonE{}: Developer',
          '{C:money}chily{}: Joker Ideas + Balancing',
          '{C:money}Marffe{}: Ideas and Loc files for translation',
          ' ',
          '{C:attention}Special Thanks (Joker Ideas):{}',
          '{C:inactive}u/Spicy_burritos (Dunce Artwork + Concept), u/The_Math_Hatter,',
          '{C:inactive}u/Different_Ad2722, u/reilywalker195, u/Geekazoid213, u/CraftyCreeper64,',
          '{C:inactive}u/Jazzlike_Spirit_9943, u/Lazy_Tutor9447, Valunar, u/DrBacon27,',
          '{C:inactive}u/mysterygift17, u/-Error-69, u/charsol1545, u/santh91, u/TheFunny64074,',
          '{C:inactive}u/Any_Thanks, u/zapirate_2020, isaaciscrying, u/manurosadilla,',
          '{C:inactive}Soup_can54, HumanDactyl, __Heavy_Water, Toasty, Glamdring',
        }
      }
    },
    Other = {
      Sculio_refrigerable_jokers = {
        name = '食用小丑牌',
        text = {
          '{C:attention}冰淇淋{}, {C:attention}苏打水{}, {C:attention}拉面{},',
          '{C:attention}爆米花{}, {C:attention}黑龟豆{}'
        }
      },
      Sculio_ailments = {
        name = '负面影响',
        text = {
          '{C:attention}永恒{} 和 {C:attention}租用{},',
          'and {C:attention}易腐{} 标签'
        }
      },
    },
    Joker = {
      -- 1. Schrödinger's Joker
      j_Sculio_schrodinger = { 
        name = '薛定谔小丑',
        text = {
          '{C:green}#1#/#2#{} 几率',
          '获得 {X:mult,C:white}X#3#{} 倍率'
          },
        },
      -- 2. Impossible Stairs
      j_Sculio_impossible_stairs = { 
        name = '不可描述的台阶',
        text = {
          '每次出牌获得 {C:mult}+#3#{}',
          '到 {C:mult}#2#{} 之间的倍率',
          ' 当倍率为 {C:mult}+#4#{} 时即刻摧毁',
          '{C:inactive}(当前为 {C:mult}+#1#{}{C:inactive} 倍率)'
          },
        },
      -- 3. House Party
      j_Sculio_house_party = {
        name = '家庭聚会',
        text = {
          '该小丑牌获得 {X:mult,C:white}X#2#{} 倍率',
          '当打出的牌型',
          '包含{C:attention}同花顺{}时',
          '{C:inactive}(当前为 {X:mult,C:white}X#1#{}{C:inactive} 倍率)',
          },
      },
      -- 4. Verified User
      j_Sculio_verified = {
        name = '认证用户',
        text = {
          '{C:blue}蓝色蜡封{}的卡牌',
          '会被优先抓取'
        },
      },
      -- 5. Schrödinger's Joker
      j_Sculio_stonks = {
        name = '华尔街小丑',
        text = {
          '此小丑 {C:mult}+ 倍率{} ',
          '该数值击败BOSS盲注后{C:attention}翻倍{}',
          '{C:inactive}(当前为 {C:mult}+#1#{}{C:inactive} 倍率)'
        },
      },
      -- 6. Gold ore
      j_Sculio_gold_ore = {
        name = '黄金矿脉',
        text = {
          '打出并计分的{C:attention}石头牌{}',
          '获得{C:attention}金色蜡封{}'
        },
      },
      -- 7. Pop Star
      j_Sculio_pop_star = {
        name = '巨星',
        text = {
          '{C:green}#1# / #2#{} 几率',
          '每张打出并计分的卡牌{}',
          '获得{C:attention}全新{}',
          '{C:attention}随机增强{}'
        },
      },
      -- 8. Addiction
      j_Sculio_addiction = {
        name = '沉迷',
        text = {
          '当你打出最常用牌型时,',
          '每张打出并计分的卡牌永久增加{C:chips}筹码{}',
          '其数值等于打过次数的{C:attention}#1#%{}',
        },
      },      
      -- 9. Gumball Machine
      j_Sculio_gumball = {
        name = '赌博机',
        text = {
          '{C:attention}打开补充包时 {}{C:mult}+#2#{} 倍率',
          '{C:attention}跳过补充包时 {}{C:mult}#3#{} 倍率',
          '当倍率到达 {C:mult}+#4#{} 时即刻摧毁',
          '{C:inactive}(当前为 {C:mult}+#1#{}{C:inactive} 倍率)'
        },
      },
      -- 10. Anatomy
      j_Sculio_anatomy = {
        name = '解剖',
        text = {
          '打出并计分的{C:attention}数字牌{}',
          '有{C:green}点数/10{}几率重新激活一次',
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
          '如果本回合{C:attention}第一次出牌{}',
          '只有{C:attention}1{}张牌,',
          '获得该牌 {C:attention}基础筹码50%{} 的倍率{}',
          '{C:inactive}(当前为 {C:mult}+#1#{}{C:inactive} 倍率)'
        },
      }, 
      -- 13. Joker Cutout
      j_Sculio_cutout = {
        name = '剪影小丑',
        text = {
          '每个{C:attention}其他{}被占用的{C:attention}小丑{}空位',
          '提供 {X:red,C:white} X#1# {} 倍率',
          '{C:inactive}(当前为 {X:red,C:white} X#2# {C:inactive} 倍率)',
        },
      }, 
      -- 14. Figurine
      j_Sculio_figurine = {
        name = '手办',
        text = {
          '每一个{C:attention}闪箔、镭射、多彩{}小丑被出售',
          '这小丑牌继承其数值的 {C:attention}#4#%{}',
          '{C:inactive}(当前为 {C:chips}+#1#{}{C:inactive} 筹码, {C:mult}+#2#{}{C:inactive} 倍率, {X:mult,C:white}X#3#{}{C:inactive} 倍率)'
        },
      }, 
      -- 15. Crooked Joker
      j_Sculio_crooked = {
        name = '骗子小丑',
        text = {
          '{C:attention}+#1#{}手牌,',
          '每回合减少{C:money}$#2#{}.',
          '当金钱到达{C:money}$#3#{}时即刻摧毁',
        },
      }, 
      -- 16. Beyond Reach
      j_Sculio_beyond_reach = {
        name = '临近终点',
        text = {
          '防止死亡,{S:1.1,C:red,E:2}自毁{}',
          '永久增加 {C:blue}+#1#{} 出牌机会',
          '当得到的筹码达到要求的{C:attention}#2#%{}时生效',
          '盲注被打败时无效'
        },
      },
      -- 17. Mad Scientist
      j_Sculio_mad_scientist = {
        name = '疯狂科学家',
        text = {
          '当{C:attention}盲注{}被选择时,',
          '将右边小丑转化为另外的,',
          '具有同样{C:attention}稀有度{}的小丑',
        }
      },
      -- 18. Chicken Coupon
      j_Sculio_kfc = {
        name = 'JFC优惠券',
        text = {
        '每轮盲注结束时',
        '所有其他小丑的{C:attention}售价{}减少{C:money}$#2#{}',
        '每减少 {C:money}$#4#{} 获得 {X:mult,C:white}X#3#{} 倍率',
        '{C:inactive}(当前为 {X:mult,C:white}X#1#{}{C:inactive} 倍率)'
        }
      },
      -- 19. Dunce
      j_Sculio_dunce = {
        name = '迟钝小丑',
        text = {
        '复制{C:attention}最右边{}小丑的能力,',
        '同时使{C:attention}右侧{}小丑能力无效',
        }
      },
      -- 20. Frequent Flyer
      j_Sculio_frequent_flyer = {
        name = '经常出差',
        text = {
          '每在商店消费{C:money}$#4#{},',
          '则获得{C:money}$#1#{},',
          '同时增加{C:mult}+#3#倍率{}',
          '{C:inactive}(当前为 {C:mult}+#2#{}{C:inactive} 倍率)'
        },
      },
      -- 21. Sticky Keys
      j_Sculio_sticky_keys = {
        name = '粘滞键',
        text = {
          '每第{C:attention}#2#{}次出牌时,',
          '{C:mult}倍率{}变为{C:attention}第一张计分牌{}的',
          '{C:attention}基础筹码数值{}',
          '{C:inactive}剩余#3#次激活{}',
          '{C:inactive}(当前为 {C:mult}+#1#{}{C:inactive} 倍率)',
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
          '每击败{C:attention}#2# {C:attention}次Boss盲注{}',
          '增加{C:attention}#1#{}张{C:dark_edition}负片{}{C:spectral}黑洞{}',
          '剩余{C:inactive}#3#次激活{}',
        },
      }, 
      -- 24. Effigy
      j_Sculio_effigy = {
        name = '肖像',
        text = {
          '复制{C:attention}随机小丑牌{}的能力',
        },
      }, 
      -- 25. Bad Trip
      j_Sculio_bad_trip = {
        name = '吃菌子',
        text = {
          '{C:attention}#1#{} 回合后, 卖出此牌,',
          '牌组中每张牌的{C:attention}点数和花色{},',
          '{C:attention}全部随机{}',
          '{C:inactive}(当前为 {C:attention}#2#{C:inactive} / #1#)'
        },
      }, 
      -- 26. Receipt
      j_Sculio_receipt = {
          name = '小票',
          text = {
          '卖掉此小丑牌',
          '生成一张{C:attention}优惠卷标签{}',
        },
      }, 
      -- 27. Unstoppable Force
      j_Sculio_unstoppable = {
        name = '无阻之力',
        text = {
          '此小丑牌被{C:attention}卖出时{}',
          '获得 {X:mult,C:white} X#2# {} 倍率',
          '但会在{C:attention}下次商店刷新时出现{}',
          '{C:attention}卖出售价为{}{C:money}$#3#{}',
          '{C:inactive}(目前为 {X:mult,C:white} X#1# {C:inactive} 倍率)',
        },
      }, 
      -- 28. Refrigerator
      j_Sculio_refrigerator = {
        name = '冰箱',
        text = {
          '使所有{C:attention}右侧{}食用小丑牌保持新鲜',
          '不会{C:attention}变质{}或者{C:attention}无效{}'
        },
      }, 
      -- 29. Hammer and Chisel
      j_Sculio_hammer_and_chisel = {
        name = '锤和凿',
        text = {
          '打出并计分{C:attention}石头牌{}时',
          '永久增加 {C:chips}+#3#{} 筹码',
          '但 {C:green}#1# / #2#{} 几率{C:attention}被摧毁',
        },
      }, 
      -- 30. Prescription
      j_Sculio_prescription = { 
        name = '处方药',
        text = {
          '在 {C:attention}#1#{} 回合后,',
          '消除所有小丑牌的{C:attention}负面影响{}并随机{C:attention}增幅{}',
          '{C:inactive}(当前为 {C:attention}#2#{C:inactive} / #1#)'
        },
      },
      -- 31. Intuition
      j_Sculio_intuition = {
        name = '直觉',
        text = {
          '打出并计分的{C:attention}黄金牌{}给予{C:money}$#1#{}.',
          '打出并计分的{C:attention}钢铁牌{}给予 {X:mult,C:white}X#2#{} 倍率'
        },
      }, 
      -- 32. Sensory Overload
      j_Sculio_sensory_overload = {
        name = '感官超载',
        text = {
          '赚取 {C:money}$#1#{}',
          '每{C:attention}#2#{} {C:inactive}[#3#]{} 次',
          '其他小丑{C:attention}被触发时{}'
        },
      }, 
      -- 33. Cloning Vat
      j_Sculio_cloning_vat = {
        name = '克隆容器',
        text = {
          '{C:attention}游戏牌{}被{C:attention}购买时{}',
          '{C:attention}复制一张{}进入牌组'
        },
      }, 
      -- 34. Rorschach
      j_Sculio_rorschach = {
        name = '罗夏墨迹测验',
        text = {
          '此小丑牌放置在{C:attention}最右侧时{},',
          '本回合{C:attention}第一次弃掉的牌{},',
          '会在{C:attention}下一轮盲注{}中被优先抓取'
        },
      }, 
      -- 35. Critical Failure
      j_Sculio_critical_failure = {
        name = '关键故障',
        text = {
          '每次{C:attention}幸运{}牌未激活时',
          '此小丑牌获得 {X:mult,C:white} X#2# {} 倍率',
          '{C:attention}幸运{}牌{C:green}成功时重置倍率',
          '{C:inactive}(目前为 {X:mult,C:white} X#1# {C:inactive} 倍率)'
        },
      }, 
      -- 36. Pyromaniac
      j_Sculio_pyromaniac = {
        name = '纵火狂',
        text = {
          '当本回合{C:attention}第一次出牌{}',
          '如果是{C:attention}最常用牌型{}',
          '则{C:attention}升级该牌型 #1# 次{}',
          '并且{C:attention}摧毁计分的游戏牌{}'
        },
      }, 
      -- 37. Pharaoh
      j_Sculio_pharaoh = {
        name = '法老',
        text = {
          '所有{C:attention}数字牌{} 无效',
          '所有{C:attention}人头牌{}计分时获得 {X:mult,C:white}X#1#{} 倍率',
        },
      }, 
      -- 38. Soup Can
      j_Sculio_soup = {
        name = '罐头汤',
        text = {
          '每次出牌获得 {X:mult,C:white}X#2#{} 倍率',
          '{C:attention}最大值{}为 {X:mult,C:white}X#3#{} 倍率',
          '{C:inactive}(目前为 {X:mult,C:white}X#1#{}{C:inactive} 倍率)',
        },
      }, 
      -- 39. Treachery
      j_Sculio_pipe = {
        name = '背叛',
        text = {
          '{C:attention}#1#{} 回合后, 售出此小丑牌',
          '增加{C:dark_edition}负片{}',
          '至其他随机{C:attention}小丑牌',
          '{C:inactive}(目前为 {C:attention}#2#{C:inactive} / #1#)'
        },
      }, 
      -- 40. Nametag
      j_Sculio_nametag = {
        name = '名牌',
        text = {
          '其他{C:attention}小丑牌{}出售时',
          '此小丑牌获得 {X:mult,C:white} X#2# {} 倍率',
          '{C:inactive}(目前为 {X:mult,C:white} X#1# {C:inactive} 倍率)'
        },
      }, 
      -- 41. Binary Joker
      j_Sculio_binary = {
        name = '二进制小丑',
        text = {
          '每次盲注过关时，此小丑牌',
          '{C:green}#1# / #2#{} 几率获得',
          '{C:chips}+#3#{} 筹码, {C:mult}+#4#{} 倍率',
          '{C:inactive}(目前为 {C:chips}+#5#{}{C:inactive} 筹码和 {C:mult}+#6#{} 倍率)'
        },
      }, 
      -- 42. Red Dragon
      j_Sculio_mahjong = {
        name = '麻将牌',
        text = {
          '当打出的手牌数量为{C:attention}偶数{}时',
          '且{C:attention}正好一半{}小于{C:attention}#3#{}时',
          '此小丑牌获得 {C:chips}+#2#{} 筹码',
          '{C:inactive}(目前为 {C:chips}+#1#{}{C:inactive} 筹码)',
        },
      }, 
      -- 43. Auto Battle
      j_Sculio_earthbound = {
        name = '自动战斗',
        text = {
          '自动选择{C:attention}最高分{}的手牌'
        },
      }, 
      -- 44. 
      j_Sculio_wacky = {
        name = '充气吉祥物',
        text = {
          '当得分为所需筹码的 {C:attention}#1#%{} 时',
          '生成一张{C:tarot}愚者{}',
          '{C:inactive}(必须有空间){}'
        }
      }, 
      -- 100. Puck
      j_Sculio_puck = {
        name = '庞克',
        text = {
          '当{C:attention}闪箔、镭射、多彩{}卡片被计分时,',
          '此小丑牌获得 {C:attention}#4#%{} 数值{}',
          '{C:inactive}(目前为 {C:chips}+#1#{}{C:inactive} 筹码, {C:mult}+#2#{}{C:inactive} 倍率, {X:mult,C:white}X#3#{}{C:inactive} 倍率)'
        }
      },
    },
    Tag = {
      tag_Sculio_unstoppable = {
        name = '无阻之力标签',
        text = {
          '商店中如下小丑牌',
          '{C:attention}无阻之力{}',
          'with {X:mult,C:white} X#1# {} 倍率'
        },
      }
    },
  }
}
