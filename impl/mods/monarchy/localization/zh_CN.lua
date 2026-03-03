local loc_table = {
    translator = {
        "mleaf233",
    },
    misc = {
        dictionary = {
            monarchy_returned = '返回了！',
            monarchy_enhanced = '增强了！',
            monarchy_chips = '筹码',
            monarchy_mult = '倍率',
            monarchy_switched = '切换了！',
            monarchy_air_freshener_flavour_54 = '花香',
            monarchy_air_freshener_flavour_64 = '金宝',
            monarchy_air_freshener_flavour_74 = '史蒂文',
            monarchy_air_freshener_flavour_84 = '托德',
            monarchy_air_freshener_flavour_94 = '蓝莓',
            monarchy_air_freshener_flavour_55 = '爆米花',
            monarchy_air_freshener_flavour_65 = '香蕉',
            monarchy_air_freshener_flavour_75 = '冰淇淋',
            monarchy_air_freshener_flavour_85 = '拉面',
            monarchy_air_freshener_flavour_95 = '鳗鱼',
            monarchy_air_freshener_flavour_56 = '80年代',
            monarchy_air_freshener_flavour_66 = '咖啡',
            monarchy_air_freshener_flavour_76 = '焦糊',
            monarchy_air_freshener_flavour_86 = '汗味',
            monarchy_air_freshener_flavour_96 = '鸡蛋',
            monarchy_socket_set_default = '数字牌',
            monarchy_tag_added = '标签！',
            monarchy_lineup_trigger = '请补风味文本',
            monarchy_watercolour_default = '未打出',
            monarchy_watercolour_wild = '万能花色',
            monarchy_sushi_rolls_set = '请补风味文本',
            monarchy_walkman_ante_loss = '-1底注',
            monarchy_clasped_cloak = '扣紧了！',
            monarchy_wild_goose = '追上了！',
            monarchy_slinky = '绷断了！',
            monarchy_viral_spread = '感染了！',
            monarchy_abberant_trigger = '异变！',
            monarchy_anchor_active = '起锚！',
            monarchy_anchor_primed = '放锚！',
        }
    },
    descriptions = {}
}

local descriptions = {
    Joker = {
        air_freshener = {
            name = '空气清新剂',
            text = {
                '当选择{C:attention}盲注{}时',
                '牌组中的每张{C:attention}游戏牌{}',
                '永久获得{C:blue}+#1#{}筹码',
                '{C:inactive,s:0.8}闻起来像{C:dark_edition,s:0.8}#2#{C:inactive,s:0.8}...'
            }
        },
        anchor = {
            name = '锚',
            text = {
                '牌组{C:attention}下半区{}的牌',
                '计分时给予',
                '{C:mult}+#1#{}倍率'
            }
        },
        arcade_stub = {
            name = '街机票根',
            text = {
                '本赛局每购买一个{C:attention}优惠券{}',
                '这张牌获得{C:chips}+#1#{}筹码',
                '{C:inactive}(当前为{C:chips}+#2#{C:inactive}筹码)',
            }
        },
        asteroid_belt = {
            name = '小行星带',
            text = {
                '每有一种{C:attention}#2#级{}的',
                '{C:attention}牌型{}',
                '给予{C:chips}+#1#{}筹码',
                '{C:inactive}(当前为{C:blue}+#3#{C:inactive}筹码)'
            }
        },
        bees_threes = {
            name = '蜂群三',
            text = {
                '每张打出的{C:attention}#1#{}',
                '给予{C:chips}+#2#{}筹码',
                '有{C:green}#3#/#4#{}几率给予{C:money}#5#'
            }
        },
        bicycle = {
            name = '自行车',
            text = {
                '若打出的{C:attention}#2#{}包含',
                '{C:attention}#3#{}和{C:attention}#4#{}',
                '则{C:mult}+#1#{}倍率',
            }
        },
        the_break = {
            name = '开球', -- 台球术语
            text = {
                '每回合{C:attention}第一次出牌{}时',
                '给予{C:white,X:red}X#1#{}到',
                '{C:white,X:red}X#2#{}之间的倍率'
            }
        },
        burn = {
            name = '焚烧',
            text = {
                '当选择{C:attention}盲注{}时',
                '摧毁牌组顶部的{C:attention}1张牌{}',
                '并获得{C:money}#1#'
            }
        },
        can_of_snakes = {
            name = '蛇罐头',  --蛇罐头是指一种恶作剧装置 ，外形非常像坚果罐，但内含一个长长的钢丝弹簧 ，外覆布料或乙烯基套，印有蛇皮图案，弹簧会从罐子里弹出，吓到毫无防备的受害者。
            text = {
                '每回合{C:attention}第一次出牌{}时',
                '{C:blue}+#1#{}筹码、{C:red}+#2#{}倍率',
                '或赚取{C:money}#3#{}'
            }
        },
        clasped_cloak = {
            name = '合扣斗篷',
            text = {
                '每张{C:attention}留在手牌中{}的牌',
                '获得{C:white,X:red}X#1#{}倍率',
                '{C:inactive,s:0.95}(打出后重置)'
            }
        },
        daifugo = {
            name = '大富豪',  -- 大富豪，又称大贫民，是一种日式扑克牌游戏，玩法类似华人圈的大老二与中国大陆的斗地主。
            text = {
                '每次出牌时',
                '{C:red}弃掉{}手牌中点数{C:attention}最低{}的牌',
                '并获得{C:money}#1#{}'
            }
        },
        defragment = {
            name = '碎片整理',
            text = {
                '每次弃牌时',
                '{C:attention}+#1#{}手牌上限',
                '{C:inactive,s:0.9}(回合结束时重置)'
            }
        },
        gift_receipt = {
            name = '礼品小票',
            text = {
                '当{C:attention}售出{}一张{C:attention}小丑牌{}时',
                '将其售价的{C:attention}2倍{}',
                '永久加到这张牌的{C:chips}筹码{}上',
                '{C:inactive}(当前为{C:blue}+#1#{C:inactive})'
            }
        },
        gold_cables = {
            name = '镀金电缆',
            text = {
                '重新触发所有与{C:attention}#1#{}',
                '相邻的{C:attention}计分牌{}'
            }
        },
        gummy_bears = {
            name = '小熊软糖',
            text = {
                '接下来{C:attention}#1#{}次出牌中',
                '所有{C:attention}计分牌{}都有',
                '{C:green}#2#/#3#{}几率获得',
                '{C:attention}随机增强效果'
            }
        },
        gummy_bears_alt = {
            name = '小熊软糖',
            text = {
                '接下来一次出牌中',
                '所有{C:attention}计分牌{}都有',
                '{C:green}#2#/#3#{}几率获得',
                '{C:attention}随机增强效果'
            }
        },
        gutshot = {
            name = '中洞听牌',  -- 德州扑克术语，指在组成顺子时，五张牌中缺少中间的一张（俗称“夹心”或“中洞”），
            text = {
                '若牌型包含{C:attention}#2#{}',
                '重新触发点数居中的那张牌',
                '{C:attention}#1#{}次'
            }
        },
        hailstorm = {
            name = '冰雹风暴',
            text = {
                '当{C:attention}#1#{}计分时',
                '每张{C:attention}其他计分牌{}',
                '给予{C:chips}+#2#{}筹码'
            }
        },
        iron_cross = {
            name = '铁十字',
            text = {
                '打出的{C:attention}#1#{}',
                '在计分时其效果',
                '获得{C:white,X:red}X#2#{}倍率'
            }
        },
        jolie = {
            name = '丑美人', -- Jolie Laide(法语) 指一种游离于世俗审美标准之外的独特美感，不会让人立刻惊艳，但耐人寻味。
            text = {
                '{C:attention}未增强的#1#{}',
                '计分时给予',
                '{C:white,X:red}X#2#{}倍率'
            }
        },
        kettlebell = {
            name = '壶铃',
            text = {
                    '若你离开商店时',
                    '{C:attention}没有购买{}任何卡牌',
                    '这张小丑获得{C:mult}+#2#{}倍率',
                    '{C:inactive}(当前为{C:mult}+#1#{C:inactive})'
            }
        },
        key_card = {
            name = '钥匙牌',
            text = {
                '回合结束时牌组中每剩',
                '{C:attention}#2#张人头牌{}',
                '获得{C:money}#1#{}'
            }
        },
        library = {
            name = '借书卡',
            text = {
                '每张放在{C:attention}消耗牌槽位{}的牌',
                '给予{C:mult}+#1#{}倍率',
                '{C:inactive}(当前为{C:mult}+#2#{C:inactive}倍率)'
            }
        },
        lightning_bottle = {
            name = '瓶装闪电',
            text = {
                '{C:attention}#1#{}总会出现在',
                '开局{C:attention}手牌{}中',
                '且打出时会重新触发'
            }
        },
        lineup = {
            name = '阵容',
            text = {
                '若{C:attention}第一次弃牌{}包含',
                '{C:attention}#1#{}张或更多{C:attention}#2#{}',
                '生成{C:tarot}#3#',
            }
        },
        mechanics_grip = {
            name = '机械师握把',
            text = {
                '打出的{C:attention}游戏牌{}有',
                '{C:green}#1#/#2#{}几率',
                '回到你的{C:attention}手牌'
            }
        },
        meteor_shower = {
            name = '流星雨',
            text = {
                '{C:dark_edition}版本化的{C:attention}#1#{}有',
                '{C:green}#3#/#4#{}几率替换',
                '{C:planet}#2#{}中的卡牌'
            }
        },
        metronome = {
            name = '节拍器',
            text = {
                '给予{C:chips}+#1#{}筹码或{C:mult}+#2#{}倍率',
                '每次出牌后会{C:attention}切换{}',
                '{C:inactive}(当前为{V:1}#3#{C:inactive})'
            }
        },
        minted_set = {
            name = '铸币套组',
            text = {
                '若你拥有',
                '{V:1}#2#{} {V:2}#3#{}',
                '和{V:3}#4#{C:attention}小丑牌{}则{C:white,X:red}X#1#{}倍率'
            }
        },
        negative_film = {
            name = '负片胶卷',
            text = {
                '{V:1}#1#{}和{V:2}#2#{}牌',
                '可以出现{C:attention}不止一次{}',
                '并有{C:green}#3#/#4#{}几率',
                '成为{C:dark_edition}#5#'
            }
        },
        one_chamber = {
            name = '上膛一发',
            text = {
                '{C:white,X:red}X#1#{}倍率',
                '将{C:blue}出牌次数{}设为{C:attention}0'
            }
        },
        old_sailor = {
            name = '老水手',
            text = {
                '{C:attention}#1#{}有',
                '{C:green}#3#/#4#{}几率赢得{C:money}#2#{}',
                '并有{C:green}#6#/#7#{}几率',
                '获得{C:red}+#5#{}倍率'
            }
        },
        private_eye = {
            name = '私家侦探',
            text = {
                '击败{C:attention}Boss盲注{}时',
                '生成一个随机{C:attention}标签'
            }
        },
        shattered = {
            name = '碎裂小丑',
            text = {
                '{C:attention}#1#{}给予{C:white,X:red}X#2#{}倍率',
                '并有{C:green}#3#/#4#{}',
                '几率被摧毁'
            }
        },
        slinky = {
            name = '弹簧圈小丑',
            text = {
                '每张打出的{C:attention}#1#{} {C:attention}#2#{}',
                '{C:attention}#3#{} {C:attention}#4#{} {C:attention}#5#{} 或 {C:attention}#6#{}',
                '计分时给予{C:white,X:red}X#7#{}倍率',
                '并有{C:green}#8#/#9#{}几率',
                '被摧毁'
            }
        },
        socket_set = {
            name = '套筒组',
            text = {
                '计分的{C:attention}#2#{}给予{C:red}+#1#{}倍率',
                '{C:inactive,s:0.8}(点数每回合变化)'
            }
        },
        subway_map = {
            name = '地铁图',
            text = {
                '计分牌中每有一种',
                '{C:attention}额外花色{}就获得{C:chips}+#1#{}筹码',
                '若只有{C:attention}1种花色{}计分则重置',
                '{C:inactive}(当前为{C:chips}+#2#{C:inactive}筹码)'
            }
        },
        supermassive = {
            name = '超大质量',
            text = {
                '每有一种{C:attention}牌型{}高于等级{C:attention}#2#{}',
                '这张牌获得{C:white,X:red}X#1#{}倍率',
                '{C:inactive}(当前为{C:white,X:red}X#3#{C:inactive}倍率)'
            }
        },
        sushi_rolls = {
            name = '寿司卷',
            text = {
                '{C:green}重掷{}起始价格变为{C:money}#2#',
                '持续接下来{C:attention}#1#{}个商店'
            }
        },
        sushi_rolls_alt = {
            name = '寿司卷',
            text = {
                '{C:green}重掷{}起始价格变为{C:money}#2#',
                '持续到下一个商店'
            }
        },
        suspicious_tile = {
            name = '可疑牌块',
            text = {
                '{C:attention}#1#{}可用于组成',
                '{C:attention}三条{} {C:attention}四条{}',
                '和{C:attention}五条{}'
            }
        },
        vespertine = {
            name = '晚祷',
            text = {
                '这张小丑每有一张',
                '上次出牌中的{C:attention}计分牌{}',
                '就给予{C:mult}+#1#{}倍率',
                '{C:inactive}(当前为{C:mult}+#2#{C:inactive}倍率)'
            }
        },
        walkman = {
            name = '随身听',
            text = {
                '完成{C:attention}#1#{}个底注后',
                '{C:red}-#2#{}底注',
                '{C:inactive}(当前 #3#/#1#)'
            }
        },
        watercolour = {
            name = '水彩小丑',
            text = {
                '若{C:attention}第一张计分牌{}花色',
                '与上一手不同',
                '则给予{C:white,X:red}X#1#{}倍率',
                '{C:inactive,s:0.9}(上次花色 {V:1,s:0.9}#2#{C:inactive,s:0.9})'
            }
        },
        wild_goose = {
            name = '竹篮打水', -- Wild Goose Chase 源自莎士比亚的作品《罗密欧与茱丽叶》，原指由于野鹅飞行路线难以预测而进行的徒劳的追逐，后演变为用来形容毫无希望的努力
            text = {
                '每次抽到的{C:attention}手牌{}中',
                '一张{C:attention}随机卡牌{}',
                '计分时给予{C:white,X:red}X#1#{}倍率'
            }
        },
        windchime = {
            name = '棱彩风铃',
            text = {
                '打出{C:attention}#1#张增强牌{}后',
                '这张小丑获得{C:white,X:red}X#2#{}倍率',
                '{C:inactive,s:0.9}(当前为{C:white,X:red,s:0.9}X#3#{C:inactive,s:0.9}倍率)'
            }
        },
        wingman = {
            name = '僚机小丑',
            text = {
                '若打出的牌型是{C:attention}#2#的#1#{}',
                '这张小丑获得{C:white,X:red}X#3#{}倍率',
                '击败{C:attention}Boss盲注{}时重置',
                '{C:inactive,s:0.9}(当前为{C:white,X:red,s:0.9}X#4#{C:inactive,s:0.9}倍率)'
            }
        },
    },
    Voucher = {
        frequent_flier = {
            name = '飞行常客',
            text = {
                '跳过{C:attention}盲注{}时',
                '获得{C:money}#1#'
            }
        },
        first_class = {
            name = '头等舱',
            text = {
                '当你在单个商店中',
                '花费{C:money}#1#{}时',
                '获得一个随机{C:attention}标签'
            }
        },
        viral = {
            name = '病毒传播',
            text = {
                '{C:attention}增强效果{}有{C:green}#1#/#2#{}几率',
                '在计分时扩散到相邻的',
                '{C:attention}计分牌{}'
            }
        },
        biohazard = {
            name = '生化危机',
            text = {
                '{C:dark_edition}版本{}和{C:attention}蜡封{}有',
                '{C:green}#1#/#2#{}几率在计分时扩散到',
                '相邻的{C:attention}计分牌{}'
            }
        },
    },
    Back = {
        orbit = {
            name = '轨道牌组',
            text = {
                '击败{C:attention}Boss盲注{}后',
                '获得{C:attention}#1#个{C:attention,T:tag_orbital}#2#{}',
                '{s:0.2} ',
                '{C:planet}#3#{} {C:planet}#4#{}',
                '和其他相关内容不再出现'
            }
        },
        jetsetter = {
            name = '环球旅行牌组',
            text = {
                '开局拥有{T:v_monarchy_frequent_flier,C:attention}#1#',
                '和{T:v_monarchy_first_class,C:attention}#2#{}优惠券',
                '{s:0.2} ',
                '利息上限提高到',
                '{C:money}#3#'
            }
        },
        sparkle = {
            name = '闪耀牌组',
            text = {
                '开局拥有{T:v_magic_trick,C:attention}#1#',
                '和{T:v_illusion,C:attention}#2#{}优惠券',
                '{s:0.2} ',
                '每回合结束时',
                '摧毁{C:attention}#3#张牌{}'
            }
        },
        abberant = {
            name = '异变牌组',
            text = {
                '开局拥有{C:attention}#1#张增强牌{}',
                '{s:0.2} ',
                '{C:attention}增强牌{}在计分时',
                '其{C:attention}增强效果{}会随机化'
            }
        },
    }
}
-- from monarchy source code: utils\functions.lua
local function prefix_loc_table(input, output)
    local mod_prefix = "monarchy"
    local fallback_class_prefix = {
        Joker = "j",
        Voucher = "v",
        Back = "b",
    }
    for type, data in pairs(input) do
        local pref = mod_prefix .. '_'
        if SMODS and SMODS[type] and SMODS[type].class_prefix then
            pref = SMODS[type].class_prefix .. '_' .. pref
        elseif fallback_class_prefix[type] then
            pref = fallback_class_prefix[type] .. '_' .. pref
        end
        output.descriptions[type] = output.descriptions[type] or {}
        for key, t in pairs(data) do
            output.descriptions[type][pref..key] = t
        end
    end
    return output
end
return prefix_loc_table(descriptions, loc_table)
