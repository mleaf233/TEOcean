-- 译者：
-- [羖Kaa](https://space.bilibili.com/98617060)
-- [mleaf233](https://github.com/mleaf233) 作部分校对
return {
	translator = {
		"羖Kaa",
		"mleaf233",
	},
	descriptions = {
		Enhanced = {
			m_entr_flesh = {
				name = "血肉牌",
				text = {
					"{C:green}#1#/#2#{}概率在",
					"被{C:attention}弃牌{}时摧毁自身"
				}
			},
			m_entr_disavowed = {
				name = "否定牌",
				text = {
					"无法更改增强类型"
				}
			},
			m_entr_prismatic = {
				name = "棱光牌",
				text = {
					"{X:dark_edition,C:white}^#1#{}倍率",
					"计分时再提升{X:dark_edition,C:white}^#2#{}"
				}
			},
			m_entr_dark = {
				name = "暗黑牌",
				text = {
					"留在手中时{X:blue,C:white}X#2#{}筹码",
					"每有一种{C:attention}花色{}被计分",
					"再提升{X:blue,C:white}X#1#{}"
				}
			},
			m_entr_ceramic = {
				name = "陶瓷牌",
				text = {
					"拥有独立的{C:attention}点数{}",
					"视为所有{C:attention}花色{}",
					"计分时{C:red}自毁{}",
					"并生成一张随机{C:attention}消耗牌{}"
				}
			},
			m_entr_radiant = {
				name = "日耀牌",
				text = {
					"{C:gold}+#1#{}升阶强度"
				}
			},
			m_entr_ethereal = {
				name = "飘渺牌",
				text = {
					"这张卡被修改时",
					"创造一张{C:spectral}幻灵牌{}",
					"{C:inactive}(必须有空间){}"
				}
			},
			m_entr_samsara = {
				name = "轮回牌",
				text = {
					"被修改时{C:red}摧毁自身{}",
					"被摧毁时，创造一张",
					"获得{X:blue,C:white}+X#2#{}筹码的{C:attention}复制{}",
					"{C:inactive}(当前:{X:blue,C:white}X#1#{C:inactive})"
				}
			},
		},
		["Content Set"] = {
			set_entr_inversions = {
				name = "反转合集",
				text = {
					"由 Entropy 添加的",
					"{C:attention}消耗牌反转{}效果"
				}
			},
			set_entr_tags = {
				name = "标签合集",
				text = {
					"由 Entropy 添加的",
					"{C:attention}标签{}"
				}
			},
			set_entr_blinds = {
				name = "盲注合集",
				text = {
					"由 Entropy 添加的",
					"{C:attention}Boss 盲注{}"
				}
			},
			set_entr_decks = {
				name = "牌组合集",
				text = {
					"由 Entropy 添加的",
					"{C:attention}牌组{}"
				}
			},
			set_entr_misc = {
				name = "杂项合集",
				text = {
					"不适用于其他{C:cry_ascendant}主题集合{}的内容",
				}
			},
			set_entr_entropics = {
				name = "熵化小丑合集",
				text = {
					"拥有{C:entr_entropic}熵化{}稀有度的",
					"强力小丑"
				}
			},
			set_entr_vouchers = {
				name = "优惠券合集",
				text = {
					"由 Entropy 添加的",
					"{C:attention}优惠券{}"
				}
			},
			set_entr_spectrals = {
				name = "幻灵合集",
				text = {
					"由 Entropy 添加的",
					"{C:attention}幻灵牌{}"
				}
			},
			set_entr_misc_jokers = {
				name = "杂项小丑合集",
				text = {
					"不适用于其他{C:cry_ascendant}主题集合{}的{C:attention}小丑{}",
				}
			},
			set_entr_altpath = {
				name = "分岔路口合集",
				text = {
					"与游戏中",
					"{C:entr_entropic}分岔路口{}进度相关的",
					"{C:attention}内容{}"
				}
			},
			set_entr_dice_jokers = {
				name = "骰子小丑合集",
				text = {
					"由 Entropy 添加的",
					"通过骰子改变概率的{C:attention}小丑{}"
				}
			},
			set_entr_runes = {
				name = "符文合集",
				text = {
					"由 Entropy 添加的",
					"全新{C:attention}消耗牌类型{}"
				}
			},
			set_entr_actives = {
				name = "主动小丑",
				text = {
					"由 Entropy 添加的",
					"需要{C:attention}手动{}激活的{C:attention}小丑{}"
				},
			},
		},
		Aesthetic = {
			c_entr_breakcore = {
				name = "碎核"
			},
			c_entr_vintage = {
				name = "复古"
			},
			c_entr_retro = {
				name = "怀旧"
			},
			c_entr_disco = {
				name = "迪斯科"
			},
			c_entr_ytp = {
				name = "YTP"
			},
			c_entr_solarpunk = {
				name = "太阳能朋克"
			},
			c_entr_lewd = {
				name = "涩涩"
			}
		},
		Joker = {
			--Crossmod Jokers
			j_entr_compositor = {
				name = "排字工",
				text = {
					"选择{C:attention}盲注{}时",
					"创造一张随机{C:attention}扭曲牌{}"
				}
			},
			j_cry_redeo = {
				name = "回溯",
				text = {
					"消耗{C:money}$#2#{}{C:inactive}($#3#){}时",
					"{C:attention}-#1#{}底注",
					"{s:0.8}每次使用需求{s:0.8,C:attention}指数增长{}",
					"{s:0.8,C:money}下次增加：{s:1,c:money}$#4#"
				}
			},
			j_entr_stillicidium = {
				name = "D-1",
				text = {
					"离开商店时，将右侧{C:attention}小丑{}",
					"与所有{C:attention}消耗牌{}",
					"变为收藏中前一张卡牌",
					"手牌计分时点数-1",
					"盲注需求减少{C:attention}30%{}"
				}
			},
			j_entr_surreal_joker = {
				name = "超现实小丑",
				text = {
					"分数倍率{X:entr_eqmult,C:white}= #1#{}"
				}
			},
			j_entr_tesseract = {
				name = "四维超立方",
				text = {
					"倍率逆时针旋转{X:dark_edition,C:white}#1#{}°",
					"筹码顺时针旋转{X:dark_edition,C:white}#1#{}°"
				}
			},
			j_entr_epitachyno = {
				name = "超速",
				text = {
					"离开商店时，",
					"所有其他小丑数值增加{X:dark_edition,C:white}^#1#{}",
					"然后令指数增加{X:dark_edition,C:white}#2#{}"
				}
			},
			j_entr_helios = {
				name = "赫利俄斯",
				text = {
					"{C:attention}无限制{}手牌选择数量",
					"晋升公式变为{X:dark_edition,C:white}^(#1#×#2#n){}",
					"所有卡牌均参与{C:attention}升阶强度{}计算"
				}
			},
			j_entr_xekanos = {
				name = "赛卡诺斯",
				text = {
					"底注增加时，获得{X:dark_edition,C:white}#1#X{}底注进度",
					"并再提升{X:dark_edition,C:white}#2#{}",
					"出售{C:red}稀有{}或更高小丑时",
					"该值{X:dark_edition,C:white}减半{}"
				}
			},
			j_entr_ieros = {
				name = "神圣",
				text = {
					"商店有{X:dark_edition,C:white}33%{}概率递归提升",
					"小丑{C:attention}稀有度{}",
					"购买小丑时，根据其{C:attention}稀有度{}",
					"获得{X:dark_edition,C:white}^筹码{}",
					"{C:inactive}(当前为{X:dark_edition,C:white}^#1#{}{C:inactive})"
				}
			},
			j_entr_dekatria = {
				name = "德卡提拉",
				text = {
					"打出的手牌每包含一个{C:attention}对子{}",
					"该小丑获得{X:dark_edition,C:white}^#1#{}倍率",
					"所有卡牌均视为{C:dark_edition}欢愉{}"
				}
			},
			j_entr_oekrep = {
				name = "欧奇帕",
				text = {
					"离开商店时，根据一张",
					"随机{C:attention}消耗牌{}生成一个",
					"{C:dark_edition}负片{}巨型补充包"
				}
			},
			j_entr_kciroy = {
				name = "克里约",
				text = {
					"{C:dark_edition}+#1#{}手牌上限，{C:dark_edition}+#2#{}选择上限",
					"每弃掉{C:attention}#4#{}{C:inactive}[#5#]{}张牌",
					"该小丑获得{X:dark_edition,C:white}^#3#{}筹码",
					"{C:inactive}(当前为{X:dark_edition,C:white}^#6#{}筹码){}"
				}
			},
			j_entr_tocihc = {
				name = "科希",
				text = {
					"选择盲注时，生成当前盲注的",
					"{C:attention}跳过标签{}",
					"非Boss盲注需求减少{C:attention}80%{}",
					"{C:inactive}(当前为#1#)"
				}
			},
			j_entr_teluobirt = {
				name = "莱布里特",
				text = {
					"每打出一组{C:attention}J{}",
					"按打出顺序重新触发已计分的 J",
					"并给予{X:chips,C:white}X筹码{}，数值等于打出 J 的数量"
				}
			},
			j_entr_oinac = {
				name = "奥尼卡",
				text = {
					"当一张{C:attention}人头牌{}被该小丑摧毁时",
					"获得{X:dark_edition,C:white}^#1#{}筹码",
					"{C:attention}打出{}的牌将会被{C:red}摧毁{}",
					"并抽一张+1点数的牌到{C:attention}手牌{}",
					"{C:inactive}(当前为{X:dark_edition,C:white}^#2#{}{C:inactive}筹码)"
				}
			},
			j_entr_entropy_card = {
				name = "熵之记忆",
				text = {
					"每在 Entropy 的 #晋升崇拜 频道",
					"出现一次{C:attention}太阳脸{}表情",
					"获得{X:gold,C:white}X#1#{}升阶强度",
					"{C:inactive}(当前为{X:gold,C:white}X#2#{}{C:inactive})",
					"{C:blue,s:0.7}https://discord.gg/beqqy4Bb7m"
				}
			},
			j_entr_solarflare = {
				name = "太阳耀斑",
				text = {
					"其他{C:dark_edition}太阳{}卡牌",
					"各给予{X:gold,C:white}X#1#{}升阶强度"
				}
			},
			j_entr_burnt_m = {
				name = "烧焦 M",
				text = {
					"若打出的牌包含{C:attention}对子{}",
					"为第一张牌施加{C:dark_edition}太阳{}",
					"每有一张{C:dark_edition}欢愉{}小丑",
					"再多施加 1 张"
				}
			},
			j_entr_anaptyxi = {
				name = "成长",
				text = {
					"成长小丑按{C:attention}二次方{}成长",
					"并将同等成长值",
					"以{X:dark_edition,C:white}X#1#{}给予其他小丑",
					"回合结束时再提升{X:dark_edition,C:white}X#2#{}",
					"{C:inactive}(成长 自身除外)"
				}
			},
			j_entr_chaos = {
				name = "混沌",
				text = {
					"当卡牌被{C:attention}生成{}时",
					"改为生成一张",
					"随机{C:attention}类型{}的卡牌"
				}
			},
			j_entr_parakmi = {
				name = "衰老",
				text = {
					"{C:attention}任何{}卡牌都可能",
					"出现在任何位置",
					"{C:dark_edition}+#1#{}商店栏位"
				}
			},
			j_entr_exousia = {
				name = "力量",
				text = {
					"{C:attention}晋升{}所有标签",
					"选择任意盲注时",
					"获得{C:attention}#1#{}个跳过标签"
				}
			},
			j_entr_akyros = {
				name = "归墟",
				text = {
					"小丑栏位可以花{C:gold}$#1#{}购买",
					"也能以{C:gold}$#2#{}出售",
					"回合结束时，根据空栏位数量",
					"获得金钱",
					"{C:inactive}(当前为{C:money}#3#{}{C:inactive})"
				}
			},
			j_entr_dni = {
				name = "DNI",
				text = {
					"每次出牌选择一种花色",
					"摧毁所有该花色的得分牌",
					"{C:inactive}(当前为{V:1}#1#{}{C:inactive})"
				}
			},
			j_entr_strawberry_pie = {
				name = "草莓派",
				text = {
					"所有牌型的升级",
					"全部重定向到{C:attention}高牌{}"
				}
			},
			j_entr_recursive_joker = {
				name = "递归小丑",
				text = {
					"出售该小丑时，",
					"生成一张自身的复制",
					"{C:red}每回合限一次{}",
					"{C:inactive}(当前为#1#)"
				}
			},
			j_entr_trapezium_cluster = {
				name = "梯形星团",
				text = {
					"其他{C:dark_edition}碎裂{}卡牌",
					"各{C:dark_edition}强制触发{}",
					"{C:dark_edition}#1#{}张随机卡牌"
				}
			},
			j_entr_katarraktis = {
				name = "瀑布",
				text = {
					"将右侧{C:attention}小丑{}重新触发{C:attention}#1#{}次，",
					"之后每个更右侧的小丑",
					"以上一个的两倍次数重新触发"
				}
			},
			j_entr_dr_sunshine = {
				name = "阳光博士",
				text = {
					"每当一张扑克牌被{C:attention}摧毁{}",
					"该小丑获得{C:gold}+#1#{}升阶强度",
					"{C:inactive}(当前为{C:gold}+#2#{}{C:inactive})"
				}
			},
			j_entr_sunny_joker = {
				name = "晴朗小丑",
				text = {
					"{C:gold}+#1#{}升阶强度"
				}
			},
			j_entr_metanoia = {
				name = "蜕变",
				text = {
					"被弃掉的牌变为{C:attention}血肉牌{}"
				}
			},
			j_entr_antidagger = {
				name = "反匕首",
				text = {
					"选择盲注时，解除一张被放逐小丑的放逐",
					"{C:green}#1#/#2#{}概率改为放逐自身"
				}
			},
			j_entr_solar_dagger = {
				name = "太阳匕首",
				text = {
					"选择盲注时，摧毁右侧小丑",
					"并将其售价的十分之一",
					"永久加至自身的{C:gold}升阶强度{}",
					"{C:inactive}(当前为{X:gold,C:white}X#1#{}{C:inactive}升阶强度)"
				}
			},
			j_entr_insatiable_dagger = {
				name = "贪婪匕首",
				text = {
					"选择盲注时，放逐最右侧小丑",
					"左侧小丑获得其售价的{C:attention}5%{}",
					"作为{C:purple}倍率值加成"
				}
			},
			j_entr_rusty_shredder = {
				name = "锈碎纸机",
				text = {
					"{C:green}#1# / #2#{}的概率创建一张",
					"带有{C:attention}临时{}的{C:dark_edition}负片{}",
					"被弃掉的牌的复制"
				}
			},
			j_entr_chocolate_egg = {
				name = "巧克力蛋",
				text = {
					"该小丑被摧毁时，生成一张",
					"随机{C:dark_edition}晴朗{}{C:red}稀有{}小丑",
					"若被{C:red}放逐{}，则改为生成",
					"一张{C:dark_edition}晴朗{}{C:cry_epic}史诗{}小丑"
				}
			},
			j_entr_chocolate_egg_cryptidless = {
				name = "巧克力蛋",
				text = {
					"该小丑被摧毁时，生成一张",
					"随机{C:dark_edition}晴朗{}{C:red}稀有{}小丑"
				}
			},
			j_entr_antireal = {
				name = "反现实",
				text = {
					"每有一个空的小丑栏位",
					"获得{X:gold,C:white}+X#1#{}升阶强度",
					"{s:0.8}包含自身{}",
					"{C:inactive}(当前为{X:gold,C:white}X#2#{}{C:inactive})"
				}
			},
			j_entr_jokerinyellow = {
				name = "黄衣小丑",
				text = {
					"抽牌时{C:green}#1#/#2#{}概率",
					"给予卡牌{C:diamonds}黄印{}贴纸",
					"打出{C:diamonds}方片{}时放逐随机小丑",
					"选中{C:diamonds}方片{}时给予随机卡牌",
					"{C:dark_edition}临时{}效果",
					"若手牌同时有{C:attention}7 张方片{}，自毁"
				}
			},
			j_entr_lotteryticket = {
				name = "彩票",
				text = {
					"回合结束时失去{C:gold}$#5#{}",
					"{C:green}#1#/#2#{}概率获得{C:gold}$#6#{}",
					"{C:green}#3#/#4#{}概率改为获得{C:gold}$#7#{}"
				}
			},
			j_entr_ruby = {
				name = "露比·希望之主",
				text = {
					"每次进入或离开{C:attention}翻转面{}时",
					"该小丑获得{X:mult,C:white}X#1#{}倍率",
					"{C:inactive}(当前为{X:mult,C:white}X#2#{}{C:inactive})"
				}
			},
			j_entr_slipstream = {
				name = "滑流·时间子嗣",
				text = {
					"选择盲注时生成一张{C:red}厄兆{}牌",
					"持有的{C:red}厄兆{}牌给予{X:mult,C:white}X#1#{}倍率"
				}
			},
			j_entr_cass = {
				name = "卡斯诺兹·虚空启迪",
				text = {
					"使用任意{C:planet}星球{}或{C:purple}恒星{}牌时",
					"随机一项属性提升{C:attention}#7#{}",
					"{C:inactive}({C:blue}+#1#{}手牌上限，{C:attention}+#2#{}选择上限)",
					"{C:inactive}({C:blue}+#3#{}出牌，{C:red}+#4#{}弃牌)",
					"{C:inactive}({C:dark_edition}+#5#{}消耗槽，{C:attention}+#6#{}商店栏)"
				}
			},
			j_entr_crabus = {
				name = "奎布斯·厄难宠儿",
				text = {
					"打出的未计分牌变为{C:attention}暗黑牌{}",
					"{C:attention}暗黑牌{}在打出时成长",
					"每添加一张{C:attention}暗黑牌{}",
					"该小丑获得{X:chips,C:white}X#1#{}筹码",
					"{C:inactive}(当前为{X:chips,C:white}X#2#{}{C:inactive})"
				}
			},
			j_entr_devilled_suns = {
				name = "魔鬼日",
				text = {
					"黄金牌给予",
					"{C:gold}+#1#{}升阶强度",
					"每拥有一张{C:dark_edition}晴朗{}小丑",
					"再额外给予{C:gold}+#2#{}"
				}
			},
			j_entr_eden = {
				name = "伊甸园",
				text = {
					"其他{C:dark_edition}晴朗{}卡牌",
					"各给予{C:gold}+#1#{}升阶强度"
				}
			},
			j_entr_exelixi = {
				name = "发展",
				text = {
					"打出的手牌计分时",
					"升级其{C:attention}增强{}",
					"弃牌时，将其{C:attention}增强{}",
					"赋予相邻卡牌"
				}
			},
			j_entr_seventyseven = {
				name = "77+33",
				text = {
					"{X:entr_eqchips,C:white}=#1#{}筹码"
				}
			},
			j_entr_jokezmann_brain = {
				name = "Jokezman 之脑",
				text = {
					"离开商店时，每个空的小丑栏位",
					"有{C:green}#1#/#2#{}概率被随机",
					"{C:dark_edition}易腐、过饱和{}小丑填充"
				}
			},
			j_entr_libra = {
				name = "天秤座",
				text = {
					"计分的{C:dark_edition}万能{}牌与{C:attention}人头{}牌",
					"与该小丑{C:attention}平衡{}数值",
					"{C:inactive}(当前为{X:dark_edition,C:white}^#1#{}{C:inactive}筹码)"
				}
			},
			j_entr_scorpio = {
				name = "天蝎座",
				text = {
					"计分的{C:attention}8{}临时提升概率",
					"根据{C:attention}8面骰{}结果给予{X:dark_edition,C:white}^筹码{}",
					"若骰出{C:attention}8{}，则给予{X:dark_edition,C:white}^#1#{}筹码"
				}
			},
			j_entr_ridiculus_absens = {
				name = "荒诞虚无",
				text = {
					"已计分的非{C:dark_edition}故障{}牌",
					"{C:green}#1#/#2#{}概率变为{C:dark_edition}故障{}",
					"并获得额外效果",
					"出牌时重掷该概率"
				}
			},
			j_entr_endlessentropy = {
				name = "熵无尽",
				text = {
					"在{C:blue}出牌{}与{C:red}弃牌{}时分别循环",
					"以下效果：",
					"#1#",
					"#2#"
				}
			},
			j_entr_skullcry = {
				name = ":skullcry:",
				text = {
					"若得分 >{C:attention}log_#1#(盲注需求){}，则免死",
					"若得分不在需求{C:attention}#2#%{}范围内，{C:red}自毁"
				}
			},
			j_entr_dating_simbo = {
				name = "恋爱模拟器",
				text = {
					"{C:hearts}红桃{}在计分时被摧毁",
					"并将其{C:blue}筹码{}加至该小丑",
					"{C:inactive}(当前为{C:blue}+#1#{}{C:inactive}筹码)"
				}
			},
			j_entr_bossfight = {
				name = "Boss战",
				text = {
					"若恰好打出{C:attention}#1#{}张牌",
					"所有手牌获得{C:blue}+#2#{}筹码"
				}
			},
			j_entr_sweet_tooth = {
				name = "甜食癖",
				text = {
					"离开商店时，{C:blue}+#1#{}筹码",
					"摧毁所有{C:attention}食物{}或{C:attention}糖果{}小丑",
					"若摧毁成功，该小丑筹码",
					"提升{X:dark_edition,C:white}^#2#{}"
				}
			},
			j_entr_phantom_shopper = {
				name = "幽灵买家",
				text = {
					"出售该小丑可生成",
					"一张{C:attention}#1#{}稀有度小丑",
					"每进过{C:attention}#2#{}{C:inactive}[#3#]{}家商店提升一次"
				}
			},
			j_entr_sunny_side_up = {
				name = "太阳蛋",
				text = {
					"{C:gold}+#1#{}升阶强度",
					"每打出一手牌",
					"{C:gold}-#2#{}升阶强度"
				}
			},
			j_entr_atomikos = {
				name = "原子",
				text = {
					"{C:attention}高牌{}的运算符变为{C:attention}^{}",
					"{C:attention}打出{}的牌型被{C:red}删除{}",
					"其数值{C:attention}添加{}至{C:attention}高牌{}"
				}
			},
			j_entr_code_m = {
				name = "M()",
				text = {
					"使用{C:green}代码牌{}时",
					"为随机一张小丑",
					"施加{C:dark_edition}欢愉{}"
				}
			},
			j_entr_sunflower_seeds = {
				name = "向日葵种子",
				text = {
					"打出{C:attention}#1#{}{C:inactive}[#2#]{}次晋升牌型后",
					"为随机小丑",
					"施加{C:dark_edition}晴朗{}并{C:red}自毁"
				}
			},
			j_entr_tenner = {
				name = "十元券",
				text = {
					"$ = {X:gold,C:white}#1#{}"
				}
			},
			j_entr_sticker_sheet = {
				name = "贴纸大全",
				text = {
					"每有一张{C:attention}贴纸{}",
					"{C:red}+#1#{}倍率",
					"为一张{C:attention}随机{}计分手牌",
					"贴一张{C:attention}随机{}贴纸",
					"{C:inactive}(当前为{C:red}+#2#{}{C:inactive}倍率)"
				}
			},
			j_entr_metamorphosis = {
				name = "变形记",
				text = {
					"主小丑的{C:attention}计分{}效果",
					"改为在{C:attention}#1#{}被计分时触发",
					"该点数每次出牌都会变化"
				}
			},
			j_entr_fourbit = {
				name = "4Bit 小丑",
				text = {
					"每第{C:attention}#1#{}{C:inactive}[#2#]{}张计分牌",
					"随机获得一种",
					"{C:attention}增强{}"
				}
			},
			j_entr_scenic_route = {
				name = "风景路线",
				text = {
					"击败{C:attention}Boss 盲注{}时",
					"生成一张{C:red}(~)$new(){}",
					"{C:inactive}(必须有空间)"
				}
			},
			j_entr_crimson_flask = {
				name = "绯红烧瓶",
				text = {
					"有小丑被{C:attention}削弱{}时获得{X:mult,C:white}X#1#{}倍率",
					"有已削弱牌被抽到手中时再获得{X:mult,C:white}X#2#{}",
					"每回合随机削弱一张小丑",
					"{C:inactive}(当前为{X:mult,C:white}X#3#{}{C:inactive}倍率)"
				}
			},
			j_entr_grotesque_joker = {
				name = "怪诞小丑",
				text = {
					"生成血肉牌时获得{X:mult,C:white}X#1#{}倍率",
					"摧毁血肉牌时获得{X:chips,C:white}X#2#{}筹码",
					"{C:inactive}(当前为{X:mult,C:white}X#3#{},{X:chips,C:white}X#4#{}{C:inactive}){}"
				}
			},
			j_entr_nyctophobia = {
				name = "黑暗恐惧症",
				text = {
					"选择盲注时，每当先前",
					"{C:attention}使用过{}消耗牌",
					"就摧毁一张随机{C:attention}消耗牌{}",
					"并抽两张随机{C:dark_edition}暗黑{}牌"
				}
			},
			j_entr_dog_chocolate = {
				name = "狗狗巧克力",
				text = {
					"合并{C:attention}狗狗标签{}时",
					"改为生成一张{C:attention}糖果{}小丑",
					"并{C:red}摧毁{}两张狗狗标签",
					"{C:attention}狗狗标签{}出现频率提升"
				}
			},
			j_entr_nucleotide = {
				name = "核苷酸",
				text = {
					"复制每回合丢弃的第一张牌",
					"{C:attention}反转{}其点数与花色，",
					"并提升{C:dark_edition}版本{}等级后",
					"将其放入{C:attention}手牌{}"
				}
			},
			j_entr_caviar = {
				name = "鱼子酱",
				text = {
					"强化接下来",
					"获得的{C:attention}#1#{}个标签"
				}
			},
			j_entr_afterimage = {
				name = "残影",
				text = {
					"手牌计分时有{C:green}#1#/#2#{}概率",
					"抽一张{C:attention}易腐香蕉{}复制到手牌"
				}
			},
			j_entr_apeirostemma = {
				name = "D∞",
				text = {
					"该小丑可在{C:attention}6{}种",
					"效果中循环切换"
				}
			},
			j_entr_apeirostemma_1 = {
				name = "D∞ (D1)",
				text = {
					"复制一张随机{C:attention}小丑{}",
					"与一张随机{C:attention}消耗牌{}",
					"并施加负片",
					"{C:inactive}(D∞自身除外)"
				}
			},
			j_entr_apeirostemma_2 = {
				name = "D∞ (D2)",
				text = {
					"{C:green}#1#/#2#{}概率",
					"{C:dark_edition}强制触发{}",
					"所有其他小丑"
				}
			},
			j_entr_apeirostemma_3 = {
				name = "D∞ (D3)",
				text = {
					"若恰好打出{C:attention}3{}张牌",
					"该小丑获得{X:dark_edition,C:white}^#1#{}筹码",
					"{C:inactive}(当前为{X:dark_edition,C:white}^#2#{}{C:inactive})"
				}
			},
			j_entr_apeirostemma_4 = {
				name = "D∞ (D4)",
				text = {
					"选择盲注时",
					"重掷右侧所有小丑"
				}
			},
			j_entr_apeirostemma_5 = {
				name = "D∞ (D5)",
				text = {
					"购买商店物品时",
					"该小丑数值提升{C:attention}X(1 - 1.1){}",
					"不计本效果"
				}
			},
			j_entr_apeirostemma_6 = {
				name = "D∞ (D6)",
				text = {
					"所有 3-9 的牌",
					"重新触发{C:attention}3-9{}次"
				}
			},
			j_entr_qu = {
				name = "Qu",
				text = {
					"选择盲注时",
					"手牌中一张随机牌",
					"获得一张随机{C:red}扭曲{}牌作为增强"
				}
			},
			j_entr_memento_mori = {
				name = {
					"一个拍膝大笑的小丑标题",
					"指代 Entropy 小丑效果总是那样",
					"(Memento Mori 熵改版)"
				},
				text = {
					"每回合打出的{C:attention}第一张牌{}",
					"被{C:attention}摧毁{}"
				}
			},
			j_entr_broadcast = {
				name = "广播",
				text = {
					"复制第{C:attention}#1#{}#2#个小丑的效果",
					"每次出牌，该数字+1",
					"到达最后一张小丑后重置"
				}
			},
			j_entr_d0 = {
				name = "D0",
				text = {
					"将所有{C:attention}列出的{}{C:green,E:1}概率{}",
					"乘以{C:attention}0",
					"{C:inactive}(例如 {C:green}1/3{C:inactive} -> {C:green}0/3{C:inactive})"
				}
			},
			j_entr_d1 = {
				name = "D1",
				text = {
					"每回合第一次概率判定",
					"{C:green}必定成功{}"
				}
			},
			j_entr_d4 = {
				name = "D4",
				text = {
					"概率进行{C:attention}两次{}判定",
					"只需{C:attention}一次成功{}即可"
				}
			},
			j_entr_d6 = {
				name = "D6",
				text = {
					"概率判定{C:red}失败{}时",
					"该小丑分子获得{C:green}+#2#{}",
					"成功时重置",
					"{C:inactive}(当前为{C:green}+#1#{}{C:inactive})"
				}
			},
			j_entr_eternal_d6 = {
				name = "永恒D6",
				text = {
					"重掷商店时{C:green}#1#/#2#{}概率",
					"{C:red}摧毁{}一张随机商店卡牌，否则获得该卡牌",
					"同时分子获得{C:green}+#4#{}，底注结束时重置",
					"{C:inactive}(当前为{C:green}+#3#{}{C:inactive})"
				}
			},
			j_entr_d7 = {
				name = "D7",
				text = {
					"{C:green}#1#/#2#{}概率",
					"重新触发每个",
					"基于概率的{C:attention}小丑{}与{C:attention}增强{}"
				}
			},
			j_entr_d8 = {
				name = "D8",
				text = {
					"概率判定的分母",
					"降低{C:attention}#1#{}"
				}
			},
			j_entr_d10 = {
				name = "D10",
				text = {
					"概率判定时",
					"分子与分母{C:attention}随机偏移{}"
				}
			},
			j_entr_d12 = {
				name = "D12",
				text = {
					"每持有一张消耗牌",
					"{C:green}+#1#{}分子"
				}
			},
			j_entr_d100 = {
				name = "D100",
				text = {
					"概率被触发时",
					"永久随机重掷概率值"
				}
			},
			j_entr_capsule_machine = {
				name = "扭蛋机",
				text = {
					"选择盲注时",
					"生成一张{C:attention}易腐{C:green}骰子{}{C:attention}小丑{}",
					"{C:inactive}(必须有空间)"
				}
			},
			j_entr_milk_chocolate = {
				name = "牛奶巧克力",
				text = {
					"出售该牌",
					"生成一张免费",
					"{C:attention}#1#"
				}
			},
			j_entr_insurance_fraud = {
				name = "保险诈骗",
				text = {
					"出售一张{C:purple}塔罗{}牌时",
					"生成一张随机{C:red}欺诈{}牌"
				}
			},
			j_entr_free_samples = {
				name = "免费样品",
				text = {
					"打开{C:attention}补充包{}时",
					"{C:green}#1#/#2#{}概率复制一份到消耗牌槽",
					"{C:inactive}(必须有空间)"
				}
			},
			j_entr_fused_lens = {
				name = "融合透镜",
				text = {
					"{C:green}#1#/#2#{}概率",
					"为打出的牌型生成",
					"对应的{C:purple}恒星{}牌",
					"{C:inactive}(必须有空间)"
				}
			},
			j_entr_opal = {
				name = "蛋白石",
				text = {
					"无色牌可用于组成牌型",
					"{C:attention}重新触发{}无色牌"
				}
			},
			j_entr_inkbleed = {
				name = "墨渍",
				text = {
					"共享{C:attention}点数{}或{C:attention}修改{}的牌",
					"互相视为对方花色"
				}
			},
			j_entr_roulette = {
				name = "轮盘赌",
				text = {
					"{C:green}#1#/#2#{}概率令每张计分牌",
					"获得{C:red}+#3#{}额外倍率",
					"摧毁每第{C:attention}#4#{}张计分牌"
				}
			},
			j_entr_debit_card = {
				name = "借记卡",
				text = {
					"每花{C:money}$#2#{}{C:inactive}[$#3#]{}",
					"回合结束时额外获得{C:money}$#1#{}",
					"{C:inactive}(当前为{C:money}$#4#{}{C:inactive})"
				}
			},
			j_entr_birthday_card = {
				name = "生日卡",
				text = {
					"至少持有{C:attention}#2#{}张消耗牌时",
					"获得{X:mult,C:white}X#1#{}倍率"
				}
			},
			j_entr_sandpaper = {
				name = "砂纸",
				text = {
					"若打出牌中含{C:attention}石头牌{}",
					"摧毁所有打出的{C:attention}石头牌{}",
					"并生成一张随机{C:purple}符文牌{}"
				}
			},
			j_entr_purple_joker = {
				name = "紫色小丑",
				text = {
					"每张{C:purple}符文{}触发时",
					"该小丑获得{X:mult,C:white}X#1#{}倍率",
					"{C:inactive}(当前为{X:mult,C:white}X#2#{}{C:inactive})"
				}
			},
			j_entr_chalice_of_blood = {
				name = "鲜血圣杯",
				text = {
					"每使用一张{C:red}契约{}牌",
					"该小丑获得{X:mult,C:white}X#1#{}倍率",
					"{C:inactive}(当前为{X:mult,C:white}X#2#{}{C:inactive})"
				}
			},
			j_entr_torn_photograph = {
				name = "碎照片",
				text = {
					"每出售一张{C:red}扭曲{}牌",
					"该小丑获得{X:mult,C:white}X#1#{}倍率",
					"{C:inactive}(当前为{X:mult,C:white}X#2#{}{C:inactive})"
				}
			},
			j_entr_chuckle_cola = {
				name = "咯咯可乐",
				text = {
					"计分牌获得{X:blue,C:white}X#1#{}{C:blue}筹码{}",
					"打出{C:attention}#2#{}张计分牌后{C:red}自毁"
				}
			},
			j_entr_antiderivative = {
				name = "不定积分",
				text = {
					"小丑与牌型的{C:attention}点数{}与{C:attention}花色{}互换",
					"{C:inactive,s:0.8}黑桃、红桃、梅花、方片",
					"{C:inactive,s:0.8}分别视为 A、K、Q、J"
				}
			},
			j_entr_alles = {
				name = "Oops，全是 e！",
				text = {
					"若击败盲注使用{C:attention}超过{}{C:blue}1{}次出牌",
					"回合结束时获得{C:money}$#1#{}"
				}
			},
			j_entr_verbophobia = {
				name = "动词恐惧",
				text = {
					"每回合第一个≤5 字母的单词",
					"必定被计为{C:attention}有效单词"
				}
			},
			j_entr_feynman_point = {
				name = "费曼点",
				text = {
					"小丑小数位",
					"向上取整到{X:dark_edition,C:white}#1#{}",
					"每次概率{C:green}成功{}后",
					"再增加{X:dark_edition,C:white}#2#{}"
				}
			},
			j_entr_neuroplasticity = {
				name = "神经可塑性",
				text = {
					"牌型在计算时",
					"视为{C:attention}随机{}的牌型",
					"{C:attention}每回合{}牌型变化"
				}
			},
			j_entr_dragonfruit = {
				name = "火龙果",
				text = {
					"{C:attention}+#1#{}选择上限",
					"每次出牌",
					"{C:attention}-#2#{}选择上限"
				}
			},
			j_entr_prismatikos = {
				name = "棱镜",
				text = {
					"触发时随机选择效果",
					"{X:chips,C:white}???{}筹码，{X:mult,C:white}???{}倍率，{X:money,C:white}???{}升阶强度",
					"{X:money,C:white}???{}金钱，{X:blue,C:white}???{}出牌",
					"生成{C:attention}2{}张扭曲牌，打出牌获得随机{C:dark_edition}版本{}",
					"{X:attention,C:white}X0.9{}盲注需求……"
				}
			},
			j_entr_jestradiol = {
				name = "雌二醇小丑",
				text = {
					"使用该小丑可将最多{C:attention}#1#{}张选中牌",
					"变为{C:attention}Q{}",
					"击败Boss盲注后增加{C:attention}#2#{}次使用",
					"{C:inactive}(当前为{C:attention}#1#{}{C:inactive}次)"
				}
			},
			j_entr_penny = {
				name = "丢失的便士",
				text = {
					"{C:blue}+#1#{}筹码",
					"击败Boss盲注后",
					"{C:dark_edition}翻倍{}"
				}
			},
			j_entr_slothful_joker = {
				name = "懒惰小丑",
				text = {
					"打出的{C:purple}无色牌{}计分时",
					"{C:mult}+#1#{}倍率"
				}
			},
			j_entr_radar = {
				name = "雷达",
				text = {
					"回合结束时，每有一种牌型",
					"被打出超过{C:attention}5{}次",
					"获得{C:money}$#1#{}",
					"{C:inactive}(当前为{C:money}$#2#{}{C:inactive})"
				}
			},
			j_entr_abacus = {
				name = "算盘",
				text = {
					"数字牌在计分时",
					"提供其{C:blue}基础筹码{}",
					"一半的{C:red}倍率{}"
				}
			},
			j_entr_matryoshka_dolls = {
				name = "套娃",
				text = {
					"{C:red}+#1#{}倍率",
					"选择盲注时复制自身",
					"复制体倍率{C:red}-1{}",
					"{C:inactive}(必须有空间)"
				}
			},
			j_entr_menger_sponge = {
				name = "门格海绵",
				text = {
					"{C:blue}+#1#{}筹码",
					"回合结束时乘以{X:attention,C:white}X#2#{}",
					"击败Boss盲注后重置"
				}
			},
			j_entr_arbitration = {
				name = "仲裁",
				text = {
					"摧毁一张{C:attention}玻璃牌{}时",
					"生成一张{C:attention}审判{}",
					"{C:inactive}(必须有空间)"
				}
			},
			j_entr_masterful_gambit = {
				name = "神之一手",
				text = {
					"仅打出一张牌时",
					"获得{C:money}$#1#{}"
				}
			},
			j_entr_fourty_benadryls = {
				name = "四十片苯海拉明",
				text = {
					"{C:blue}+#1#{}筹码",
					"每底注增加一次",
					"{C:inactive}(当前为{C:blue}#2#{}{C:inactive}筹码)"
				}
			},
			j_entr_red_fourty = {
				name = "RED-40",
				text = {
					"{C:red}+#1#{}倍率",
					"在商店购入卡牌时",
					"{C:red}-#2#{}倍率"
				}
			},
			j_entr_promotion = {
				name = "晋升",
				text = {
					"击败Boss盲注时",
					"在消耗槽生成",
					"一个随机{C:attention}补充包{}",
					"{C:inactive}(必须有空间)"
				}
			},
			j_entr_offbrand = {
				name = "山寨品",
				text = {
					"{C:red}-#1#{}倍率",
					"回合结束时",
					"获得{C:money}$#2#{}"
				}
			},
			j_entr_girldinner = {
				name = "少女的正餐",
				text = {
					"每回合第一张已计分{C:attention}Q{}",
					"给予{C:mult}+#1#{}倍率",
					"与{C:blue}+#2#{}筹码"
				}
			},
			j_entr_recycling_bin = {
				name = "回收箱",
				text = {
					"每弃掉一张牌",
					"该小丑{C:red}+#1#{}倍率",
					"回合结束时重置",
					"{C:inactive}(当前为{C:red}#2#{}{C:inactive}倍率)"
				}
			},
			j_entr_gold_bar = {
				name = "金条",
				text = {
					"回合结束时获得{C:money}$#1#{}",
					"被触发后减少{C:red}$#2#{}"
				}
			},
			j_entr_scribbled_joker = {
				name = "涂鸦小丑",
				text = {
					"{C:blue}+#1#{}筹码",
					"若打出牌中含",
					"{C:attention}增强{}牌"
				}
			},
			j_entr_jokers_against_humanity = {
				name = "反人类小丑",
				text = {
					"每次出牌的第一张计分牌",
					"变为{C:attention}永恒{}",
					"已计分{C:attention}永恒{}牌给予",
					"{C:blue}+#1#{}筹码与{C:red}+#2#{}倍率"
				}
			},
			j_entr_desert = {
				name = "沙漠",
				text = {
					"仅打出{C:attention}1{}张牌时",
					"该小丑获得{C:gold}+#1#{}升阶强度",
					"{C:inactive}(当前为{C:gold}#2#{}{C:inactive}升阶强度)"
				}
			},
			j_entr_rugpull = {
				name = "抽地毯",
				text = {
					"不获得任何奖金",
					"将奖金数额的{X:attention,C:white}X#1#{}",
					"加至该小丑的{C:attention}出售价格{}"
				}
			},
			j_entr_grape_juice = {
				name = "葡萄汁",
				text = {
					"使用该小丑可将手牌中",
					"一张随机牌变为{C:attention}奖励{}、{C:attention}倍率{}或{C:attention}万能{}",
					"击败Boss盲注后获得{C:attention}#2#{}使用次数",
					"{C:inactive}(当前为{C:attention}#1#{}{C:inactive}次)"
				}
			},
			j_entr_petrichor = {
				name = "雨后气息",
				text = {
					"打出的未计分牌",
					"给予{C:blue}+#1#{}筹码"
				}
			},
			j_entr_blind_collectible_pack = {
				name = "盲注收藏包",
				text = {
					"出售该牌可生成",
					"一张免费{C:attention}盲注代币{}",
					"{C:inactive}(必须有空间)"
				}
			},
			j_entr_prayer_card = {
				name = "祈祷卡",
				text = {
					"每级底注当前盲注需求得分{C:attention}-#1#{}",
					"{C:inactive}(当前为{C:attention}#2#{}{C:inactive})"
				}
			},
			j_entr_otherworldly_joker = {
				name = "异界小丑",
				text = {
					"跳过任何{C:attention}补充包{}时",
					"生成一张{C:red}扭曲{}牌",
					"{C:inactive}(必须有空间)"
				}
			},
			j_entr_error = {
				name = "谬误",
				text = {
					"计算效果被",
					"轻微{C:attention}偏移{}",
					"{C:inactive,S:0.8}(例：{C:blue}+30{C:inactive}筹码 或{X:red,C:white}X2{C:inactive}倍率)"
				}
			},
			j_entr_thirteen_of_stars = {
				name = "星星13",
				text = {
					"提供打出牌型{C:purple}等级{}{C:attention}1/4{}",
					"的{C:gold}升阶强度{}"
				}
			},
			j_entr_diode_red = {
				name = "发光二极管(红)",
				text = {
					"{C:red}+#1#{}倍率",
					"{C:inactive,S:0.8}出牌后切换"
				}
			},
			j_entr_diode_blue = {
				name = "发光二极管(蓝)",
				text = {
					"{C:blue}+#1#{}筹码",
					"{C:inactive,S:0.8}出牌后切换"
				}
			},
			j_entr_prismatic_shard = {
				name = "棱光碎片",
				text = {
					"手牌计分时随机给予",
					"{C:mult}+#1#{}倍率，",
					"{C:blue}+#2#{}筹码，或",
					"{C:gold}+#3#{}升阶强度"
				}
			},
			j_entr_chameleon = {
				name = "变色龙",
				text = {
					"作为随机{C:attention}增强{}计分"
				},
			},
			j_entr_thanatophobia = {
				name = "死亡恐惧症",
				text = {
					"提供所有被出售或摧毁的{C:attention}小丑{}的",
					"{C:attention}售价{}的一半的倍率",
					"{C:inactive}(当前:{C:mult}+#1#{C:inactive})"
				},
			},
			j_entr_redkey = {
				name = "红钥匙",
				text = {
					"使用这个小丑以添加一个{C:attention}额外的{}",
					"{C:red}红隐藏房{}盲注",
					"击败Boss盲注后获得{C:attention}#2#{}使用次数",
					"{C:inactive}(当前{C:attention}#1#{C:inactive}次)"
				},
			},
			j_entr_polaroid = {
				name = "拍立得",
				text = {
					"使用这个小丑以复制另一张{C:attention}小丑{}的能力",
					"效果持续到下一次使用",
					"击败Boss盲注后获得{C:attention}#2#{}使用次数",
					"{C:inactive}(当前{C:attention}#1#{C:inactive}次)"
				},
			},
			j_entr_car_battery = {
				name = "车载电池",
				text = {
					"可使用的{C:attention}小丑{}和{C:attention}消耗牌{}",
					"在击败Boss盲注后",
					"额外获得{C:attention}#1#{}使用次数",
				},
			},
			j_entr_chair = {
				name = "椅子",
				text = {
					"打出的牌型为{C:attention}三条{}时",
					"为{C:attention}第三章{}计分的牌",
					"施加{C:attention}怪异{}"
				},
			},
			j_entr_captcha = {
				name = "人丑验证",
				text = {
					"使用这张小丑",
					"随机将{C:attention}小丑{},{C:attention}消耗牌{},{C:attention}补充包{}或{C:attention}优惠券{}",
					"作为增强施加于一张{C:attention}随机{}手牌",
					"击败Boss盲注后获得{C:attention}#2#{}使用次数",
					"{C:inactive}(当前{C:attention}#1#{C:inactive}次)"
				},
			},
			j_entr_deck_enlargement_pills = {
				name = "牌裤增大丸",
				text = {
					"{C:attention}#1#{}{C:inactive}[#2#]{}回合后",
					"卖掉这张小丑",
					"以{C:attention}获得{}一个随机的{C:attention}牌组{}效果"
				},
			},
			j_entr_photocopy = {
				name = "复印件",
				text = {
					"{C:attention}标准包{}中的第一张牌",
					"始终包含你最常使用的",
					"{C:attention}花色{}和{C:attention}点数{}"
				},
			},
			j_entr_hexa = {
				name = "六重低温·光线魔女",
				text = {
					"额外打出的牌给予",
					"{C:gold}+3{}升阶强度",
					"{C:attention}+3{}选择上限"
				},
			},
			j_entr_hexa_cryptid = {
				name = "六重低温·思维骑士",
				text = {
					"额外打出的牌给予",
					"升阶强度{X:gold,C:white}X3{}",
					"{C:attention}+#1#{}选择上限"
				},
			},
			j_entr_grahkon = {
				name = "原初守卫·格拉龚",
				text = {
					"{C:attention}-#1#{}盲注需求得分",
					"一张卡牌被摧毁时，该数值提高{X:attention,C:white}X#2#{}",
					"使用这张小丑将摧毁{C:attention}#3#{}张随机手牌",
					"击败Boss盲注后获得{C:attention}#2#{}使用次数",
					"{C:inactive}(当前{C:attention}#1#{C:inactive}次)"
				},
			},
			j_entr_ybur = {
				name = "比露",
				text = {
					"每底注下，若未跳过盲注",
					"可免于死亡一次",
					"触发该效果时",
					"这张小丑获得{X:dark_edition,C:white}^#2#{}筹码",
					"{C:inactive}(当前:{X:dark_edition,C:white}^#1#{C:inactive}筹码)"
				},
			},
			j_entr_zelavi = {
				name = "泽莱瓦伊",
				text = {
					"打开{C:spectral}幻灵包{}时",
					"这张小丑获得{X:blue,C:white}X#2#{}筹码",
					"商店始终包含一个{C:spectral}超级幻灵包{}",
					"{C:inactive}(当前:{X:blue,C:white}X#1#{C:inactive}筹码)"
				},
			},
			j_entr_ssac = {
				name = "兹诺斯卡",
				text = {
					"牌组中每缺少两个基础点数",
					"{C:attention}强制触发{}最左侧的",
					"{C:attention}小丑{},{C:attention}卡牌{}, 以及{C:attention}消耗牌{}",
					"{C:inactive}(当前:{C:attention}#1#{C:inactive})"
				},
			},
			j_entr_subarc = {
				name = "斯布奎",
				text = {
					"{C:attention}重新触发{}的卡牌的版本",
					"将升级到{C:attention}晴朗{}以及{C:attention}太阳{}",
					"重新触发的{C:attention}太阳{}卡牌获得",
					"{X:gold,C:white}X#1#{}升阶强度"
				},
			},
			j_entr_axeh = {
				name = "温低重六",
				text = {
					"获得时",
					"创造一张{C:attention}晴朗小丑{}",
					"使所有来源的升阶强度",
					"获得{X:gold,C:white}X#1#{}",
				},
			},
			j_entr_nokharg = {
				name = "龚拉格",
				text = {
					"使用这张小丑",
					"将选择的卡牌变为{C:dark_edition}负片{}",
					"每选择一张卡牌",
					"底注需求得分将上升{C:attention}#2#{}",
					"{C:inactive}(当前{X:attention,C:white}X#1#{C:inactive}底注需求得分)"
				},
			},

			j_entr_enlightenment = {
				name = "启蒙",
				text = {
					"允许{C:attention}愚者{}生成",
					"任何{C:red}非反转{}或{C:red}隐藏{}的消耗牌和补充包",
					"允许{C:red}主宰{}生成",
					"{C:red}扭曲包{}"
				},
			},
			j_entr_black_rose_green_sun = {
				name = "黑玫瑰，绿太阳",
				text = {
					"手中的{C:spades}黑桃{}和{C:clubs}梅花{}",
					"给予{C:gold}+#1#{}升阶强度"
				},
			},

			j_entr_heimartai = {
				name = "命定",
				text = {
					"概率将不断{C:attention}重新触发{}",
					"直至{C:green}成功{}",
					"获得等于{C:attention}重随次数{}除以{C:green}概率分母{}",
					"的{X:dark_edition,C:white}^筹码{}",
					"{C:inactive}(当前:{X:dark_edition,C:white}^#1#{C:inactive}筹码)"
				},
			},
			j_entr_jack_off = {
				name = "撸牌",
				text = {
					"{C:attention}J{}得分时",
					"弃掉一张{C:attention}随机{}手牌",
				},
			},
			j_entr_fast_food = {
				name = "快餐",
				text = {
					"选择{C:attention}盲注{}时",
					"创造一张{C:attention}易腐 食物{}小丑",
					"{C:inactive}(必须有空间)"
				},
			},
			j_entr_antipattern = {
				name = "反面模式",
				text = {
					"每打出过一种{C:attention}独特牌型{}",
					"这张小丑获得{X:blue,C:white}X#1#{}筹码",
					"{C:inactive}(当前:{X:blue,C:white}X#2#{C:inactive}筹码)"
				},
			},
			j_entr_spiral_of_ants = {
				name = "蚂蚁螺旋",
				text = {
					"每当{C:attention}连续的{}出牌数{C:attention}少于{}上一次时",
					"这张小丑获得{C:blue}+#1#{}筹码",
					"{C:inactive}(当前:{C:blue}+#2#{C:inactive}筹码)"
				},
			},
			j_entr_fork_bomb = {
				name = "Fork 炸弹",
				text = {
					"选择盲注时",
					"创造该小丑的{C:attention}复制{}",
					"When{C:attention}Blind{}is selected",
					"Create a{C:attention}copy{}of this Joker",
					"{C:inactive}(最多16张，不需要空间)"
				},
			},
			j_entr_solar_panel = {
				name = "太阳能板",
				text = {
					"弃掉{C:attention}晴朗{}或{C:attention}日耀{}卡牌时",
					"获得{C:money}$#1#{}"
				},
			},
			j_entr_kintsugi = {
				name = "金继",
				text = {
					"{C:attention}陶瓷牌{}不再自毁",
					"而是转变为{C:attention}黄金牌{}",
				},
			},
			j_entr_blooming_crimson = {
				name = "绯色花",
				text = {
					"卡牌计分时给予",
					"{X:mult,C:white}X#1#{}倍率,",
					"{X:blue,C:white}X#2#{}筹码,",
					"或{X:gold,C:white}X#3#{}升阶强度"
				},
			},
			j_entr_overpump = {
				name = "炸膛",
				text = {
					"本回合{C:attention}最后一次出牌{}时",
					"获得{X:mult,C:white}X#1#{}Mult",
					"本回合打出过一种{C:attention}独特牌型{}",
					"增加{X:mult,C:white}X#2#{}",
				},
			},
			j_entr_shadow_crystal = {
				name = "暗影晶体",
				text = {
					"消耗牌有{C:green}#1#/#2#{}的几率",
					"同时触发其{C:red}反转版本{}的效果",
					"{C:inactive}(若可能, 消耗牌除外)"
				},
			},
			j_entr_miracle_berry = {
				name = "奇迹果",
				text = {
					"接下来出现的{C:attention}#1#{}个消耗牌",
					"将变为{C:spectral}幻灵牌{}",
				},
			},
			j_entr_meridian = {
				name = "子午线",
				text = {
					"给予取决于小丑牌",
					"{C:attention}当前位置{}的倍率",
					"{C:inactive}(当前{C:mult}+#1#{C:inactive}倍率)"
				},
			},
			j_entr_mango = {
				name = "芒果",
				text = {
					"复制接下来{C:attention}#1#{}手打出的牌",
					"中的{C:attention}第一张{}牌",
					"并将其放入{C:attention}手牌{}中"
				},
			},
			j_entr_kitchenjokers = {
				name = "厨房小丑",
				text = {
					"食物小丑{C:attention}更容易{}出现",
					"且更贵{C:attention}X#1#{}",
					"且拥有{C:dark_edition}低分辨率{}"
				},
			},
			j_entr_hash_miner = {
				name = "挖矿程序",
				text = {
					"每次的出牌有{C:green}#1#/#2#{}被腐化",
					"被腐化的牌有{C:green}#3#/#4#{}的概率恢复",
					"回合结束时，手中每有一张被腐化的牌",
					"获得{C:money}$#5#{}售价"
				},
			},
			j_entr_dice_shard = {
				name = "骰子碎片",
				text = {
					"使用这张小丑",
					"将一张选中的{C:attention}小丑{}",
					"转化为收藏中的上一个小丑",
					"击败Boss盲注后获得{C:attention}#2#{}使用次数",
					"{C:inactive}(当前{C:attention}#1#{C:inactive}次)"
				},
			},
			j_entr_bell_curve = {
				name = "正态分布曲线",
				text = {
					"重新触发打出的",
					"所有除了{C:attention}第一张{}和{C:attention}最后一张",
					"的卡牌"
				},
			},
			j_entr_pineapple = {
				name = "菠萝",
				text = {
					"接下来的{C:attention}#1#{}回合结束时",
					"使{C:attention}整套牌组{}中的随机一张牌",
					"获得{C:attention}永久{}重新触发"
				},
			},
			j_entr_rubber_ball = {
				name = "橡皮球",
				text = {
					"每张卡牌计分时",
					"有{C:green}#1#/#2#{}几率重新触发",
					"并{C:red}反转{}计分{C:attention}顺序{}"
				},
			},
			j_entr_stand_arrow = {
				name = "替身箭矢",
				text = {
					"使用这张小丑",
					"有{C:green}#3#/#4#{}几率{C:red}摧毁{}选中的小丑",
					"否则为其施加{C:dark_edition}多彩{}、{C:dark_edition}负片{}、",
					"{C:dark_edition}晴朗{}、{C:dark_edition}太阳{}、{C:dark_edition}破碎{}或{C:dark_edition}怪异{}",
					"击败Boss盲注后获得{C:attention}#2#{}使用次数",
					"{C:inactive}(当前{C:attention}#1#{C:inactive}次)"
				},
			},
			j_entr_dancer = {
				name = "舞者",
				text = {
					"{C:attention}+#1#{}选择上限",
					"{C:red}#2#{}弃牌次数"
				},
			},
			j_entr_kings_scepter = {
				name = "王之权杖",
				text = {
					"摧毁打出的{C:attention}所有{}",
					"{C:attention}被削弱{}的牌"
				},
			},
			j_entr_monkeys_paw = {
				name = "猴爪",
				text = {
					"使用这张小丑创造",
					"一个随机的{C:attention}永恒{}{C:red}契约{}",
					"{C:inactive}(当前{C:attention}#1#{C:inactive}次)"
				},
			},
			j_entr_magic_skin = {
				name = "玄奇驴皮",
				text = {
					"使用这张小丑，基于{C:attention}当前{}打开的补充包",
					"创造{C:attention}#3#{}张{C:dark_edition}负片{}牌",
					"击败Boss盲注后获得{C:attention}#4#{}使用次数",
					"{C:inactive,s:0.8}每次使用后有更高的机率出现在本局之后的游戏中",
					"{C:inactive}(当前{C:attention}#2#{},{C:attention}#1#{C:inactive}次)"
				},
			},
			j_entr_lambda_calculus = {
				name = "λ-演算",
				text = {
					"每当另一张小丑{C:attention}触发{}时",
					"将其{C:attention}售价{}加至本小丑的{C:blue}筹码{}",
					"这张小丑触发时{C:red}重置{}",
					"{C:inactive}(当前{C:blue}+#1#{C:inactive}筹码)"
				},
			},
			j_entr_elderberries = {
				name = "接骨木莓",
				text = {
					"被卖出时",
					"强制使用{C:attention}#1#{}张",
					"{C:spectral}幻灵{}牌",
				},
			},
			j_entr_nostalgic_d6 = {
				name = "怀旧D6",
				text = {
					"使用这张小丑，花费{C:money}$#1#{}",
					"{C:attention}重随{}当前补充包",
					"的全部内容"
				},
			},
			j_entr_blood_orange = {
				name = "血橙",
				text = {
					"接下来摧毁的{C:attention}#1#{}张手牌",
					"创造一张{C:red}反转{}消耗牌",
					"{C:inactive}(必须有空间)"
				},
			},
			j_entr_false_vacuum_collapse = {
				name = "伪真空衰变",
				text = {
					"这张小丑作为{C:attention}第一张{}牌打出",
					"计分时{C:red}摧毁{}打出的{C:attention}第二张{}牌",
					"然后返回"
				},
			},
			j_entr_mark_of_the_beast = {
				name = "野兽之印",
				text = {
					"每个商店包含一个",
					"{C:red}巨型扭曲包{}",
					"代价是{C:attention}整套牌组{}",
					"中的{C:attention}一{}张随机卡牌"
				},
			},
		},
		mtx = {
			c_entr_generousdonation = {
				name = "慷慨捐赠"
			},
			c_entr_moneybundle = {
				name = "美元捆"
			},
			c_entr_deckfix = {
				name = "牌组修复"
			},
			c_entr_biggerpockets = {
				name = "加大口袋"
			},
			c_entr_extrahands = {
				name = "额外手牌次数"
			},
			c_entr_extrajoker = {
				name = "额外小丑牌槽位"
			},
			c_entr_unstick = {
				name = "解除粘连"
			}
		},
		Blind = {
			bl_entr_void = {
				name = "???",
				text = {
					"???"
				}
			},
			bl_entr_red = {
				name = "红隐藏房",
				text = {
					"???"
				}
			},
			bl_entr_scarlet_sun = {
				name = "猩红太阳",
				text = {
					"所有牌增加升阶强度",
					"-1X 升阶强度"
				}
			},
			bl_entr_burgundy_baracuda = {
				name = "酒红梭鱼",
				text = {
					"1/2 概率摧毁打出牌"
				}
			},
			bl_entr_diamond_dawn = {
				name = "钻石黎明",
				text = {
					"弃牌时移除其点数与花色"
				}
			},
			bl_entr_olive_orchard = {
				name = "橄榄树园",
				text = {
					"打出手牌或弃牌时",
					"剩余手牌变为{C:red}否定牌{}"
				}
			},
			bl_entr_citrine_comet = {
				name = "黄玉彗星",
				text = {
					"选中手牌时 1/2 概率",
					"摧毁相邻牌"
				}
			},
			bl_entr_endless_entropy_phase_one = {
				name = "硫火炼狱",
				text = {
					"???"
				}
			},
			bl_entr_endless_entropy_phase_two = {
				name = "欺骗衰变",
				text = {
					"你所知的一切都将崩塌，",
					"归于尘土。",
					"(小丑数值随时间衰减)"
				}
			},
			bl_entr_endless_entropy_phase_three = {
				name = "无名天底",
				text = {
					"虚空吞噬你，",
					"(最左侧小丑槽被削弱，",
					"你必将输掉此盲注。)"
				}
			},
			bl_entr_endless_entropy_phase_four = {
				name = "无尽之熵",
				text = {
					"在宇宙面前你不过一粒尘埃。",
					"(熵永无尽头)"
				}
			},
			bl_entr_alabaster_anchor = {
				name = "雪花石锚",
				text = {
					"出牌、弃牌、选中/取消手牌",
					"均使小丑数值暂时-5%"
				}
			},
			--alt blinds
			bl_entr_alpha = {
				name = "阿尔法",
				text = {
					"每手牌第一张计分牌被摧毁"
				}
			},
			bl_entr_beta = {
				name = "贝塔",
				text = {
					"-1 手牌上限",
					"每次出牌再-1"
				}
			},
			bl_entr_gamma = {
				name = "伽马",
				text = {
					"根据未打出花色数量",
					"降低基础倍率"
				}
			},
			bl_entr_delta = {
				name = "德尔塔",
				text = {
					"根据本盲注已打手牌数",
					"降低最终倍率"
				}
			},
			bl_entr_epsilon = {
				name = "艾普西隆",
				text = {
					"根据已打出牌数量",
					"降低最终倍率"
				}
			},
			bl_entr_zeta = {
				name = "泽塔",
				text = {
					"手牌数不得为 3 或 5 张"
				}
			},
			bl_entr_eta = {
				name = "伊塔",
				text = {
					"#1# 张牌被削弱",
					"每次出牌后变化"
				}
			},
			bl_entr_theta = {
				name = "西塔",
				text = {
					"倍率运算现在",
					"作用于筹码"
				}
			},
			bl_entr_iota = {
				name = "约塔",
				text = {
					"应用 #1# 的效果",
					"每打出一手牌后变化"
				}
			},
			bl_entr_kappa = {
				name = "卡帕",
				text = {
					"计分牌不计分",
					"未计分牌反而计分"
				}
			},
			bl_entr_lambda = {
				name = "兰姆达",
				text = {
					"手牌计分时被削弱 5 回合"
				}
			},
			bl_entr_mu = {
				name = "缪",
				text = {
					"选中牌点数之和",
					"不得超过 30"
				}
			},
			bl_entr_nu = {
				name = "纽",
				text = {
					"每次卡牌被触发",
					"利息 ×0.8"
				}
			},
			bl_entr_xi = {
				name = "克西",
				text = {
					"第一次弃牌",
					"变为永恒"
				}
			},
			bl_entr_omicron = {
				name = "奥米克戎",
				text = {
					"打出的第一手牌",
					"不计分"
				}
			},
			bl_entr_pi = {
				name = "派",
				text = {
					"弃掉的牌",
					"返回牌组"
				}
			},
			bl_entr_rho = {
				name = "柔",
				text = {
					"根据已打出点数种类",
					"降低最终倍率"
				}
			},
			bl_entr_sigma = {
				name = "西格玛",
				text = {
					"出牌与弃牌",
					"共享次数"
				}
			},
			bl_entr_tau = {
				name = "陶",
				text = {
					"+1 选择上限",
					"弃牌时 -1 选择上限"
				}
			},
			bl_entr_upsilon = {
				name = "宇普西隆",
				text = {
					"计分的牌型",
					"-0.25 升阶强度"
				}
			},
			bl_entr_phi = {
				name = "斐",
				text = {
					"非 A、3、6、8、9 的点数",
					"均被削弱"
				}
			},
			bl_entr_chi = {
				name = "希",
				text = {
					"每种点数的第一张手牌计分时",
					"被削弱"
				}
			},
			bl_entr_psi = {
				name = "普西",
				text = {
					"手牌计分时 1/2 概率",
					"变为否认牌"
				}
			},
			bl_entr_omega = {
				name = "欧米伽",
				text = {
					"打出 #1#",
					"盲注需求",
					"翻倍"
				}
			},
			bl_entr_styx = {
				name = "悲伤冥河",
				text = {
					"小丑与扑克牌",
					"不可移动",
					"计分前可移动 1 张小丑与 1 张扑克牌"
				}
			},
			bl_entr_choir = {
				name = "无情合唱",
				text = {
					"已触发的小丑",
					"本回合被削弱"
				}
			},
			bl_entr_pandora = {
				name = "无暇潘多拉",
				text = {
					"抽牌时 #1#/3 概率",
					"改为抽一张",
					"随机临时牌"
				}
			},
			bl_entr_cassandra = {
				name = "被诅咒的卡珊德拉",
				text = {
					"弃牌返回牌组",
					"计分前 #1#/5 概率",
					"随机削弱一张小丑"
				}
			},
			bl_entr_labyrinth = {
				name = "无限迷宫",
				text = {
					"+3 手牌上限，+1 选择上限",
					"已选中牌不可取消",
					"选中一张牌时随机再选中一张"
				}
			}
		},
		Edition = {
			e_entr_solar = {
				name = "太阳",
				text = {
					"{X:gold,C:white}X#1#{}升阶强度"
				}
			},
			e_entr_fractured = {
				name = "碎裂",
				text = {
					"计分时{C:dark_edition}强制触发{}#1# 张",
					"随机卡牌"
				}
			},
			e_entr_sunny = {
				name = "晴朗",
				text = {
					"{C:gold}+#1#{}升阶强度",
					"听过{C:attention}升阶{}笑话吗？"
				}
			},
			e_entr_freaky = {
				name = "怪异",
				text = {
					"筹码{X:entr_freaky,C:white}Xlog_#1#(筹码){}"
				}
			},
			e_entr_neon = {
				name = "霓虹",
				text = {
					"商店价格{C:attention}X#1#{}"
				}
			},
			e_entr_lowres = {
				name = "低分辨率",
				text = {
					"该牌{C:attention}重新触发 #1#{}次",
					"卡牌数值{C:attention}X#2#{}{C:inactive}(若可行)"
				}
			},
			e_entr_kaleidoscopic = {
				name = "万花筒",
				text = {
					"随机重新触发",
					"该牌所在区域的{C:attention}#1#{}张牌"
				}
			}
		},
		Back = {
			b_entr_twisted = {
				name = "扭曲牌组",
				text = {
					"所有{C:red}可反转{}消耗牌",
					"自动{C:red}反转"
				}
			},
			b_entr_ccd2 = {
				name = "重定义牌组",
				text = {
					"每张牌同时也是随机",
					"{C:attention}小丑{}、{C:attention}补充包{}、",
					"{C:attention}优惠券{}或{C:attention}消耗牌{}"
				}
			},
			b_entr_doc = {
				name = "收容牌组",
				text = {
					"打出带版本/增强牌、隐藏牌型",
					"或使用消耗牌时获得{X:dark_edition,C:white}熵值{}",
					"{C:entr_entropic}超凡入圣{}、{C:cry_exotic}真理之门{}",
					"与{C:spectral}幻灵包{}出现更多",
					"筹码随{X:dark_edition,C:white}熵值{}降低"
				}
			},
			b_entr_crafting = {
				name = "命运牌组",
				text = {
					"小丑不再自然出现",
					"开局获得{C:dark_edition}阿列夫·负片{}命运",
					"卡牌更高概率被增强"
				}
			},
			b_entr_butterfly = {
				name = "蝴蝶牌组",
				text = {
					"{C:attention}-2{}小丑栏位",
					"已出售小丑仍有{C:green}1/2{}概率触发"
				}
			},
			b_entr_ambisinister = {
				name = "双手笨拙牌组",
				text = {
					"{C:attention}小丑栏位{}与",
					"{C:dark_edition}选择上限{}共享",
					"{C:attention}+3{}小丑栏位"
				}
			},
			b_entr_gemstone = {
				name = "宝石牌组",
				text = {
					"非符文消耗牌{C:green}1/3{}概率",
					"使用{C:red}失败{}，每用 2 张",
					"生成一张随机{C:purple}符文牌{}"
				}
			},
			b_entr_corrupted = {
				name = "腐化牌组",
				text = {
					"{C:attention}小丑{}和{C:attention}消耗牌{}",
					"将在{C:attention}3{}个选项间循环"
				}
			},
		},
		Sleeve = {
			sleeve_entr_twisted = {
				name = "扭曲牌套",
				text = {
					"所有{C:red}可反转{}消耗牌",
					"自动{C:red}反转"
				}
			},
			sleeve_entr_ccd2 = {
				name = "重定义牌套",
				text = {
					"每张牌同时也是随机",
					"{C:attention}小丑{}、{C:attention}补充包{}、",
					"{C:attention}优惠券{}或{C:attention}消耗牌{}"
				}
			},
			sleeve_entr_doc = {
				name = "异常牌套",
				text = {
					"打出带版本/增强牌、隐藏牌型",
					"或使用消耗牌时获得{X:dark_edition,C:white}熵值{}",
					"{C:entr_entropic}超凡入圣{}、{C:cry_exotic}真理之门{}",
					"与{C:spectral}幻灵包{}出现更多",
					"筹码随{X:dark_edition,C:white}熵值{}降低"
				}
			},
			sleeve_entr_ambisinister = {
				name = "双手笨拙牌套",
				text = {
					"{C:attention}小丑栏位{}与",
					"{C:dark_edition}选择上限{}共享",
					"{C:attention}+3{}小丑栏位"
				}
			},
			sleeve_entr_crafting = {
				name = "命运牌套",
				text = {
					"小丑不再自然出现",
					"开局获得{C:dark_edition}阿列夫·负片{}命运",
					"卡牌更高概率被增强"
				}
			},
			sleeve_entr_butterfly = {
				name = "蝴蝶牌套",
				text = {
					"{C:attention}-2{}小丑栏位",
					"已出售小丑仍有{C:green}1/2{}概率触发"
				}
			},
			sleeve_entr_gemstone = {
				name = "宝石牌套",
				text = {
					"非符文消耗牌{C:green}1/3{}概率",
					"使用{C:red}失败{}，每用 2 张",
					"生成一张随机{C:purple}符文牌{}"
				}
			},
			sleeve_entr_corrupted = {
				name = "腐化牌套",
				text = {
					"{C:attention}小丑{}和{C:attention}消耗牌{}",
					"将在{C:attention}2{}个选项间循环"
				}
			},
		},
		Fraud = {
			c_entr_master = {
				name = "主宰",
				text = {
					"生成本局",
					"最近一次使用的{C:red}反转{}牌",
					"{s:0.8,C:red}主宰{s:0.8}自身除外"
				}
			},
			c_entr_statue = {
				name = "雕像",
				text = {
					"将牌组中随机{C:attention}#1#{}张牌",
					"变为{C:attention}#2#{}张所选牌",
					"再将所选牌变为空白{C:attention}石头牌{}"
				}
			},
			c_entr_feast = {
				name = "盛宴",
				text = {
					"{C:attention}出售{}并{C:attention}摧毁{}",
					"商店中最多{C:attention}#1#{}张",
					"选中的卡牌"
				}
			},
			c_entr_servant = {
				name = "仆从",
				text = {
					"创建{C:attention}#1#{}张随机{C:red}反转{}",
					"类型与{C:attention}#2#{}张选中卡牌",
					"相同的消耗牌",
					"{C:inactive}(必须有空间){}"
				}
			},
			c_entr_endurance = {
				name = "坚忍",
				text = {
					"将{C:attention}#1#{}张选中卡牌的数值",
					"乘以{C:attention}#2#{}，随后",
					"削弱{C:attention}#3#{}回合"
				}
			},
			c_entr_scar = {
				name = "伤痕",
				text = {
					"为手牌中最多{C:attention}#1#{}张",
					"选中卡牌添加",
					"{C:dark_edition}疤痕{}贴纸"
				}
			},
			c_entr_dagger = {
				name = "匕首",
				text = {
					"摧毁{C:attention}#1#{}张选定游戏牌",
					"并将其筹码的{X:dark_edition,C:white}#2#X{}",
					"添加到你{C:attention}最常用牌型{}的筹码中"
				}
			},
			c_entr_penumbra = {
				name = "半影",
				text = {
					"放逐手牌中{C:attention}#1#{}张",
					"选中卡牌的增强效果",
					"随后{C:attention}摧毁{}该牌"
				}
			},
			c_entr_integrity = {
				name = "完整",
				text = {
					"移除{C:attention}#1#{}张选中牌的",
					"{C:attention}增强{}效果，随后",
					"随机添加{C:dark_edition}蜡封与版本{}"
				}
			},
			c_entr_forgiveness = {
				name = "宽恕",
				text = {
					"创建一张随机的",
					"{C:attention}此前出售过的小丑{}",
					"{C:inactive}(可溢出){}"
				}
			},
			c_entr_feud = {
				name = "世仇",
				text = {
					"选择{C:attention}#1#{}张牌",
					"将右侧的牌的{C:blue}筹码{}",
					"以{X:chips,C:white}X#3#{}倍率加至左侧发牌",
					"随后{C:attention}摧毁{}右侧的牌"
				}
			},
			c_entr_advisor = {
				name = "顾问",
				text = {
					"创建你最常用牌型的",
					"{C:attention}临时示例{}，",
					"并{C:attention}抽入{}手牌"
				}
			},
			c_entr_heretic = {
				name = "异端",
				text = {
					"随机重掷手牌中",
					"最多{C:attention}#1#{}张选中牌的",
					"任意属性或修改"
				}
			},
			c_entr_earl = {
				name = "伯爵",
				text = {
					"下一回合中",
					"剩余的{C:blue}出牌次数{}给予{C:money}$#1#{}",
					"剩余的{C:red}弃牌次数{}给予{C:money}$#2#{}"
				}
			},
			c_entr_mason = {
				name = "石匠",
				text = {
					"创建{C:attention}#1#{}张",
					"带随机{C:dark_edition}版本{}的",
					"{C:attention}石头牌{}"
				}
			},
			c_entr_princess = {
				name = "公主",
				text = {
					"在本底注{C:attention}剩余{}回合内",
					"所有{C:planet}星球牌{}被替换为",
					"{C:purple}恒星牌{}"
				}
			},
			c_entr_imp = {
				name = "小恶魔",
				text = {
					"将{C:attention}#1#{}张选定牌",
					"增强为{C:attention}暗黑{}牌"
				}
			},
			c_entr_oracle = {
				name = "神谕",
				text = {
					"将手牌中{C:attention}#1#{}张随机卡牌",
					"增强为带{C:dark_edition}版本{}的",
					"{C:purple}CCD恒星牌{}"
				}
			},
			c_entr_ocean = {
				name = "海洋",
				text = {
					"{S:0.8}（{S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}）{}提升等级",
					"{C:attention}方片",
					"{C:blue}+#4#{}筹码"
				}
			},
			c_entr_forest = {
				name = "森林",
				text = {
					"{S:0.8}（{S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}）{}提升等级",
					"{C:attention}梅花",
					"{C:blue}+#4#{}筹码"
				}
			},
			c_entr_mountain = {
				name = "山峦",
				text = {
					"{S:0.8}（{S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}）{}提升等级",
					"{C:attention}红桃",
					"{C:blue}+#4#{}筹码"
				}
			},
			c_entr_tent = {
				name = "帐篷",
				text = {
					"{S:0.8}（{S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}）{}提升等级",
					"{C:attention}黑桃",
					"{C:blue}+#4#{}筹码"
				}
			},
			c_entr_companion = {
				name = "伙伴",
				text = {
					"将利息上限提高{C:gold}#1##2#{}",
					"随后根据利息上限获得{C:gold}资金{}"
				}
			},
			c_entr_prophecy = {
				name = "预言",
				text = {
					"接下来的{C:attention}#1#{}张{C:red}反转{}牌",
					"变为上一次使用的",
					"{C:red}欺诈{}牌"
				}
			},
			c_entr_frail = {
				name = "脆弱",
				text = {
					"摧毁选中的{C:attention}#1#{}张牌",
					"将其所拥有的修改",
					"随机{C:attention}分配{}给手牌中{C:attention}其余{}牌"
				}
			},
			c_entr_village = {
				name = "村庄",
				text = {
					"使留在手牌中的牌",
					"获得{C:blue}+#1#{}额外筹码"
				}
			},
			c_entr_mallet = {
				name = "木槌",
				text = {
					"随机摧毁手牌中的{C:attention}#1#{}张牌",
					"并生成{C:attention}#1#{}张随机{C:red}指令{}牌",
					"{C:inactive}（必须有空间）{}"
				}
			},
			c_entr_whetstone = {
				name = "磨刀石",
				text = {
					"{C:green}#1#/#2#{}几率",
					"随机{C:attention}升级{}最多#3#张选定牌的",
					"增强效果"
				}
			},
			c_entr_disturbance = {
				name = "扰动",
				text = {
					"放逐{C:attention}#1#{}张选定牌",
					"而{C:attention}不摧毁{}它们"
				}
			},
			c_entr_inferno = {
				name = "地狱火",
				text = {
					"摧毁{C:attention}所有{}选定牌",
					"超过{C:attention}2{}张后每张牌",
					"损失{C:money}$#1#{}"
				}
			},
			c_entr_muse = {
				name = "缪斯",
				text = {
					"将任意#1#张选定牌",
					"{C:attention}链接在一起{}"
				}
			},
			c_entr_avarice = {
				name = "贪婪",
				text = {
					"立即打开{C:attention}#1#{}个标准包"
				}
			},
			c_entr_imp = {
				name = "小恶魔",
				text = {
					"将{C:attention}#1#{}张选定牌",
					"增强为{C:attention}暗黑{}牌"
				}
			},
			c_entr_ocean = {
				name = "海洋",
				text = {
					"{S:0.8}（{S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}）{}提升等级",
					"{C:attention}方片",
					"{C:blue}+#4#{}筹码"
				}
			},
			c_entr_earl = {
				name = "伯爵",
				text = {
					"下一回合中",
					"剩余的{C:blue}出牌次数{}给予{C:money}$#1#{}",
					"剩余的{C:red}弃牌次数{}给予{C:money}$#2#{}"
				}
			},
			c_entr_desert = {
				name = "沙漠",
				text = {
					"{S:0.8}（{S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}）{}提升等级",
					"{C:attention}鸢尾",
					"{C:blue}+#4#{}筹码"
				}
			},
			c_entr_wastes = {
				name = "荒原",
				text = {
					"{S:0.8}（{S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}）{}提升等级",
					"{C:attention}戟刃",
					"{C:blue}+#4#{}筹码"
				}
			},
			c_entr_garden = {
				name = "花园",
				text = {
					"{C:attention}随机化{} {C:attention}#1#{}张牌的点数和花色",
					"使其全部变为相同的点数与花色"
				}
			},
		},
		Planet = {
			c_entr_wormhole = {
				name = "虫洞",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#2#{S:0.8}){}升级",
					"{C:attention}#1#",
					"{C:mult}+#3#{}倍率与",
					"{C:chips}+#4#{}筹码"
				}
			},
			c_entr_tyche = {
				name = "堤喀",
				text = {
					"随机升级一种牌型，",
					"使其每级额外给予",
					"{C:mult}+#2#{}倍率与",
					"{C:chips}+#1#{}筹码"
				}
			},
			c_entr_theia = {
				name = "忒伊亚",
				text = {
					"升级你等级最高的牌型",
					"使其每级额外给予",
					"{C:mult}+#2#{}倍率与",
					"{C:chips}+#1#{}筹码"
				}
			},
			c_entr_chiron = {
				name = "喀戎",
				text = {
					"随机升级一种牌型，",
					"使其每级额外给予",
					"{C:chips}X#1#{}筹码"
				}
			},
			c_entr_neith = {
				name = "涅伊特",
				text = {
					"随机升级一种牌型，",
					"使其每级额外给予",
					"{C:mult}X#1#{}倍率"
				}
			},
			c_entr_sputnik = {
				name = "斯普特尼克1号",
				text = {
					"随机升级{C:attention}#1#{}种牌型，",
					"{C:mult}+???{}倍率与",
					"{C:chips}+???{}筹码"
				}
			}
		},
		Voucher = {
			v_entr_marked = {
				name = "标记牌",
				text = {
					"{C:red}反转{}消耗牌有",
					"固定{C:red}10%{}概率",
					"替换其常规版本"
				}
			},
			v_entr_trump_card = {
				name = "王牌",
				text = {
					"{C:red}逆转{}可出现在",
					"{C:attention}天体包{}、{C:attention}秘术包{}与",
					"{C:attention}代码包{}中"
				}
			},
			v_entr_supersede = {
				name = "取代",
				text = {
					"{C:red}扭曲{}补充包有",
					"固定{C:red}20%{}概率",
					"替换商店中任何其他补充包"
				}
			},
			v_entr_diviner = {
				name = "占卜师",
				text = {
					"{C:purple}符文{}出现在",
					"补充包中的概率提升"
				}
			},
			v_entr_providence = {
				name = "天佑",
				text = {
					"符文获得",
					"{C:purple,E:1}强化{}效果"
				}
			},
			v_entr_ascension = {
				name = "晋升",
				text = {
					"每回合复制一次",
					"首次使用的{C:purple}符文{}"
				}
			}
		},
		Command = {
			c_entr_memory_leak = {
				name = "(~)$ 内存泄漏",
				text = {
					"{C:red}int *m = new int{}"
				}
			},
			c_entr_root_kit = {
				name = "(~)$ rootkit",
				text = {
					"在下次击败盲注后，",
					"剩余手牌给予{C:red}$#1#{}"
				}
			},
			c_entr_break = {
				name = "(~)$ 中断;",
				text = {
					"返回{C:red}盲注选择{}界面，",
					"当前盲注仍待挑战"
				}
			},
			c_entr_interference = {
				name = "(~)$ 干扰",
				text = {
					"{C:red}随机化{}本回合剩余时间内",
					"的{C:attention}出牌牌型{}、{C:attention}盲注大小{}",
					"与{C:attention}奖励金额{}"
				}
			},
			c_entr_fork = {
				name = "(~)$ 分支",
				text = {
					"创建一张选中扑克牌的",
					"{C:red}故障{}复制，",
					"并赋予随机{C:attention}增强{}"
				}
			},
			c_entr_push = {
				name = "(~)$ push -f",
				text = {
					"{C:red}摧毁{}所有持有的小丑，",
					"根据其{C:red}稀有度{}",
					"创建一张新的小丑"
				}
			},
			c_entr_increment = {
				name = "(~)$ 自增",
				text = {
					"本底注剩余时间内",
					"{C:attention}+1{}商店栏位"
				}
			},
			c_entr_decrement = {
				name = "(~)$ 自减",
				text = {
					"将{C:red}#1#{}张选中{C:attention}小丑{}",
					"转换为收藏中",
					"前一个小丑",
					"{C:inactive}(当前为#2#){}"
				}
			},
			c_entr_cookies = {
				name = "(~)$ cookies",
				text = {
					"创建一张{C:dark_edition}负片{}{C:red}糖果小丑{}"
				}
			},
			c_entr_overflow = {
				name = "(~)$ 溢出",
				text = {
					"本盲注剩余时间内",
					"获得{C:red}无限{}卡牌选择上限"
				}
			},
			c_entr_refactor = {
				name = "(~)$ 重构",
				text = {
					"将一张选中{C:attention}小丑{}的版本",
					"随机应用到另一张",
					"小丑上"
				}
			},
			c_entr_ctrl_x = {
				name = "(~)$ CTRL+X",
				text = {
					"{C:red}#1#{}#2#{C:attention}卡牌{}、",
					"{C:attention}补充包{}或{C:attention}优惠券{}",
					"{C:inactive}(当前为#3#){}"
				}
			},
			c_entr_segfault = {
				name = "(~)$ 段错误",
				text = {
					"创建一张随机扑克牌，",
					"其增强为随机{C:attention}消耗牌{}、",
					"{C:attention}小丑{}、{C:attention}补充包{}或{C:attention}优惠券{}，",
					"并置入牌组"
				}
			},
			c_entr_sudo = {
				name = "(~)$ sudo",
				text = {
					"{C:red}永久{}修改一个选中{C:attention}牌型{}，",
					"使其始终被视为",
					"另一种{C:red}牌型{}"
				}
			},
			c_entr_constant = {
				name = "(~)$ 常量",
				text = {
					"将牌组中所有与选中卡牌",
					"点数相同的牌",
					"转换为该选中卡牌"
				}
			},
			c_entr_new = {
				name = "(~)$ new()",
				text = {
					"在下一个盲注前",
					"额外添加一个{C:red}红隐藏房盲注"
				}
			},
			c_entr_multithread = {
				name = "(~)$ 多线程",
				text = {
					"为手牌中所有{C:red}选中{}卡牌",
					"创建{C:dark_edition}负片{}临时复制"
				}
			},
			c_entr_invariant = {
				name = "(~)$ 不变量",
				text = {
					"为商店中一张选中卡牌",
					"添加{C:red}不变{}贴纸"
				}
			},
			c_entr_inherit = {
				name = "(~)$ 继承",
				text = {
					"将牌组中所有与选中卡牌",
					"{C:red}增强{}相同的牌",
					"转换为自选{C:red}增强"
				}
			},
			c_entr_autostart = {
				name = "(~)$ 自启动",
				text = {
					"获得{C:red}#1#{}个本局此前",
					"已获得过的随机跳过标签"
				}
			},
			c_entr_quickload = {
				name = "(~)$ 快载入",
				text = {
					"{C:red}重新触发{}结算界面，",
					"但{C:red}不获得{}盲注金钱"
				}
			},
			c_entr_hotfix = {
				name = "(~)$ 热更新",
				text = {
					"为一张选中卡牌",
					"添加{C:red}热更新{}贴纸"
				}
			},
			c_entr_pseudorandom = {
				name = "(~)$ 伪随机",
				text = {
					"为屏幕上所有卡牌",
					"添加{C:red}伪随机{}贴纸"
				}
			},
			c_entr_bootstrap = {
				name = "(~)$ 自举",
				text = {
					"这一手牌的最终{C:blue}筹码{}与{C:red}倍率{}",
					"成为下一手牌的",
					"基础{C:blue}筹码{}与{C:red}倍率"
				}
			},
			c_entr_local = {
				name = "(~)$ 局部变量",
				text = {
					"为{C:red}#1#{}张选中扑克牌",
					"添加{C:red}临时{}效果"
				}
			},
			c_entr_transpile = {
				name = "(~)$ 转码",
				text = {
					"{C:dark_edition}+#1#{}小丑栏位，",
					"{C:dark_edition}+#2#{}消耗牌栏位，",
					"{C:dark_edition}+#3#{}手牌上限"
				}
			},
			c_entr_detour = {
				name = "(~)$ 转跳",
				text = {
					"创建一张与最近一次获得的",
					"卡牌/补充包/优惠券",
					"类型对应的{C:attention}卡牌、补充包或优惠券",
					"{C:inactive}(当前为#1#){}"
				}
			},
			c_entr_mbr = {
				name = "(~)$ mbr",
				text = {
					"为当前商店的补充包池",
					"添加一个{C:dark_edition}香蕉优惠券包"
				}
			},
			c_entr_desync = {
				name = "(~)$ 延迟",
				text = {
					"为一张选中{C:attention}小丑{}或消耗牌",
					"添加{C:red}延迟{}贴纸"
				}
			},
			c_entr_badarg = {
				name = "(~)$ 非法参数*",
				text = {
					"{C:red}阻止{}一个选中{C:attention}牌型{}",
					"在本局剩余时间内",
					"计分或消耗手牌"
				}
			},
			c_entr_interpolate = {
				name = "(~)$ 插值",
				text = {
					"选择并{C:red}摧毁{}#1#张{C:attention}小丑{}",
					"或{C:attention}消耗牌{}，",
					"本卡可能出现在未来的",
					"{C:red}扭曲{}或{C:cry_code}程序{}包中"
				}
			},
			c_entr_overload = {
				name = "(~)$ 过载",
				text = {
					"下一手打出的牌",
					"被视为包含",
					"所有其他牌型"
				}
			},
			c_entr_echo = {
				name = "(~)$ 回显",
				text = {
					"选择两张消耗牌，",
					"使用时互相{C:dark_edition}触发{}对方效果",
					"{C:inactive}(含商店内使用){}"
				}
			}
		},
		Star = {
			c_entr_regulus = {
				name = "轩辕十四",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				}
			},
			c_entr_hydrae = {
				name = "南门二",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				}
			},
			c_entr_vega = {
				name = "织女星",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				}
			},
			c_entr_polaris = {
				name = "北极星",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				}
			},
			c_entr_cassiopeiae = {
				name = "策星",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				}
			},
			c_entr_pegasi = {
				name = "特拉比斯特-1",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				}
			},
			c_entr_persei = {
				name = "开普勒-90",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				}
			},
			c_entr_ophiuchi = {
				name = "巨蟹座55",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				}
			},
			c_entr_carinae = {
				name = "参宿四",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				}
			},
			c_entr_procyon = {
				name = "南河三",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				}
			},
			c_entr_tauri = {
				name = "金牛座W33A",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				}
			},
			c_entr_sirius = {
				name = "天狼星",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				}
			},
			c_entr_multiverse = {
				name = Cryptid_config.family_mode and "多元宇宙" or "TMD整个多元宇宙！",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				}
			},
			c_entr_binarystars = {
				name = "双星系统",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				}
			},
			c_entr_deadcore = {
				name = "死核",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				}
			},
			c_entr_dark_matter = {
				name = "暗物质",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				}
			},
			c_entr_dyson_swarm = {
				name = "戴森云",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				}
			},
			c_entr_starlua = {
				name = "恒星.lua",
				text = {
					"{C:green}#1#/#2#{}概率",
					"升级所有",
					"{C:legendary,E:1}扑克牌型{}",
					"{C:gold}+#3#{}升阶强度"
				}
			},
			c_entr_strange_star = {
				name = "奇异星",
				text = {
					"升级随机一种牌型，",
					"每曾使用一张奇异星，",
					"额外{C:gold}+#2#{}升阶强度",
					"{C:inactive}(当前为#1#)"
				}
			},
			c_entr_nemesis = {
				name = "涅墨西斯",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{S:0.8}){}",
					"将{C:attention}晋升{}牌型的指数",
					"提高{X:gold,C:white}+X#2#{}",
					"{C:inactive}(当前为{X:gold,C:white}#3#{C:inactive})"
				}
			},
			c_entr_paras = {
				name = "帕拉斯",
				text = {
					"({V:1}等级#4#{}{C:gold}#8#{})({V:2}等级#5#{}{C:gold}#9#{})({V:3}等级#6#{}{C:gold}#10#{})",
					"升级",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"与{C:attention}#3#{}",
					"{C:gold}+#7#{}升阶强度"
				},
			},
			c_entr_jatka = {
				name = "贾特卡",
				text = {
					"({V:1}等级#4#{}{C:gold}#8#{})({V:2}等级#5#{}{C:gold}#9#{})({V:3}等级#6#{}{C:gold}#10#{})",
					"升级",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"与{C:attention}#3#{}",
					"{C:gold}+#7#{}升阶强度"
				},
			},
			c_entr_rouva = {
				name = "鲁瓦",
				text = {
					"({V:1}等级#4#{}{C:gold}#8#{})({V:2}等级#5#{}{C:gold}#9#{})({V:3}等级#6#{}{C:gold}#10#{})",
					"升级",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"与{C:attention}#3#{}",
					"{C:gold}+#7#{}升阶强度"
				},
			},
			c_entr_assa = {
				name = "阿萨",
				text = {
					"({V:1}等级#4#{}{C:gold}#8#{})({V:2}等级#5#{}{C:gold}#9#{})({V:3}等级#6#{}{C:gold}#10#{})",
					"升级",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"与{C:attention}#3#{}",
					"{C:gold}+#7#{}升阶强度"
				},
			},
			c_entr_kivi = {
				name = "基维",
				text = {
					"({V:1}等级#4#{}{C:gold}#8#{})({V:2}等级#5#{}{C:gold}#9#{})({V:3}等级#6#{}{C:gold}#10#{})",
					"升级",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"与{C:attention}#3#{}",
					"{C:gold}+#7#{}升阶强度"
				},
			},
			c_entr_chunk = {
				name = "区块",
				text = {
					"({V:1}等级#4#{}{C:gold}#8#{})({V:2}等级#5#{}{C:gold}#9#{})({V:3}等级#6#{}{C:gold}#10#{})",
					"升级",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"与{C:attention}#3#{}",
					"{C:gold}+#7#{}升阶强度"
				},
			},
			c_entr_supernova = {
				name = "坍缩",
				text = {
					"移除 #1#{C:gold}升阶强度{}从",
					"你的{X:purple,C:white}宿敌{}的",
					"最高{C:gold}升阶强度{}",
					"{C:legendary,E:1}扑克牌型{}",
				},
			},
			c_entr_pocket_dimension = {
				name = "口袋维度",
				text = {
					"{S:0.8}({S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){}升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{}升阶强度"
				},
			},
			c_entr_black_dwarf = {
				name = "黑矮星",
				text = {
					"所有扑克牌型等级提升时",
					"获得{C:gold}升阶强度{}",
					"每级{C:gold}+#1#{}升阶强度"
				},
			},
			c_entr_frozen_star = {
				name = "冻结之星",
				text = {
					"升级你{C:attention}最高等级{}的",
					"扑克牌型{C:gold}+#1#{}升阶强度"
				},
			},
			c_entr_coatlicue = {
				name = "科亚特利库",
				text = {
					"随机升级一种扑克牌型",
					"根据其{C:chips}筹码{}每级",
					"获得{C:gold}升阶强度{}的{C:attention}1/20{}"
				},
			},
			c_entr_threefour = {
				name = "34金牛",
				text = {
					"随机升级一种扑克牌型",
					"根据其{C:mult}倍率{}每级",
					"获得{C:gold}升阶强度{}的{C:attention}1/3{}"
				},
			},
			c_entr_fuzzball = {
				name = "毛球",
				text = {
					"升级{C:attention}#1#{}种",
					"随机扑克牌型",
					"{C:gold}+#2#{}升阶强度",
				},
			},
			c_entr_starhousespectrum = {
				name = "天棓四",
				text = {
					"{S:0.8}（{S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}）{}提升等级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 升阶强度"
				}
			},
			c_entr_starspectrum = {
				name = "织女一",
				text = {
					"{S:0.8}（{S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}）{}提升等级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 升阶强度"
				}
			},
			c_entr_starfivespectrum = {
				name = "HD 33579",
				text = {
					"{S:0.8}（{S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}）{}提升等级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 升阶强度"
				}
			},
			c_entr_starstraightspectrum = {
				name = "参宿七",
				text = {
					"{S:0.8}（{S:0.8,V:1}等级#1#{}{S:0.8,C:gold}#2#{}{S:0.8}）{}提升等级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 升阶强度"
				}
			},
		},
		Omen = {
			c_entr_rift = {
				name = "裂隙",
				text = {
					"为{C:attention}#1#{}张选中的卡牌",
					"施加{C:attention}随机{}的{C:dark_edition}版本{}"
				}
			},
			c_entr_define = {
				name = "#1#定义",
				text = {
					"将之后所有出现的{C:entr_omen}选中卡牌{}",
					"替换为{C:entr_omen}你选择的另一张牌{}",
					"随后{C:attention}摧毁{}该选中卡牌",
					"{C:inactive}(稀有消耗牌与{C:inactive}≥异域小丑除外){}"
				}
			},
			c_entr_beyond = {
				name = "超凡入圣",
				text = {
					"生成一张随机的",
					"{C:entr_entropic,E:1}熵化{}小丑",
					"并摧毁所有其他小丑"
				}
			},
			c_entr_fervour = {
				name = "狂热",
				text = {
					"生成一张",
					"{C:entr_reverse_legendary,E:1}传奇?{}小丑",
					"{C:inactive}(必须有空间)"
				}
			},
			c_entr_pulsar = {
				name = "脉冲星",
				text = {
					"升级每一种",
					"{C:legendary,E:1}扑克牌型{}",
					"{C:gold}+#1#{}升阶强度"
				}
			},
			c_entr_quasar = {
				name = "类星体",
				text = {
					"根据当前等级，升级你",
					"最常用的{C:legendary,E:1}扑克牌型{}",
					"{C:gold}+#1#{}升阶强度"
				}
			},
			c_entr_dispel = {
				name = "驱散",
				text = {
					"放逐{C:attention}#1#{}张选中的小丑",
					"{C:inactive}(无视永恒){}"
				}
			},
			c_entr_weld = {
				name = "焊接",
				text = {
					"为#1#张选中的小丑",
					"施加{C:dark_edition}负片{}与{C:purple,E:1}阿列夫{}"
				}
			},
			c_entr_cleanse = {
				name = "净化",
				text = {
					"剥离手牌中所有卡牌的",
					"花色与点数",
					"每剥离一个{C:blue}筹码{}获得{C:gold}$#1#{}"
				}
			},
			c_entr_insignia = {
				name = "徽章",
				text = {
					"为#1#张选中的卡牌",
					"添加{V:1}银色蜡封{}"
				}
			},
			c_entr_rendezvous = {
				name = "汇合",
				text = {
					"为#1#张选中的卡牌",
					"添加{V:1}绯红蜡封{}"
				}
			},
			c_entr_eclipse = {
				name = "蔽日",
				text = {
					"为#1#张选中的卡牌",
					"添加{V:1}青玉蜡封{}"
				}
			},
			c_entr_calamity = {
				name = "灾厄",
				text = {
					"为#1#张选中的卡牌",
					"添加{V:1}粉色蜡封{}"
				}
			},
			c_entr_downpour = {
				name = "暴雨",
				text = {
					"为#1#张选中的卡牌",
					"添加{V:1}蔚蓝蜡封{}"
				}
			},
			c_entr_script = {
				name = "脚本",
				text = {
					"为#1#张选中的卡牌",
					"添加{V:1}葱茏蜡封{}"
				}
			},
			c_entr_inscribe = {
				name = "铭刻",
				text = {
					"将手牌中数字牌的{C:attention}基础筹码",
					"乘以{X:chips,C:white}X#1#{}",
					"随后{C:attention}削弱{}所有数字牌一回合"
				}
			},
			c_entr_siphon = {
				name = "虹吸",
				text = {
					"摧毁一张选中的{C:attention}版本{}小丑",
					"并将其{C:attention}前一个版本{}",
					"施加给手牌中所有卡牌",
					"{C:inactive}(当前为：#1#)"
				}
			},
			c_entr_changeling = {
				name = "换形",
				text = {
					"将手牌中{C:attention}#1#{}张卡牌",
					"转换为{C:attention}随机版本{}的人头牌"
				}
			},
			c_entr_ward = {
				name = "守卫",
				text = {
					"削弱所有小丑{C:attention}#2#{}回合",
					"随后获得其{C:attention}购买价格",
					"的{X:gold,C:white}X#1#{}倍金钱"
				}
			},
			c_entr_ichor = {
				name = "灵液",
				text = {
					"随机放逐一张持有的",
					"{C:dark_edition}负片{}小丑",
					"{C:dark_edition}+#1#{}小丑槽"
				}
			},
			c_entr_pact = {
				name = "契约",
				text = {
					"{C:attention}链接{}至多{C:attention}#1#{}张卡牌",
					"所有修改将共享于",
					"所有被链接卡牌"
				}
			},
			c_entr_rend = {
				name = "撕裂",
				text = {
					"将最多{C:attention}#1#{}张选中的卡牌",
					"转换为{C:attention}血肉牌{}"
				}
			},
			c_entr_rejuvenate = {
				name = "焕新",
				text = {
					"为一张选中的卡牌添加",
					"随机{C:attention}蜡封{}、{C:attention}增强{}与{C:attention}版本{}",
					"随后将{C:attention}#1#{}张其他卡牌",
					"转换为该牌，{C:gold}#2#{}"
				}
			},
			c_entr_crypt = {
				name = "地窖",
				text = {
					"选择{C:attention}#1#{}张小丑",
					"将{C:attention}左侧{}小丑",
					"转换为{C:attention}右侧{}小丑",
					"随后{C:attention}移除{}其版本"
				}
			},
			c_entr_charm = {
				name = "护符",
				text = {
					"为一张选中的小丑",
					"施加{C:attention}万花筒{}与{C:attention}永恒{}"
				}
			},
			c_entr_entropy = {
				name = "熵",
				text = {
					"对最多#1#张选中的卡牌",
					"进行完全{C:attention}随机化{}"
				}
			},
			c_entr_fusion = {
				name = "融合",
				text = {
					"手牌中{C:attention}#1#{}张随机卡牌",
					"变为一张选中卡牌的",
					"随机类型"
				}
			},
			c_entr_substitute = {
				name = "替代",
				text = {
					"{C:attention}撤销{}一张随机优惠券",
					"及其所有低阶版本",
					"随后兑换下一阶"
				}
			},
			c_entr_evocation = {
				name = "唤灵",
				text = {
					"{C:attention}升级{}#1#张选中小丑的",
					"稀有度并摧毁所有其他小丑",
					"{C:blue}#2#{}手牌"
				}
			},
			c_entr_mimic = {
				name = "拟态",
				text = {
					"创建一张{C:attention}香蕉易腐{}复制",
					"的#1#张选中卡牌"
				}
			},
			c_entr_superego = {
				name = "投射",
				text = {
					"为一张选中的小丑施加",
					"{C:attention}预估{}贴纸",
					"随后削弱该小丑"
				}
			},
			c_entr_engulf = {
				name = "吞没",
				text = {
					"为一张选中的卡牌",
					"施加{C:dark_edition}太阳{}版本"
				}
			},
			c_entr_offering = {
				name = "献祭",
				text = {
					"所有小丑变为{C:attention}租用{}",
					"{X:gold,C:white}X#1#{}商店价格"
				}
			},
			c_entr_entomb = {
				name = "埋葬",
				text = {
					"生成一个对应#1#张选中消耗牌的类型的",
					"{C:attention}巨型补充包{}"
				}
			},
			c_entr_conduct = {
				name = "传导",
				text = {
					"为一张选中卡牌或其相邻卡牌",
					"施加{C:attention}前一个版本{}",
					"{C:inactive}(当前为：#1#)"
				}
			},
			c_entr_disavow = {
				name = "否认",
				text = {
					"根据手牌中卡牌的{C:attention}增强{}",
					"提升其效果",
					"随后{C:attention}永久{}移除增强"
				}
			},
			c_entr_regenerate = {
				name = "再生",
				text = {
					"完全重置最多",
					"{C:attention}#1#{}张选中的卡牌或小丑",
					"{C:inactive}(不会移除阿列夫){}"
				}
			},
			c_entr_purity = {
				name = "纯净",
				text = {
					"为#1#张选中的小丑",
					"施加{C:dark_edition}纯净{}贴纸"
				}
			},
			c_entr_transcend = {
				name = "超脱",
				text = {
					"将{C:attention}#1#{}张选中的卡牌",
					"转换为一张{C:attention}随机{}{C:red}物件{}"
				}
			},
			c_entr_malediction = {
				name = "诅咒",
				text = {
					"为#1#张选中的卡牌",
					"添加{V:1}琥珀蜡封{}"
				}
			},
			c_entr_serpents = {
				name = "蛇之契约",
				text = {
					"生成一张随机{C:attention}稀有{}消耗牌",
					"{C:money}-$#1#{}",
					"{C:inactive}(可能溢出){}"
				}
			},
			c_entr_splinter = {
				name = "碎片",
				text = {
					"牌堆中一张{C:attention}随机{}卡牌",
					"变为一张随机的{C:attention}碎裂{}小丑"
				}
			},
			c_entr_dream = {
				name = "梦境",
				text = {
					"抽取{C:attention}#1#{}张随机",
					"{C:attention}增强{}{C:purple}眼#<s>1#{}",
					"加入手牌"
				}
			},
			c_entr_void = {
				name = "虚空",
				text = {
					"为#1#张选中的卡牌",
					"添加{V:1}迷你蜡封{}"
				}
			},
			c_entr_sharpen = {
				name = "磨砺",
				text = {
					"为#1#张选中的卡牌",
					"添加{V:1}锋利蜡封{}"
				}
			},
			c_entr_singularity = {
				name = "奇点",
				text = {
					"为#1#张选中的卡牌",
					"添加{V:1}纳米黑蜡封{}"
				}
			},
			c_entr_highway = {
				name = "高速路",
				text = {
					"摧毁除{C:attention}一张{}外的{C:red}所有{}小丑牌",
					"然后生成一张{C:entr_entropic,E:1}熵化{}小丑牌"
				}
			},
			c_entr_idyll = {
				name = "田园诗",
				text = {
					"生成上次获得的",
					"{C:attention}标签{}的{C:attention}复制{}",
					"及其{C:entr_entropic}升阶{}变体"
				}
			},
		},
		Transient = {
			c_entr_cage = {
				name = "牢笼",
				text = {
					"为{C:attention}#1#{}张选中的卡牌",
					"施加{C:attention}临时{}效果",
					"并将其花色改为",
					"最左侧选中卡牌的花色"
				}
			},
			c_entr_implode = {
				name = "内爆",
				text = {
					"为{C:attention}#1#{}张选中的卡牌",
					"施加{C:attention}临时{}效果",
					"并将其变为{C:attention}无色 A{}"
				}
			},
			c_entr_meteor = {
				name = "流星",
				text = {
					"为手牌中{C:attention}#1#{}张随机卡牌",
					"施加{C:attention}临时{}效果",
					"并添加{C:purple}青玉蜡封{}"
				}
			},
			c_entr_concentrate = {
				name = "凝聚",
				text = {
					"为{C:attention}所有{}选中的卡牌",
					"施加{C:attention}临时{}效果",
					"并将其复制加入手牌"
				}
			},
			c_entr_pyrite = {
				name = "黄铁矿",
				text = {
					"为{C:attention}#1#{}张选中的卡牌",
					"施加{C:attention}临时{}效果",
					"并将其变为{C:attention}黄金卡牌{}"
				}
			},
			c_entr_set = {
				name = "设定",
				text = {
					"为{C:attention}#1#{}张选中的卡牌",
					"施加{C:attention}临时{}效果",
					"并将其点数改为",
					"最左侧选中卡牌的点数"
				}
			},
			c_entr_trickster = {
				name = "诡术师",
				text = {
					"为{C:attention}#1#{}张选中的卡牌",
					"施加{C:attention}临时{}效果",
					"并将其变为一张",
					"随机的{C:red}稀有{}{C:attention}小丑{}"
				}
			},
			c_entr_sundial = {
				name = "日晷",
				text = {
					"为{C:attention}#1#{}张选中的卡牌",
					"施加{C:attention}临时{}效果",
					"并将其变为{C:attention}玻璃卡牌{}"
				}
			},
			c_entr_candle = {
				name = "蜡烛",
				text = {
					"{C:attention}+#1#{}手牌上限",
					"仅限本盲注"
				}
			},
			c_entr_faith = {
				name = "信仰",
				text = {
					"为{C:attention}#1#{}张选中的卡牌",
					"施加{C:attention}临时{}效果",
					"并将其变为{C:attention}幸运卡牌{}"
				}
			},
			c_entr_oasis = {
				name = "绿洲",
				text = {
					"为一张选中的卡牌施加",
					"{C:attention}临时{}效果",
					"随后复制{C:attention}#1#{}次"
				}
			},
			c_entr_ragtag = {
				name = "杂牌",
				text = {
					"为{C:attention}#1#{}张选中的卡牌",
					"施加{C:attention}临时{}效果",
					"并将其变为一张",
					"随机的{C:blue}普通{}{C:attention}小丑{}"
				}
			},
			c_entr_burn = {
				name = "燃烧",
				text = {
					"为手牌中{C:attention}#1#{}张随机卡牌",
					"施加{C:attention}临时{}效果",
					"并添加{C:purple}粉色蜡封{}"
				}
			},
			c_entr_escape = {
				name = "逃脱",
				text = {
					"为手牌中{C:attention}#1#{}张随机卡牌",
					"施加{C:attention}临时{}效果",
					"随后将其随机化"
				}
			},
			c_entr_gbdecay = {
				name = "衰变",
				text = {
					"为{C:attention}#1#{}张选中的卡牌",
					"施加{C:attention}临时{}效果",
					"并将其变为{C:attention}钢铁卡牌{}"
				}
			},
			c_entr_visage = {
				name = "虚影",
				text = {
					"为{C:attention}#1#{}张选中的卡牌",
					"施加{C:attention}临时{}效果",
					"并将其变为{C:attention}石头卡牌{}"
				}
			},
			c_entr_nebula = {
				name = "星云",
				text = {
					"生成{C:attention}#1#{}张随机",
					"{C:attention}临时{}盲注代币"
				}
			},
			c_entr_essence = {
				name = "精华",
				text = {
					"为{C:attention}#1#{}张选中的卡牌",
					"施加{C:attention}临时{}效果",
					"并将其变为{C:attention}随机{}",
					"有花色的人头牌"
				}
			},
			c_entr_manifest = {
				name = "显现",
				text = {
					"{C:attention}+#1#{}选择上限",
					"仅限本盲注"
				}
			},
			c_entr_hope = {
				name = "希望",
				text = {
					"为手牌中{C:attention}#1#{}张随机卡牌",
					"施加{C:attention}临时{}效果",
					"并添加{V:1}银色蜡封{}"
				}
			},
		},
		Tarot = {
			c_entr_kiln = {
				name = "窑炉",
				text = {
					"将{C:attention}#1#{}张选中的卡牌",
					"增强为{C:attention}陶瓷牌{}"
				}
			},
			c_entr_comet = {
				name = "彗星",
				text = {
					"增强{C:attention}#1#{}张",
					"选中的卡牌成为",
					"{C:attention}光辉牌{}"
				}
			},
		},
		Spectral = {
			c_entr_flipside = {
				name = "逆转",
				text = {
					"将{C:attention}#1#{}张选中的消耗牌",
					"转换为{C:red}反转{}变体"
				}
			},
			c_entr_destiny = {
				name = "命运",
				text = {
					"牺牲{C:attention}5{}张扑克牌",
					"根据其增强效果",
					"合成一张小丑",
					"{C:inactive}(当前为#1#)"
				}
			},
			c_entr_shatter = {
				name = "粉碎",
				text = {
					"为手牌中{C:attention}#1#{}张选中的卡牌",
					"施加{C:dark_edition}碎裂{}版本"
				}
			},
			c_entr_lust = {
				name = "欲望",
				text = {
					"为手牌中{C:attention}#1#{}张选中的卡牌",
					"施加{C:dark_edition}怪异{}版本"
				}
			},
			c_entr_null = {
				name = "虚无",
				text = {
					"摧毁手牌中{C:attention}1{}张随机卡牌",
					"并加入{C:attention}#1#{}张",
					"随机的{C:attention}增强的无色 0{}",
					"到手牌"
				}
			},
			c_entr_antithesis = {
				name = "对立",
				text = {
					"切换所有持有小丑的",
					"{C:purple,E:1}永恒{}状态"
				}
			},
			c_entr_oss = {
				name = "奥斯符文",
				text = {
					"下一次打开{C:attention}补充包{}时",
					"包含一张{C:purple}稀有{}消耗牌",
					"{C:inactive}(若可能)"
				}
			},
			c_entr_oss_providence = {
				name = "奥斯符文{C:purple}+{}",
				text = {
					"下一次打开{C:attention}补充包{}时",
					"包含一张{C:purple}稀有{}消耗牌",
					"并{C:purple,E:1}生成{}一张{C:purple}符文{}",
					"{C:inactive}(若可能)"
				}
			},
			c_entr_enchant = {
				name = "附魔",
				text = {
					"为{C:attention}#1#{}张选中的手牌",
					"添加{C:purple}华紫蜡封{}"
				}
			},
			c_entr_manifest = {
				name = "显化",
				text = {
					"生成当前底注",
					"的{C:entr_entropic}升阶{}变体",
					"并跳过标签"
				}
			},
		},
		Stake = {
			stake_entr_copper = {
				name = "铜注",
				text = {
					"{C:attention}复制{}的扑克牌可能变为{C:red}否定牌{}",
					"{s:0.8}应用之前所有注的效果",
				},
			},
			stake_entr_platinum = {
				name = "铂金注",
				text = {
					"小丑价格提高{C:red}20%{}",
					"{s:0.8}应用之前所有注的效果",
				},
			},
			stake_entr_meteorite = {
				name = "陨石注",
				text = {
					"牌型升级可能{C:red}失败{}",
					"{s:0.8}应用之前所有注的效果",
				},
			},
			stake_entr_obsidian = {
				name = "黑曜注",
				text = {
					"击败Boss盲注时必定获得一个{C:red}诅咒{}",
					"{s:0.8}应用之前所有注的效果",
				},
			},
			stake_entr_iridium = {
				name = "铱金注",
				text = {
					"胜利底注为{C:red}10{}",
					"{s:0.8}应用之前所有注的效果",
					"{s:0.7}跨性别权利",
				},
			},
			stake_entr_zenith = {
				name = "天顶注",
				text = {
					"{E:1,C:entr_zenith}所有盲注均为无尽之熵{}",
					"{s:0.8}应用之前所有注的效果",
				},
			},
		},
		Tag = {
			tag_entr_dog = {
				name = "狗狗标签",
				text = { "汪。", "{C:inactive}等级{C:dark_edition}#1#" },
			},
			tag_entr_sunny = {
				name = "晴朗标签",
				text = {
					"下一个基础版本商店",
					"小丑免费并",
					"获得{C:dark_edition}晴朗{}版本",
				},
			},
			tag_entr_solar = {
				name = "太阳标签",
				text = {
					"下一个基础版本商店",
					"小丑免费并",
					"获得{C:dark_edition}太阳{}版本",
				},
			},
			tag_entr_fractured = {
				name = "碎裂标签",
				text = {
					"下一个基础版本商店",
					"小丑免费并",
					"获得{C:dark_edition}碎裂{}版本",
				},
			},
			tag_entr_freaky = {
				name = "怪异标签",
				text = {
					"下一个基础版本商店",
					"小丑免费并",
					"获得{C:dark_edition}怪异{}版本",
				},
			},
			tag_entr_neon = {
				name = "霓虹标签",
				text = {
					"下一个基础版本商店",
					"小丑免费并",
					"获得{C:dark_edition}霓虹{}版本",
				},
			},
			tag_entr_lowres = {
				name = "低分辨率标签",
				text = {
					"下一个基础版本商店",
					"小丑免费并",
					"获得{C:dark_edition}低分辨率{}版本",
				},
			},
			tag_entr_kaleidoscopic = {
				name = "万花筒标签",
				text = {
					"下一个基础版本商店",
					"小丑免费并",
					"获得{C:dark_edition}万花筒{}版本",
				},
			},
			tag_entr_ascendant_rare = {
				name = "{C:gold}稀有标签",
				text = { "商店出现免费", "{C:rare}稀有小丑" },
			},
			tag_entr_ascendant_epic = {
				name = "{C:gold}史诗标签",
				text = { "商店出现免费", "{C:cry_epic}史诗小丑" },
			},
			tag_entr_ascendant_legendary = {
				name = "{C:gold}传奇标签",
				text = { "商店出现免费", "{C:legendary}传奇小丑" },
			},
			tag_entr_ascendant_exotic = {
				name = "{C:gold}异域标签",
				text = { "商店出现免费", "{C:cry_exotic}异域小丑" },
			},
			tag_entr_ascendant_entropic = {
				name = "{C:gold}熵化标签",
				text = { "商店出现免费", "{C:entr_entropic}熵化小丑" },
			},
			tag_entr_ascendant_copying = {
				name = "{C:gold}复制标签",
				text = { "给予{C:attention}#1#{}份", "下一个选择的标签", "{C:inactive}(排除复制类标签)" },
			},
			tag_entr_ascendant_voucher = {
				name = "{C:gold}优惠券标签",
				text = { "为下个商店增加一张", "T{C:attention}3{}等级优惠券" },
			},
			tag_entr_ascendant_voucher_cryptidless = {
				name = "{C:gold}优惠券标签",
				text = { "为下个商店增加{C:attention}两张", "随机优惠券" },
			},
			tag_entr_ascendant_better_voucher = {
				name = "{C:gold}至臻优惠券标签",
				text = { "为下个商店增加{C:attention}两张", "T{C:attention}3{}等级优惠券" },
			},
			tag_entr_ascendant_saint = {
				name = "{C:gold}圣徒标签",
				text = { "商店出现免费", "{C:attention}版本糖果小丑" },
			},
			tag_entr_ascendant_negative = {
				name = "{C:gold}负片标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}负片{}版本" },
			},
			tag_entr_ascendant_foil = {
				name = "{C:gold}闪箔标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}闪箔{}版本" },
			},
			tag_entr_ascendant_holo = {
				name = "{C:gold}镭射标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}镭射{}版本" },
			},
			tag_entr_ascendant_poly = {
				name = "{C:gold}多彩标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}多彩{}版本" },
			},
			tag_entr_ascendant_glass = {
				name = "{C:gold}玻璃标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}玻璃{}版本" },
			},
			tag_entr_ascendant_glitched = {
				name = "{C:gold}故障标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}故障{}版本" },
			},
			tag_entr_ascendant_gold = {
				name = "{C:gold}黄金标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}黄金{}版本" },
			},
			tag_entr_ascendant_blurry = {
				name = "{C:gold}模糊标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}模糊{}版本" },
			},
			tag_entr_ascendant_m = {
				name = "{C:gold}M标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}欢愉{}", "{C:inactive}M{}" },
			},
			tag_entr_ascendant_mosaic = {
				name = "{C:gold}马赛克标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}马赛克{}版本" },
			},
			tag_entr_ascendant_astral = {
				name = "{C:gold}星界标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}星界{}版本" },
			},
			tag_entr_ascendant_oversat = {
				name = "{C:gold}过曝标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}过曝{}版本" },
			},
			tag_entr_ascendant_sunny = {
				name = "{C:gold}晴朗标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}晴朗{}版本" },
			},
			tag_entr_ascendant_solar = {
				name = "{C:gold}太阳标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}太阳{}版本" },
			},
			tag_entr_ascendant_fractured = {
				name = "{C:gold}碎裂标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}碎裂{}版本" },
			},
			tag_entr_ascendant_freaky = {
				name = "{C:gold}怪异标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}怪异{}版本" },
			},
			tag_entr_ascendant_neon = {
				name = "{C:gold}霓虹标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}霓虹{}版本" },
			},
			tag_entr_ascendant_lowres = {
				name = "{C:gold}低分辨率标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}低分辨率{}版本" },
			},
			tag_entr_ascendant_kaleidoscopic = {
				name = "{C:gold}万花筒标签",
				text = { "{C:attention}所有{}商店物品为{C:dark_edition}万花筒{}版本" },
			},
			tag_entr_ascendant_infdiscard = {
				name = "{C:gold}无限弃牌标签",
				text = { "下一回合", "{C:attention}+3{}弃牌次数" },
			},
			tag_entr_ascendant_cat = {
				name = "{C:gold}猫猫标签",
				text = { "{C:gold}喵。{}", "{C:inactive}等级{C:dark_edition}#1#" },
			},
			tag_entr_ascendant_dog = {
				name = "{C:gold}狗狗标签",
				text = { "{C:red}汪。{}", "{C:inactive}等级{C:dark_edition}#1#" },
			},
			tag_entr_ascendant_canvas = {
				name = "{C:gold}画布标签",
				text = { "商店出现一张", "{C:attention}画布{}" },
			},
			tag_entr_ascendant_unbounded = {
				name = "{C:gold}无垠标签",
				text = {
					"获得一个免费{C:spectral}幻灵包",
					"包含{C:green,E:1}指针{}与{C:entr_entropic,E:1}超凡入圣{}",
				},
			},
			tag_entr_ascendant_ejoker = {
				name = "{C:gold}小丑标签",
				text = { "获得一个免费版本", "{C:attention}巨型小丑包{}" },
			},
			tag_entr_ascendant_universal = {
				name = "{C:gold}通用标签",
				text = { "升级{C:attention}#1#{}", "{C:gold}+6{}升阶强度" },
			},
			tag_entr_ascendant_ebundle = {
				name = "{C:gold}捆绑标签",
				text = {
					"生成一个{C:attention}控制台标签{}、{C:attention}空灵标签{}",
					"{C:attention}扭曲标签{}与{C:attention}组合标签{}",
				},
			},
			tag_entr_ascendant_twisted = {
				name = "{C:gold}扭曲标签",
				text = {
					"获得一个免费",
					"{C:red}扭曲包{}",
				},
			},
			tag_entr_ascendant_stock = {
				name = "{C:gold}股票标签",
				text = { "金钱乘以 2.5 倍" },
			},
			tag_entr_ascendant_blind = {
				name = "{C:gold}盲注标签",
				text = {
					"获得一个免费",
					"{C:attention}盲注包{}",
				},
			},
			tag_entr_ascendant_reference = {
				name = "{C:gold}典故标签",
				text = {
					"获得一个免费",
					"{C:green}典故包{}",
				},
			},
			tag_entr_ascendant_cavendish = {
				name = "{C:gold}卡文迪许标签",
				text = {
					"获得一个免费",
					"{C:attention}卡文迪许{}",
				},
			},
			tag_entr_ascendant_credit = {
				name = "{C:gold}信用标签",
				text = {
					"下一商店初始卡牌与",
					"补充包免费",
					"重掷价格从{C:gold}-$5{}开始",
				},
			},
			tag_entr_ascendant_topup = {
				name = "{C:gold}充值标签",
				text = {
					"生成最多{C:attention}3{}张",
					"{C:green}罕见小丑{}",
					"{C:inactive}(必须有空间){}",
				},
			},
			tag_entr_ascendant_better_topup = {
				name = "{C:gold}高级充值标签",
				text = {
					"生成最多{C:attention}3{}张",
					"{C:red}稀有小丑{}",
					"{C:inactive}(必须有空间){}",
				},
			},
			tag_entr_ascendant_booster = {
				name = "{C:gold}增强包标签",
				text = {
					"下一个{C:cry_code}增强包{}",
					"卡牌数量与选择次数",
					"均变为{C:attention}三倍{}",
				},
			},
			tag_entr_ascendant_effarcire = {
				name = "{C:gold}无限标签",
				text = {
					"下一回合抽牌至",
					"手牌上限填满",
				},
			},
			tag_entr_arcane = {
				name = "奥秘标签",
				text = {
					"获得一张随机{C:purple}符文{}"
				},
			},
			tag_entr_ascendant_arcane = {
				name = "{C:gold}奥秘标签",
				text = {
					"获得{C:attention}两张{}随机{C:purple}符文{}"
				},
			},
			tag_entr_ascendant_kitty = {
				name = "{C:gold}猫咪标签{}",
				text = {
					"拥有的每枚{C:attention}猫咪标签{}",
					"给予{X:chips,C:white}X#1#{}筹码"
				}
			},
			tag_entr_ascendant_negative_eternal = {
				name = "{C:gold}负永恒标签{}",
				text = {
					"商店内{C:attention}所有{}商品",
					"均为{C:dark_edition}负片{}且{C:attention}永恒{}"
				}
			},
		},
		["Rune Tag"] = {
			rune_entr_fehu = {
				name = "财富",
				text = {
					"下一张{C:attention}售出{}的卡牌",
					"将其{C:attention}一半{}售价",
					"加给你的小丑"
				}
			},
			rune_entr_fehu_providence = {
				name = "财富{C:purple}+{}",
				text = {
					"下一张{C:attention}售出{}的卡牌",
					"将其{C:purple,E:1}全部{}售价",
					"加给你的小丑"
				}
			},
			rune_entr_uruz = {
				name = "野牛",
				text = {
					"下一次{C:attention}金钱奖励",
					"提高{X:gold,C:white}50%{}",
					"{C:inactive}(加算叠加){}"
				}
			},
			rune_entr_uruz_providence = {
				name = "野牛{C:purple}+{}",
				text = {
					"下一次{C:attention}金钱奖励",
					"提高{X:purple,C:white,E:1}100%{}",
					"{C:inactive}(加算叠加){}"
				}
			},
			rune_entr_thurisaz = {
				name = "巨人",
				text = {
					"复制下一张{C:attention}弃掉{}的卡牌",
					"并加入手牌"
				}
			},
			rune_entr_thurisaz_providence = {
				name = "巨人{C:purple}+{}",
				text = {
					"复制下一张{C:attention}弃掉{}或{C:purple,E:1}打出{}的卡牌",
					"并加入手牌"
				}
			},
			rune_entr_ansuz = {
				name = "诸神",
				text = {
					"复制下一个获得的",
					"{C:attention}标签{}或{C:attention}符文{}"
				}
			},
			rune_entr_ansuz_providence = {
				name = "诸神{C:purple}+{}",
				text = {
					"复制下一个获得的",
					"{C:attention}标签{}或{C:attention}符文{}",
					"{C:purple,E:1}两次{}"
				}
			},
			rune_entr_raido = {
				name = "旅者",
				text = {
					"阻止下一次",
					"底注变化"
				}
			},
			rune_entr_raido_providence = {
				name = "旅者{C:purple}+{}",
				text = {
					"{C:purple,E:1}反转{}下一次",
					"底注变化"
				}
			},
			rune_entr_kaunan = {
				name = "火炬",
				text = {
					"升级下一次",
					"{C:attention}打出{}的牌型"
				}
			},
			rune_entr_kaunan_providence = {
				name = "火炬{C:purple}+{}",
				text = {
					"升级下一次",
					"{C:attention}打出{}的牌型",
					"{C:purple,E:1}两次{}"
				}
			},
			rune_entr_gebo = {
				name = "赠礼",
				text = {
					"生成一张与下一张",
					"{C:attention}售出{}卡牌同类型的牌",
					"{C:inactive}(必须有空间){}"
				}
			},
			rune_entr_gebo_providence = {
				name = "赠礼{C:purple}+{}",
				text = {
					"生成一张与下一张",
					"{C:attention}售出{}卡牌同类型的牌",
					"{C:purple,E:1}(可溢出){}"
				}
			},
			rune_entr_wunjo = {
				name = "喜悦",
				text = {
					"当下一张消耗牌被使用时",
					"生成一张随机{C:purple}符文{}"
				}
			},
			rune_entr_wunjo_providence = {
				name = "喜悦{C:purple}+{}",
				text = {
					"当下一张消耗牌被使用时",
					"生成{C:purple}两张{}随机{C:purple}符文{}"
				}
			},
			rune_entr_haglaz = {
				name = "飓风",
				text = {
					"{C:red}摧毁{}下一次",
					"打出的手牌"
				}
			},
			rune_entr_haglaz_providence = {
				name = "飓风{C:purple}+{}",
				text = {
					"{C:red}摧毁{}下一次",
					"打出或{C:purple,E:1}弃掉{}的手牌"
				}
			},
			rune_entr_naudiz = {
				name = "需求",
				text = {
					"下一次购买的商店物品",
					"可{C:attention}无视金钱{}购买",
					"不足时进入{C:attention}负债{}"
				}
			},
			rune_entr_naudiz_providence = {
				name = "需求{C:purple}+{}",
				text = {
					"下一次购买的商店物品",
					"可{C:attention}无视金钱{}购买",
					"{C:purple,E:1}不负债{}"
				}
			},
			rune_entr_isaz = {
				name = "坚冰",
				text = {
					"下一次商店",
					"额外出现一张{C:attention}优惠券{}"
				}
			},
			rune_entr_isaz_providence = {
				name = "坚冰{C:purple}+{}",
				text = {
					"下一次商店",
					"额外出现一张{C:attention}优惠券{}",
					"价格为{C:purple,E:1}半价{}"
				}
			},
			rune_entr_jera = {
				name = "丰收",
				text = {
					"复制下一张",
					"{C:attention}使用{}的消耗牌"
				}
			},
			rune_entr_jera_providence = {
				name = "丰收{C:purple}+{}",
				text = {
					"复制下一张",
					"{C:attention}使用{}的消耗牌",
					"{C:purple,E:1}两次{}"
				}
			},
			rune_entr_ihwaz = {
				name = "紫衫",
				text = {
					"随机改变下一张",
					"{C:attention}打出{}卡牌的一个点数与花色"
				}
			},
			rune_entr_ihwaz_providence = {
				name = "紫衫{C:purple}+{}",
				text = {
					"{C:purple,E:1}完全{}随机化下一张",
					"{C:attention}打出{}的卡牌"
				}
			},
			rune_entr_perthro = {
				name = "签筒",
				text = {
					"下一次重掷",
					"将{C:attention}补货补充包{}"
				}
			},
			rune_entr_perthro_providence = {
				name = "签筒{C:purple}+{}",
				text = {
					"下一次重掷",
					"将{C:attention}补货补充包{}",
					"并{C:purple,E:1}+1{}临时商店槽"
				}
			},
			rune_entr_algiz = {
				name = "保护",
				text = {
					"防止下一次{C:red}死亡{}",
					"触发时获得{C:money}$5{}"
				}
			},
			rune_entr_algiz_providence = {
				name = "保护{C:purple}+{}",
				text = {
					"防止下一次{C:red}死亡{}",
					"触发时获得{C:purple,E:1}$10{}"
				}
			},
			rune_entr_sowilo = {
				name = "太阳",
				text = {
					"下一次{C:attention}弃掉{}的牌型",
					"获得{C:gold}+2{}升阶强度"
				}
			},
			rune_entr_sowilo_providence = {
				name = "太阳{C:purple}+{}",
				text = {
					"下一次{C:attention}弃掉{}的牌型",
					"获得{C:purple,E:1}+4{}升阶强度"
				}
			},
			rune_entr_tiwaz = {
				name = "提尔",
				text = {
					"为下一张{C:attention}抽取{}的卡牌",
					"添加一个随机修改"
				}
			},
			rune_entr_tiwaz_providence = {
				name = "提尔{C:purple}+{}",
				text = {
					"为下一张{C:attention}抽取{}的卡牌",
					"添加{C:purple,E:1}两个{}随机修改"
				}
			},
			rune_entr_berkano = {
				name = "桦木",
				text = {
					"生成下一张被{C:red}摧毁{}",
					"卡牌的{C:attention}两个{}复制"
				}
			},
			rune_entr_berkano_providence = {
				name = "桦木{C:purple}+{}",
				text = {
					"生成下一张被{C:red}摧毁{}",
					"卡牌的{C:purple,E:1}三个{}复制"
				}
			},
			rune_entr_ehwaz = {
				name = "骏马",
				text = {
					"下一次跳过{C:attention}盲注{}时",
					"可进入{C:attention}奖励{}与{C:attention}商店{}"
				}
			},
			rune_entr_ehwaz_providence = {
				name = "骏马{C:purple}+{}",
				text = {
					"下一次跳过{C:attention}盲注{}时",
					"可进入{C:attention}奖励{}与{C:attention}商店{}",
					"且商店槽位{C:purple,E:1}+1{}"
				}
			},
			rune_entr_mannaz = {
				name = "人类",
				text = {
					"下一次打开{C:attention}补充包{}",
					"将包含一张{C:spectral}幻灵牌{}"
				}
			},
			rune_entr_mannaz_providence = {
				name = "人类{C:purple}+{}",
				text = {
					"下一次打开{C:attention}补充包{}",
					"将包含{C:purple,E:1}两张{}{C:spectral}幻灵牌{}"
				}
			},
			rune_entr_laguz = {
				name = "湖水",
				text = {
					"下一次{C:attention}弃牌{}",
					"将返还次数"
				}
			},
			rune_entr_laguz_providence = {
				name = "湖水{C:purple}+{}",
				text = {
					"下一次{C:attention}弃牌{}",
					"将返还次数",
					"并{C:purple,E:1}暂时+1{}手牌"
				}
			},
			rune_entr_ingwaz = {
				name = "天使",
				text = {
					"下一次{C:attention}概率判定{}",
					"将{C:green}必定成功{}"
				}
			},
			rune_entr_ingwaz_providence = {
				name = "天使{C:purple}+{}",
				text = {
					"下一次{C:attention}概率判定{}",
					"将{C:green}必定成功{}",
					"并有{C:purple,E:1}33%{}概率不消耗此符文"
				}
			},
			rune_entr_dagaz = {
				name = "今时",
				text = {
					"反转下一张",
					"{C:attention}获得{}的消耗牌效果"
				}
			},
			rune_entr_dagaz_providence = {
				name = "今时{C:purple}+{}",
				text = {
					"反转下一张",
					"{C:attention}获得{}的消耗牌",
					"并{C:purple,E:1}生成{}一张随机反转消耗牌",
					"{C:inactive}(必须有空间){}"
				}
			},
			rune_entr_othila = {
				name = "地产",
				text = {
					"下一张{C:attention}售出{}的卡牌",
					"获得{C:gold}X3{}金钱"
				}
			},
			rune_entr_othila_providence = {
				name = "地产{C:purple}+{}",
				text = {
					"下一张{C:attention}售出{}的卡牌",
					"获得{C:purple,E:1}X5{}金钱"
				}
			},
			rune_entr_oss = {
				name = "奥斯",
				text = {
					"下一次打开{C:attention}补充包{}时",
					"内含一张{C:purple}稀有{}消耗牌",
					"{C:inactive}(若可能)"
				}
			},
			rune_entr_oss_providence = {
				name = "奥斯{C:purple}+{}",
				text = {
					"下一次打开{C:attention}补充包{}时",
					"内含一张{C:purple}稀有{}消耗牌",
					"并{C:purple,E:1}生成{}一张{C:purple}符文{}",
					"{C:inactive}(若可能)"
				}
			},
			-- 契约
			rune_entr_avarice = {
				name = "贪婪烙印",
				text = {
					{
						"被{C:red}贪婪{}标记"
					},
					{
						"所有出售价格变为{C:red}0{}"
					}
				}
			},
			rune_entr_rage = {
				name = "狂怒烙印",
				text = {
					"被{C:red}狂怒{}标记"
				}
			},
			rune_entr_thorns = {
				name = "荆棘烙印",
				text = {
					"被{C:red}荆棘{}标记"
				}
			},
			rune_entr_denial = {
				name = "否定烙印",
				text = {
					"被{C:red}否定{}标记"
				}
			},
			rune_entr_chains = {
				name = "锁链烙印",
				text = {
					{
						"被{C:red}锁链{}标记"
					},
					{
						"所有{C:attention}永恒{}扑克牌重新触发",
						"每回合第一张{C:attention}抽取{}的牌变为永恒"
					}
				}
			},
			rune_entr_decay = {
				name = "衰变烙印",
				text = {
					"被{C:red}衰变{}标记"
				}
			},
			rune_entr_envy = {
				name = "嫉妒烙印",
				text = {
					{
						"被{C:red}嫉妒{}标记"
					},
					{
						"随机一张{C:attention}小丑{}重新触发",
						"每回合更换目标"
					}
				}
			},
			rune_entr_youth = {
				name = "青春烙印",
				text = {
					"被{C:red}青春{}标记"
				}
			},
			rune_entr_shards = {
				name = "碎片烙印",
				text = {
					{
						"被{C:red}碎片{}标记"
					},
					{
						"扑克牌被{C:red}摧毁{}时",
						"可能{C:red}失败{}"
					}
				}
			},
			rune_entr_desire = {
				name = "欲望烙印",
				text = {
					{
						"被{C:red}欲望{}标记"
					},
					{
						"{C:attention}补充包{}",
						"价格更高"
					}
				}
			},
			rune_entr_ice = {
				name = "寒冰烙印",
				text = {
					{
						"被{C:red}寒冰{}标记"
					},
					{
						"你{C:attention}等级最高{}的牌型",
						"{C:red}无法{}再升级"
					}
				}
			},
			rune_entr_gluttony = {
				name = "暴食烙印",
				text = {
					{
						"被{C:red}暴食{}标记"
					},
					{
						"{C:red}所有{}消耗牌变为{C:attention}永恒"
					}
				}
			},
			rune_entr_rebirth = {
				name = "重生烙印",
				text = {
					{
						"被{C:red}重生{}标记"
					},
					{
						"扑克牌被{C:attention}复制{}",
						"而非被{C:red}摧毁{}"
					}
				}
			},
			rune_entr_despair = {
				name = "绝望烙印",
				text = {
					"被{C:red}绝望{}标记"
				}
			},
			rune_entr_strength = {
				name = "力量烙印",
				text = {
					"被{C:red}力量{}标记"
				}
			},
			rune_entr_darkness = {
				name = "黑暗烙印",
				text = {
					{
						"被{C:red}黑暗{}标记"
					},
					{
						"扑克牌可能",
						"背面朝上被抽取"
					}
				}
			},
			rune_entr_freedom = {
				name = "自由烙印",
				text = {
					"被{C:red}自由{}标记"
				}
			},
			rune_entr_eternity = {
				name = "永恒烙印",
				text = {
					"被{C:red}永恒{}标记"
				}
			},
			rune_entr_loyalty = {
				name = "忠诚烙印",
				text = {
					{
						"被{C:red}忠诚{}标记"
					},
					{
						"利息每{C:money}$4{}触发一次",
						"{X:mult,C:white}X0.5{}倍率每手牌递减"
					}
				}
			},
			rune_entr_brimstone = {
				name = "硫磺烙印",
				text = {
					{
						"被{C:red}硫磺{}标记"
					},
					{
						"出牌后获得{X:mult,C:white}X3.6{}倍率"
					}
				}
			},
			rune_entr_dreams = {
				name = "梦境烙印",
				text = {
					{
						"被{C:red}梦境{}标记"
					},
					{
						"小盲注不再提供奖励"
					}
				}
			},
			rune_entr_energy = {
				name = "能量烙印",
				text = {
					"被{C:red}能量{}标记"
				}
			},
			rune_entr_blood = {
				name = "鲜血烙印",
				text = {
					"被{C:red}鲜血{}标记"
				}
			},
			rune_entr_awakening = {
				name = "觉醒烙印",
				text = {
					"被{C:red}觉醒{}标记"
				}
			},
			rune_entr_serpents = {
				name = "蛇之烙印",
				text = {
					"被{C:red}蛇{}标记",
					"{C:red,E:1,s:0.8}你的命运已被封印{}"
				}
			},
		},
		Rune = {
			c_entr_fehu = {
				name = "财富符文",
				text = {
					"下一张{C:attention}售出{}的卡牌",
					"将其售价的{C:attention}一半{}",
					"加给你的小丑"
				}
			},
			c_entr_fehu_providence = {
				name = "财富符文{C:purple}+{}",
				text = {
					"下一张{C:attention}售出{}的卡牌",
					"将其{C:purple,E:1}全部{}售价",
					"加给你的小丑"
				}
			},
			c_entr_uruz = {
				name = "野牛符文",
				text = {
					"下一次{C:attention}金钱奖励",
					"提高{X:gold,C:white}50%{}",
					"{C:inactive}(加算叠加)"
				}
			},
			c_entr_uruz_providence = {
				name = "野牛符文{C:purple}+{}",
				text = {
					"下一次{C:attention}金钱奖励",
					"提高{X:purple,C:white,E:1}100%{}",
					"{C:inactive}(加算叠加)"
				}
			},
			c_entr_thurisaz = {
				name = "巨人符文",
				text = {
					"复制下一张{C:attention}弃掉{}的卡牌",
					"并加入手牌"
				}
			},
			c_entr_thurisaz_providence = {
				name = "巨人符文{C:purple}+{}",
				text = {
					"复制下一张{C:attention}弃掉{}的卡牌{C:purple,E:1}两次{}",
					"并加入手牌"
				}
			},
			c_entr_ansuz = {
				name = "诸神符文",
				text = {
					"复制下一个获得的",
					"{C:attention}标签{}或{C:attention}符文"
				}
			},
			c_entr_ansuz_providence = {
				name = "诸神符文{C:purple}+{}",
				text = {
					"复制下一个获得的",
					"{C:attention}标签{}或{C:attention}符文",
					"{C:purple,E:1}两次{}"
				}
			},
			c_entr_raido = {
				name = "旅者符文",
				text = {
					"阻止下一次",
					"底注变化"
				}
			},
			c_entr_raido_providence = {
				name = "旅者符文{C:purple}+{}",
				text = {
					"{C:purple,E:1}反转{}下一次",
					"底注变化"
				}
			},
			c_entr_kaunan = {
				name = "火炬符文",
				text = {
					"升级下一次",
					"{C:attention}打出{}的牌型"
				}
			},
			c_entr_kaunan_providence = {
				name = "火炬符文{C:purple}+{}",
				text = {
					"升级下一次",
					"{C:attention}打出{}的牌型",
					"{C:purple,E:1}两次{}"
				}
			},
			c_entr_gebo = {
				name = "赠礼符文",
				text = {
					"生成一张与下一张",
					"{C:attention}售出{}卡牌同类型的牌",
					"{C:inactive}(必须有空间)"
				}
			},
			c_entr_gebo_providence = {
				name = "赠礼符文{C:purple}+{}",
				text = {
					"生成一张与下一张",
					"{C:attention}售出{}卡牌同类型的牌",
					"{C:purple,E:1}(可溢出)"
				}
			},
			c_entr_wunjo = {
				name = "喜悦符文",
				text = {
					"当下一张消耗牌被使用时",
					"生成一张随机{C:purple}符文"
				}
			},
			c_entr_wunjo_providence = {
				name = "喜悦符文{C:purple}+{}",
				text = {
					"当下一张消耗牌被使用时",
					"生成{C:purple}两张{}随机{C:purple}符文"
				}
			},
			c_entr_haglaz = {
				name = "飓风符文",
				text = {
					"{C:red}摧毁{}下一次",
					"打出的手牌"
				}
			},
			c_entr_haglaz_providence = {
				name = "飓风符文{C:purple}+{}",
				text = {
					"{C:red}摧毁{}下一次",
					"打出或{C:purple,E:1}弃掉{}的手牌"
				}
			},
			c_entr_naudiz = {
				name = "需求符文",
				text = {
					"下一次购买的商店物品",
					"可{C:attention}无视金钱{}购买",
					"不足时进入{C:attention}负债"
				}
			},
			c_entr_naudiz_providence = {
				name = "需求符文{C:purple}+{}",
				text = {
					"下一次购买的商店物品",
					"可{C:attention}无视金钱{}购买",
					"{C:purple,E:1}不负债"
				}
			},
			c_entr_isaz = {
				name = "坚冰符文",
				text = {
					"下一次商店",
					"额外出现一张{C:attention}优惠券"
				}
			},
			c_entr_isaz_providence = {
				name = "坚冰符文{C:purple}+{}",
				text = {
					"下一次商店",
					"额外出现一张{C:attention}优惠券",
					"价格为{C:purple,E:1}半价"
				}
			},
			c_entr_jera = {
				name = "丰收符文",
				text = {
					"复制下一张",
					"{C:attention}使用{}的消耗牌"
				}
			},
			c_entr_jera_providence = {
				name = "丰收符文{C:purple}+{}",
				text = {
					"复制下一张",
					"{C:attention}使用{}的消耗牌",
					"{C:purple,E:1}两次"
				}
			},
			c_entr_ihwaz = {
				name = "紫衫符文",
				text = {
					"随机改变下一张",
					"{C:attention}打出{}卡牌的一个属性"
				}
			},
			c_entr_ihwaz_providence = {
				name = "紫衫符文{C:purple}+{}",
				text = {
					"{C:purple,E:1}完全{}随机化下一张",
					"{C:attention}打出{}的卡牌"
				}
			},
			c_entr_perthro = {
				name = "签筒符文",
				text = {
					"下一次重掷",
					"将{C:attention}补货补充包"
				}
			},
			c_entr_perthro_providence = {
				name = "签筒符文{C:purple}+{}",
				text = {
					"下一次重掷",
					"将{C:attention}补货补充包",
					"并{C:purple,E:1}+1{}临时商店槽"
				}
			},
			c_entr_algiz = {
				name = "保护符文",
				text = {
					"防止下一次{C:red}死亡",
					"触发时获得{C:money}$5"
				}
			},
			c_entr_algiz_providence = {
				name = "保护符文{C:purple}+{}",
				text = {
					"防止下一次{C:red}死亡",
					"触发时获得{C:purple,E:1}$10"
				}
			},
			c_entr_sowilo = {
				name = "太阳符文",
				text = {
					"下一次{C:attention}弃掉{}的牌型",
					"获得{C:gold}+2{}升阶强度"
				}
			},
			c_entr_sowilo_providence = {
				name = "太阳符文{C:purple}+{}",
				text = {
					"下一次{C:attention}弃掉{}的牌型",
					"获得{C:purple,E:1}+4{}升阶强度"
				}
			},
			c_entr_tiwaz = {
				name = "提尔符文",
				text = {
					"为下一张{C:attention}抽取{}的卡牌",
					"添加一个随机修改"
				}
			},
			c_entr_tiwaz_providence = {
				name = "提尔符文{C:purple}+{}",
				text = {
					"为下一张{C:attention}抽取{}的卡牌",
					"添加{C:purple,E:1}两个{}随机修改"
				}
			},
			c_entr_berkano = {
				name = "桦木符文",
				text = {
					"生成下一张被{C:red}摧毁",
					"卡牌的{C:attention}两个{}复制"
				}
			},
			c_entr_berkano_providence = {
				name = "桦木符文{C:purple}+{}",
				text = {
					"生成下一张被{C:red}摧毁",
					"卡牌的{C:purple,E:1}三个{}复制"
				}
			},
			c_entr_ehwaz = {
				name = "骏马符文",
				text = {
					"下一次跳过{C:attention}盲注{}时",
					"可进入{C:attention}奖励{}与{C:attention}商店"
				}
			},
			c_entr_ehwaz_providence = {
				name = "骏马符文{C:purple}+{}",
				text = {
					"下一次跳过{C:attention}盲注{}时",
					"可进入{C:attention}奖励{}与{C:attention}商店",
					"且商店槽位{C:purple,E:1}+1"
				}
			},
			c_entr_mannaz = {
				name = "人类符文",
				text = {
					"下一次打开{C:attention}补充包{}",
					"将包含一张{C:spectral}幻灵牌"
				}
			},
			c_entr_mannaz_providence = {
				name = "人类符文{C:purple}+{}",
				text = {
					"下一次打开{C:attention}补充包{}",
					"将包含{C:purple,E:1}两张{}{C:spectral}幻灵牌"
				}
			},
			c_entr_laguz = {
				name = "湖水符文",
				text = {
					"下一次{C:attention}弃牌{}",
					"将返还次数"
				}
			},
			c_entr_laguz_providence = {
				name = "湖水符文{C:purple}+{}",
				text = {
					"下一次{C:attention}弃牌{}",
					"将返还次数",
					"并{C:purple,E:1}暂时+1{}手牌"
				}
			},
			c_entr_ingwaz = {
				name = "天使符文",
				text = {
					"下一次{C:attention}概率判定{}",
					"将{C:green}必定成功"
				}
			},
			c_entr_ingwaz_providence = {
				name = "天使符文{C:purple}+{}",
				text = {
					"下一次{C:attention}概率判定{}",
					"将{C:green}必定成功{}",
					"并有{C:purple,E:1}33%{}概率不消耗此符文"
				}
			},
			c_entr_dagaz = {
				name = "今时符文",
				text = {
					"反转下一张",
					"{C:attention}获得{}的消耗牌效果"
				}
			},
			c_entr_dagaz_providence = {
				name = "今时符文{C:purple}+{}",
				text = {
					"反转下一张",
					"{C:attention}获得{}的消耗牌",
					"并{C:purple,E:1}生成{}一张随机反转消耗牌",
					"{C:inactive}(必须有空间)"
				}
			},
			c_entr_othila = {
				name = "地产符文",
				text = {
					"下一张{C:attention}售出{}的卡牌",
					"获得{C:gold}X3{}金钱"
				}
			},
			c_entr_othila_providence = {
				name = "地产符文{C:purple}+{}",
				text = {
					"下一张{C:attention}售出{}的卡牌",
					"获得{C:purple,C:white,E:1}X5{}金钱"
				}
			},
		},
		Pact = {
			c_entr_avarice = {
				name = "贪婪契约",
				text = {
					"复制你售价最高的小丑",
					"并将所有{C:attention}现有{}和{C:attention}将来{}",
					"的小丑售价变为{C:red}0{}",
					"{C:inactive}(必须有空间，移除负面效果)"
				}
			},
			c_entr_rage = {
				name = "狂怒契约",
				text = {
					"随机{C:red}摧毁{}",
					"{C:attention}整套牌组{}的{C:attention}20%{}",
					"{C:inactive}(最少5张)"
				}
			},
			c_entr_thorns = {
				name = "荆棘契约",
				text = {
					"为{C:attention}#1#{}张随机小丑",
					"施加{C:attention}租用{}与随机版本"
				}
			},
			c_entr_denial = {
				name = "否定契约",
				text = {
					"复制上一次{C:attention}售出{}的卡牌",
					"随后{C:red}放逐{}原卡牌",
					"{C:inactive}(必须有空间)"
				}
			},
			c_entr_chains = {
				name = "锁链契约",
				text = {
					"所有{C:attention}永恒{}扑克牌重新触发",
					"每回合第一张{C:attention}抽牌{}变为永恒"
				}
			},
			c_entr_decay = {
				name = "衰变契约",
				text = {
					"{C:attention}#2#{}种随机牌型降低{C:attention}#1#{}级",
					"你最常用的牌型提升{C:attention}#3#{}级"
				}
			},
			c_entr_envy = {
				name = "嫉妒契约",
				text = {
					"{C:red}摧毁{}一张随机小丑",
					"随机一张小丑重新触发",
					"每回合更换目标"
				}
			},
			c_entr_youth = {
				name = "青春契约",
				text = {
					"{C:attention}-#1#{}底注",
					"随机一张小丑被{C:red}削弱{}",
					"持续{C:attention}#2#{}回合"
				}
			},
			c_entr_shards = {
				name = "碎片契约",
				text = {
					"为一张随机小丑施加{C:dark_edition}碎裂{}",
					"未来{C:red}摧毁{}扑克牌时可能失败"
				}
			},
			c_entr_desire = {
				name = "欲望契约",
				text = {
					"生成{C:attention}#1#{}张随机",
					"{C:spectral}幻灵{}或{C:red}厄兆{}牌",
					"{C:attention}补充包{}价格提高{C:money}50%{}",
					"{C:inactive}(必须有空间)"
				}
			},
			c_entr_ice = {
				name = "寒冰契约",
				text = {
					"兑换{C:attention}#1#{}张随机优惠券",
					"你{C:attention}等级最高{}的牌型",
					"{C:red}无法{}再升级"
				}
			},
			c_entr_gluttony = {
				name = "暴食契约",
				text = {
					"{C:attention}+#1#{}消耗牌槽",
					"{C:red}所有{}消耗牌变为{C:attention}永恒"
				}
			},
			c_entr_rebirth = {
				name = "重生契约",
				text = {
					"扑克牌被{C:attention}复制{}",
					"而非{C:red}摧毁{}",
					"{C:blue}-#1#{}手牌上限"
				}
			},
			c_entr_despair = {
				name = "绝望契约",
				text = {
					"增强{C:attention}整套牌组{}中{C:attention}#1#{}张随机卡牌",
					"并削弱{C:attention}整套牌组{}的{C:attention}#2#%{}",
					"持续{C:attention}#3#{}回合"
				}
			},
			c_entr_strength = {
				name = "力量契约",
				text = {
					"复制你最常用的卡牌{C:attention}#1#{}次",
					"随机一张小丑获得{C:attention}租用"
				}
			},
			c_entr_darkness = {
				name = "黑暗契约",
				text = {
					"为一张随机小丑施加{C:dark_edition}负片{}",
					"扑克牌可能背面朝上被抽取"
				}
			},
			c_entr_freedom = {
				name = "自由契约",
				text = {
					"{C:attention}+#1#{}选择上限",
					"{C:attention}-#2#{}手牌上限"
				}
			},
			c_entr_eternity = {
				name = "永恒契约",
				text = {
					"为你最常用的牌型",
					"增加{C:gold}+#1#{}升阶强度",
					"随机一张小丑变为{C:attention}永恒"
				}
			},
			c_entr_loyalty = {
				name = "忠诚契约",
				text = {
					"每{C:money}$4{}获得$1利息",
					"每手牌的倍率递减{X:mult,C:white}X0.5{}"
				}
			},
			c_entr_brimstone = {
				name = "硫火契约",
				text = {
					"出牌后获得{X:mult,C:white}X3.6{}倍率",
					"{C:blue}-#1#{}出牌次数"
				}
			},
			c_entr_dreams = {
				name = "梦境契约",
				text = {
					"添加{C:attention}#1#{}张随机标签",
					"小盲注不再提供奖励"
				}
			},
			c_entr_energy = {
				name = "能量契约",
				text = {
					"为上一次弃掉的手牌",
					"施加随机版本",
					"{C:red}-#1#{}弃牌次数"
				}
			},
			c_entr_blood = {
				name = "鲜血契约",
				text = {
					"随机将{C:attention}整套牌组{}中{C:attention}#1#{}张",
					"扑克牌链接在一起"
				}
			},
			c_entr_awakening = {
				name = "觉醒契约",
				text = {
					"生成一张随机{C:dark_edition}负片{}优惠券",
					"{C:attention}-#1#{}补充包槽位"
				}
			},
		},
		Other = {
			cry_banana_booster = {
				name = "香蕉补充包",
				text = {
					"包中的所有卡牌",
					"都带有{C:attention}香蕉{}贴纸",
				},
			},
			cry_banana_consumeable = {
				name = "香蕉消耗牌",
				text = {
					"{C:green}#1# / #2#{}概率",
					"使用时无效",
				},
			},
			cry_banana_voucher = {
				name = "香蕉优惠券",
				text = {
					"每回合{C:green}#1# / #2#{}概率",
					"失去此券",
				},
			},
			banana = {
				name = "香蕉",
				text = {
					"{C:green}每回合#1#/#2#{}概率被",
					"摧毁",
				},
			},
			echo_tooltip = {
				name = "(~)$ 回声",
				text = {
					"当这张牌被打出时",
					"同时触发{C:attention}#1#{}"
				}
			},
			temporary_debuff_tooltip = {
				name = "临时削弱",
				text = {
					"在接下来的{C:attention}#1#{}回合内",
					"被削弱"
				}
			},
			inversion_allowed = {
				name = "反转",
				text = {
					"可以被{C:red}反转{}",
					"为{C:red}#1#{}"
				}
			},
			no_downside = {
				name = "拒绝翻面",
				text = {
					"翻面效果被移除",
				}
			},
			no_downside_cond = {
				name = "拒绝翻面",
				text = {
					"当{X:dark_edition,C:white}熵{}",
					"高于{C:attention}100{}时",
					"移除翻面"
				}
			},
			p_entr_twisted_pack_normal = {
				name = "扭曲补充包",
				group_name = "反转牌",
				text = {
					"从最多{C:attention}#2#{V:1}张反转牌中{}",
					"选择{C:attention}#1#{}张，"
				}
			},
			p_entr_twisted_pack_jumbo = {
				name = "巨型扭曲包",
				group_name = "反转牌",
				text = {
					"从{C:attention}#2#{V:1}张反转牌中{}",
					"选择{C:attention}#1#{}张，"
				}
			},
			p_entr_twisted_pack_jumbo_2 = {
				group_name = "反转牌",
				name = "巨型扭曲包",
				text = {
					"从最多{C:attention}#2#张{C:red}反转{}牌中",
					"选择{C:attention}#1#{}张",
					"可立即使用或拉取"
				}
			},
			p_entr_twisted_pack_mega = {
				name = "超级扭曲包",
				group_name = "反转牌",
				text = {
					"从{C:attention}#2#{V:1}张反转牌中{}",
					"选择{C:attention}#1#{}张，"
				}
			},
			p_entr_twisted_pack_mega_2 = {
				group_name = "反转牌",
				name = "超级扭曲包",
				text = {
					"从最多{C:attention}#2#张{C:red}反转{}牌中",
					"选择{C:attention}#1#{}张",
					"立即使用或拉取"
				}
			},
			p_entr_blind = {
				name = "盲注包",
				group_name = "盲注",
				text = {
					"从{C:attention}#2#{}张{C:attention}盲注{}中",
					"选择{C:attention}#1#{}张"
				}
			},
			p_entr_unbounded = {
				name = "无垠包",
				text = {
					"从最多{C:attention}#2#{C:spectral}张幻灵卡牌中",
					"选择{C:attention}#1#{}张",
					"{s:0.8,C:inactive}(由无垠标签生成)"
				}
			},
			p_entr_reference_pack = {
				name = "典故包",
				group_name = "反转牌",
				text = {
					"从{C:attention}#2#{}张{C:attention}用典小丑{}中",
					"选择{C:attention}#1#{}张"
				}
			},
			p_entr_voucher_pack = {
				name = "优惠券包",
				group_name = "优惠券",
				text = {
					"从最多{C:attention}#2#{}张{C:attention}优惠券{}中",
					"选择{C:attention}#1#{}张"
				}
			},
			p_entr_twisted_pack_normal_2 = {
				group_name = "反转牌",
				name = "扭曲包",
				text = {
					"从最多{C:attention}#2#张{C:red}反转{}牌中",
					"选择{C:attention}#1#{}张",
					"可立即使用或拉取"
				}
			},
			cry_multiuse = {
				name = "多次使用",
				text = {
					"{C:inactive}剩余使用次数：({V:1}#1#{C:inactive})"
				}
			},
			antipattern_pair = {
				name = "反模式",
				text = {
					"#1#次出牌后的手牌：",
					"#2# #3# #4# #5# #6# #7#",
					"#8# #9# #10# #11# #12#"
				}
			},
			undiscovered_rune = {
				name = "未发现",
				text = {
					"在未设定的游戏中",
					"购买或使用此牌",
					"以了解其效果"
				}
			},
			undiscovered_pact = {
				name = "未发现",
				text = {
					"在未设定的游戏中",
					"购买或使用此牌",
					"以了解其效果"
				}
			},
			undiscovered_fraud = {
				name = "未发现",
				text = {
					"在未设定的游戏中",
					"购买或使用此牌",
					"以了解其效果"
				}
			},
			undiscovered_omen = {
				name = "未发现",
				text = {
					"在未设定的游戏中",
					"购买或使用此牌",
					"以了解其效果"
				}
			},
			undiscovered_star = {
				name = "未发现",
				text = {
					"在未设定的游戏中",
					"购买或使用此牌",
					"以了解其效果"
				}
			},
			undiscovered_command = {
				name = "未发现",
				text = {
					"在未设定的游戏中",
					"购买或使用此牌",
					"以了解其效果"
				}
			},
			undiscovered_transient = {
				name = "未发现",
				text = {
					"在未设定的游戏中",
					"购买或使用此牌",
					"以了解其效果"
				}
			},
			entr_pinned = {
				name = "固定",
				text = {
					"{C:attention}无法{}重掷",
					"{C:attention}下一回合商店{}",
					"必定出现"
				}
			},
			entr_hotfix = {
				name = "热更新",
				text = {
					"{C:attention}无法{}被削弱"
				}
			},
			entr_pseudorandom = {
				name = "伪随机",
				text = {
					"所有{C:red}概率{}",
					"在下一回合前",
					"必定触发"
				}
			},
			temporary = {
				name = "临时",
				text = {
					"回合结束时",
					"{C:red}摧毁"
				}
			},
			superego = {
				name = "预估",
				text = {
					"出售时生成{C:attention}#1#{}张复制",
					"每 2 回合增加 1 张"
				}
			},
			desync = {
				name = "延迟",
				text = {
					"{C:dark_edition}强制触发{}",
					"在{C:attention}#1#{}时",
					"打出后随机改变"
				}
			},
			entr_aleph = {
				name = "阿列夫",
				text = {
					"{C:attention}永远无法{}被移除"
				}
			},
			entr_copper_sticker = {
				name = "铜贴纸",
				text = {
					"使用此小丑",
					"在{C:attention}铜注{}",
					"难度下获胜"
				}
			},
			entr_platinum_sticker = {
				name = "铂金贴纸",
				text = {
					"使用此小丑",
					"在{C:attention}铂金注{}",
					"难度下获胜"
				}
			},
			entr_meteorite_sticker = {
				name = "陨石贴纸",
				text = {
					"使用此小丑",
					"在{C:attention}陨石注{}",
					"难度下获胜"
				}
			},
			entr_obsidian_sticker = {
				name = "黑曜贴纸",
				text = {
					"使用此小丑",
					"在{C:attention}黑曜注{}",
					"难度下获胜"
				}
			},
			entr_iridium_sticker = {
				name = "铱贴纸",
				text = {
					"使用此小丑",
					"在{C:attention}铱注{}",
					"难度下获胜"
				}
			},
			entr_zenith_sticker = {
				name = "天顶贴纸",
				text = {
					"使用此小丑",
					"在{C:entr_zenith}天顶注{}",
					"难度下获胜"
				}
			},
			entr_crimson_seal = {
				name = "绯红蜡封",
				text = {
					"重新触发相邻卡牌"
				}
			},
			entr_sapphire_seal = {
				name = "青玉蜡封",
				text = {
					"{C:attention}计分{}时生成一张",
					"对应牌型的{C:purple}恒星牌{}",
					"{C:inactive}(必须有空间)"
				}
			},
			entr_silver_seal = {
				name = "银色蜡封",
				text = {
					"计分时每张",
					"剩余手牌获得{C:gold}$1{}"
				}
			},
			entr_pink_seal = {
				name = "粉色蜡封",
				text = {
					"弃掉时生成一张",
					"{C:red}反转{}卡牌",
					"并{C:attention}摧毁{}自身",
					"{C:inactive}(必须有空间)"
				}
			},
			entr_verdant_seal = {
				name = "葱茏蜡封",
				text = {
					"若此牌为唯一计分牌",
					"打出时生成一张",
					"{C:red}指令{}卡牌"
				}
			},
			entr_cerulean_seal = {
				name = "天蓝蜡封",
				text = {
					"{C:attention}计分{}时生成三张",
					"对应牌型的{C:dark_edition}负片{}{C:purple}恒星牌{}",
					"并{C:red}摧毁{}打出的手牌"
				}
			},
			entr_ornate_seal = {
				name = "华紫蜡封",
				text = {
					"被{C:red}摧毁{}时",
					"生成一张{C:purple}符文{}卡牌",
					"{C:inactive}(必须有空间)"
				}
			},
			entr_amber_seal = {
				name = "琥珀蜡封",
				text = {
					"被{C:attention}复制{}或{C:attention}生成{}时",
					"生成一张{C:red}契约{}卡牌",
					"并{C:red}摧毁{}自身",
					"{C:inactive}(必须有空间)"
				}
			},
			entr_mini_seal = {
				name = "迷你蜡封",
				text = {
					"{C:green}#1# / #2#{}概率",
					"计分后{C:red}摧毁{}",
					"相邻卡牌"
				}
			},
			entr_sharp_seal = {
				name = "锋利蜡封",
				text = {
					"{C:green}#1# / #2#{}概率",
					"计分前升级",
					"此牌的增强"
				}
			},
			entr_vantablack_seal = {
				name = "纳米黑蜡封",
				text = {
					"选择时",
					"{C:attention}+1{}选择上限"
				}
			},
			link = {
				name = "连锁",
				text = {
					"与其他共享链接的卡牌",
					"共享所有修改",
					"{C:inactive}(#1#)"
				}
			},
			xmult_bonus = {
				name = "额外倍率",
				text = {
					"{X:red,C:white}X#1#{}",
					"额外倍率"
				}
			},
			entr_yellow_sign = {
				name = "黄印",
				text = {
					"{C:attention}临时{}视为",
					"{C:diamonds}方片"
				}
			},
			scarred = {
				name = "疤痕",
				text = {
					"{C:attention}不会{}在弃牌时",
					"被移出手牌",
					"仍正常抽取额外卡牌"
				}
			},
			tmtrainer_dummy = {
				name = "故障效果",
				text = {
					"#1#",
					"#2#"
				}
			},
			entr_pure = {
				name = "纯粹",
				text = {
					"此小丑的数值",
					"无法改变"
				}
			}
		},

		Partner = {
			pnr_entr_parakmi = {
				name = "泰哈奥斯",
				text = {
					"补充包可能被",
					"随机替换为",
					"其他补充包"
				}
			}
		},
		TheFamily_Tab = {
			entr_rune_tags = {
				name = "符文标签",
				text = {
					"隐藏或显示符文标签"
				}
			}
		},
		TheFamily_Group = {
			entr_misc_group = {
				name = "杂项（熵模组）",
				text = {
					"切换熵模组添加的各类UI元素"
				}
			}
		}
	},
	misc = {
		tutorial = {
			cry_intro_1 = {
				"你好，我是{C:attention}约瑟夫·J·小丑{}！",
				"欢迎来到{C:entr_entropic,E:1}熵{}模组！"
			},
			cry_intro_2 = {
				"看起来你从未在此存档",
				"体验过{C:entr_entropic,E:1}熵{}模组。",
				"让我来为你介绍！"
			},
			cry_intro_3 = {
				"*长出双手*"
			},
			cry_intro_4 = {
				"很难用几句话概括本模组，",
				"但可以肯定的是，你将迎来",
				"{C:entr_entropic,E:1}更加狂野{}的旅程！",
				"这可不是你熟悉的{C:attention}Balatro{}……"
			},
			cry_intro_5 = {
				"从这些{C:entr_entropic}游戏设定{}可以看出，",
				"我喜欢字母{C:attention}E{}。",
				"选择一个设定，我来详细说明……",
				"{s:0.8}注意：设定平衡仍在大力调整中，",
				"{s:0.8}预计会频繁变动！"
			},
			cry_modest_1 = {
				"想要接近原版的体验？",
				"那就选择{C:entr_entropic}以太{}设定！"
			},
			cry_modest_2 = {
				"即便如此，仍需小心隐藏在",
				"熵模组中的各种机制！你永远不知道",
				"下一回合会遇到什么……"
			},
			cry_mainline_1 = {
				"想{E:1,C:attention}打破{}游戏？好消息，",
				"你无需走极端就能做到！"
			},
			cry_mainline_2 = {
				"事情在这里依然很疯狂，但你将有机会",
				"体验{C:entr_entropic}数字疯涨{}。",
				"只是别太放松……"
			},
			cry_mainline_3 = {
				"因为你确实会变得更强大，",
				"但我也设计了一些",
				"{E:1,C:dark_edition}Boss{}，可能会让你后悔选择这个{C:entr_entropic}游戏集{}……"
			},
			cry_madness_1 = {
				"你想彻底{C:red,E:1}毁灭{}你的硬盘？",
				"太有趣了！{C:entr_entropic}至高游戏集{}的口号是：",
				"'平衡？{E:1,C:red}那是什么！'"
			},
			cry_madness_2 = {
				"我花了数周不眠不休、靠{C:green}魔爪能量饮料{}续命",
				"的夜晚，只为确保这个游戏预设",
				"{C:entr_entropic}绝对平衡{}，只为你！"
			},
			cry_madness_3 = {
				"你将解锁所有内容，释放",
				"{C:red,E:1}熵的全部力量{}！",
				"只是小心别让游戏{C:attention,E:1}崩溃{}，",
				"因为很可能你还没输，它就先崩溃了……"
			},
		},
		achievement_names = {
			ach_entr_event_horizon = "视界",
			ach_entr_here_comes_the_sun = "如日亲临",
			ach_entr_megalyteri = "至大者",
			ach_entr_acheros = "阿刻戎",
			ach_entr_rift = "裂隙",
			ach_entr_katevaino = "卡泰维诺",
			ach_entr_joy_to_the_world = "普世欢腾",
			ach_entr_suburban_jungle = "郊区丛林",
			ach_entr_f_x = "f(x)",
			ach_entr_c_sharp = "完美主义者#"
		},
		achievement_descriptions = {
			ach_entr_event_horizon = "使用 '#定义' 将方尖碑变成啜泣小丑",
			ach_entr_here_comes_the_sun = "获得一个晴朗小丑",
			ach_entr_megalyteri = "在德卡提拉上达到 50000 倍率",
			ach_entr_acheros = "击败底注 32 的Boss盲注：无尽之熵",
			ach_entr_rift = "在分岔路径中击败底注 8",
			ach_entr_katevaino = "对泰哈奥斯使用 '超脱'",
			ach_entr_joy_to_the_world = "用喜悦符文生成另一个喜悦符文",
			ach_entr_suburban_jungle = "在拥有来自Entropy的传奇小丑时下打出一手葫芦",
			ach_entr_f_x = "在拥有不定积分的情况下打出一手导数",
			ach_entr_c_sharp = "发现并解锁所有原版与熵模组的收藏条目"
		},
		suits_plural = {
			entr_nilsuit = "无色",
		},
		suits_singular = {
			entr_nilsuit = "无色",
		},
		ranks = {
			entr_nilrank = "0"
		},
		dictionary = {
			k_corrupted_ex = "腐化！",
			k_recovered_ex = "恢复！",
			cry_demicolon = "半触发！",
			k_ee_hand_1 = "出牌时，随机一张牌变为晴朗",
			k_ee_hand_2 = "卡牌无法被削弱",
			k_ee_hand_3 = "出牌时所有小丑数值 ×1.666",
			k_ee_hand_4 = "强制触发一个随机小丑",

			k_ee_discard_1 = "弃牌时，若仅弃一张牌，将其版本扩散",
			k_ee_discard_2 = "为打出的牌生成负片香蕉复制",
			k_ee_discard_3 = "每弃一张牌获得一个飞升标签",
			k_ee_discard_4 = "倍率 ^^3",

			k_before = "计分前：",
			k_pre_joker = "小丑计分前：",
			k_joker_main = "主计分阶段：",
			k_individual = "此牌触发时：",
			k_pre_discard = "弃牌时：",
			k_remove_playing_cards = "卡牌被摧毁时：",
			k_setting_blind = "进入盲注时：",
			k_ending_shop = "离开商店时：",
			k_reroll_shop = "重掷商店时：",
			k_selling_card = "售出卡牌时：",
			k_using_consumeable = "使用消耗牌时：",
			k_playing_card_added = "添加手牌时：",

			k_tmtmult = "+??? 倍率",
			k_tmtchips = "+??? 筹码",

			k_tmtxmult = "X??? 倍率",
			k_tmtxchips = "X??? 筹码",

			k_tmtemult = "^??? 倍率",
			k_tmtechips = "^??? 筹码",

			k_tmtdollars = "+??? 金钱",
			k_tmtjoker_random = "生成一个随机小丑",
			k_tmtjoker_choose_rarity = "生成一个随机稀有度的小丑",
			k_tmtedition = "为随机小丑添加版本",
			k_tmtante = "-??? 底注",
			k_tmtconsumable = "生成一张随机消耗牌",
			k_tmtenhancement_play = "一张出牌获得新增强",
			k_tmtenhancement_hand = "一张手牌获得新增强",
			k_tmtrandom = "触发3个随机效果",

			k_entr_entropic = "熵化",
			k_entr_reverse_legendary = "传奇？",
			k_entr_zenith = "天顶",
			k_fraud = "欺诈",
			b_fraud_cards = "欺诈牌",

			k_command = "指令",
			b_command_cards = "指令牌",

			k_omen = "厄兆",
			b_omen_cards = "厄兆牌",

			k_transient = "瞬变",
			b_transient_cards = "瞬变牌",

			k_mtx = "MTX",
			b_mtx_cards = "MTX牌",

			k_inverted = "反转",
			k_inverted_pack = "反转包",
			k_voucher_pack = "优惠券包",
			b_inverted_cards = "反转牌",

			entr_code_sudo = "覆盖",
			entr_code_sudo_previous = "覆盖为前一个",

			k_entr_faster_ante_scaling = "拥有熵化小丑时，盲注需求增长更快",
			k_entr_entropic_music = "熵化小丑（希腊语小丑，由 gemstonez 制作）",
			k_entr_blind_tokens = "启用盲注代币",
			k_credits = "制作人员",
			k_code = "程序",
			k_idea = "创意",
			k_art = "美术",
			k_music = "音乐",

			k_star = "恒星",
			b_star_cards = "恒星牌",
			k_planet_multiverse = Cryptid_config.family_mode and "多元宇宙" or "整个TMD多元宇宙",
			k_planet_binary_star = "双星系统",
			k_planet_dyson_swarm = "恒星巨构",

			k_entropy = "熵",

			k_cblind = "盲注代币",
			b_cblind_cards = "盲注代币",
			k_entr_base = "基础",

			k_blind_pack = "盲注包",
			b_blind_cards = "盲注",

			k_reference_pack = "典故包",
			b_reference_cards = "用典小丑",
			b_buy_slot = "+小丑槽",
			b_sell_slot = "-小丑槽",
			b_transition = "过渡",

			b_cant_reroll = "想都别想",

			ph_blind_score_less_than = "得分低于",
			entr_nadir_placeholder = "3倍基础",

			ph_no_decks = "本局未购买牌组",
			ph_decks_bought = "本局已购买牌组",

			ph_cards_defined = "本局重定义次数",
			ph_definitions = "本局无重定义",
			ph_leftright = "左侧卡牌始终转换为右侧卡牌",
			b_definitions = "定义",
			entr_ascended = "飞升！",
			k_entr_freebird = "反现实（播放《Freebird》——Lynyrd Skynyrd，版权受限）",

			entr_gameset_modest = "以太",
			entr_gameset_mainline = "极乐",
			entr_gameset_madness = "至高",
			entr_gameset_custom = "涌现",

			entr_b_reset_gameset_modest = "重置游戏设定（以太）",
			entr_b_reset_gameset_mainline = "重置游戏设定（极乐）",
			entr_b_reset_gameset_madness = "重置游戏设定（至高）",

			entr_opened = "已开启！",
			entr_kiy_banished = "已被放逐。",

			k_saved_heoric = "并非英雄！",
			k_saved_just = "并不正义！",
			b_on = "启用",
			b_off = "禁用",
			b_enabled = "已启用",
			b_disabled = "已禁用",
			b_cycle = "循环",
			b_true_endless = "真无尽模式",
			k_entr_glitched = "使用新故障着色器（由 cassknows 制作）",
			ph_hand_notreal = "函数 pokerhand 参数错误",

			cry_notif_antireal_1 = "反现实小丑",
			cry_notif_antireal_2 = "版权提示",
			cry_notif_antireal_d1 = "反现实小丑播放的歌曲《Freebird》",
			cry_notif_antireal_d2 = "受版权保护，不得用于",
			cry_notif_antireal_d3 = "直播或视频内容。",

			k_entr_omega_aleph = "阿列夫贴纸阻止自毁（不稳定，需重启游戏）",
			k_entr_corrupted_speed = "腐化牌组循环速度 (%)",

			k_saved_skullcry = "天顶注的力量拯救了你",

			b_change_path_1 = "进入",
			b_change_path_2 = "翻转面",
			b_change_path_3 = "返回",
			b_infinity = "无限",

			b_daily_challenge = "每日挑战",

			flipside_none = '无',
			flipside_minimal = '极简',
			flipside_full = '完整',

			flipside_info = '持有反转面时显示反转效果',
			curses_enabled = "在黑曜注之外也启用诅咒",

			b_stat_CBlind = "盲注代币",
			b_stat_Fraud = "欺诈",
			b_stat_Star = "恒星",
			b_stat_Omen = "厄兆",
			b_stat_Command = "指令",
			k_upgrade_atomikos = "已摧毁！",
			k_destroyed_ex = "已摧毁！",
			k_new = "new();",
			k_ascended_ex = "已晋升",

			k_rune = "符文",
			k_rune_pack = "符文包",
			b_rune_cards = "符文",
			k_pact = "契约",
			k_pact_pack = "恶魔交易",
			b_pact_cards = "契约",

			cry_set_music = "音乐",

			k_inactive = "未激活！",
			k_randomised = "已随机！",
			k_saved_algiz = "保护符文拯救了你",
			k_undebuffed_ex = "已解除削弱！",
			k_spatial_anomaly = "空间异常",

			k_curse_blind = "致盲诅咒",
			k_curse_blind_desc = "商店卡牌可能隐藏",

			k_curse_darkness = "黑暗诅咒",
			k_curse_darkness_desc = "补充包选项减少",

			k_curse_lost = "迷途诅咒",
			k_curse_lost_desc = "无小盲注",

			k_curse_maze = "迷宫诅咒",
			k_curse_maze_desc = "盲注顺序随机化",

			k_level_chips = "每级筹码",
			k_level_mult = "每级倍率",
			k_level_asc = "每级飞升值",
			k_star_q = "恒星？",
			k_moon = "卫星",
			k_satellite = "人造卫星",

			k_joker_in_greek = "希腊语小丑",
			k_mirrored_in_crimson = "猩红镜像",
			k_freebird = "Freebird",
			k_portal_reference = "她杀死你的那一刻",
			k_entropy_is_endless = "熵永无尽头",

			k_plus_rune = "+1 符文",
			k_plus_star = "+1 恒星",
			k_plus_pact = "+1 契约",
			k_plus_omen = "+1 厄兆",
			k_plus_tag = "+1 标签",
			k_plus_inverted = "+1 扭曲牌",

			k_switch_ex = "切换！",
			k_bounce_ex = "弹!"
		},
		v_dictionary = {
			card_art = "卡牌美术: #1#",
			shader = "着色器: #1#",
			wish = "愿望: #1#",
			cry_art = { "美术: #1#" },
			cry_code = { "程序: #1#" },
			cry_idea = { "创意: #1#" },
			a_eqmult = { "倍率 = #1#" },
			a_twisted = { "+#1# 扭曲" },
		},
		labels = {
			banana = "香蕉",
			entr_pinned = "反转",
			entr_hotfix = "热更新",
			temporary = "临时",
			entr_pseudorandom = "伪随机",
			link = "连锁",
			superego = "预估",
			entr_sunny = "晴朗",
			entr_solar = "太阳",
			entr_neon = "霓虹",
			entr_lowres = "低分辨率",
			entr_kaleidoscopic = "万花筒",
			entr_fractured = "碎裂",
			entr_freaky = "怪异",
			entr_yellow_sign = "黄印",
			scarred = "疤痕",
			desync = "延迟",
			entr_aleph = "阿列夫",
			entr_pure = "纯粹",
			entr_crimson_seal = "绯红蜡封",
			entr_sapphire_seal = "青玉蜡封",
			entr_silver_seal = "银色蜡封",
			entr_pink_seal = "粉色蜡封",
			entr_verdant_seal = "葱茏蜡封",
			entr_cerulean_seal = "天蓝蜡封",
			entr_ornate_seal = "华紫蜡封",
			entr_amber_seal = "琥珀蜡封",
			entr_mini_seal = "迷你蜡封",
			entr_sharp_seal = "锋利蜡封",
			entr_vantablack_seal = "纳米黑蜡封",
		},
		poker_hands = {
			["entr_All"] = Cryptid_config.family_mode and "万物" or "字面上TMD宇宙万物",
			["entr-Flesh"] = "血肉",
			["entr-Straight_Flesh"] = "血肉顺子",
			["entr-Flesh_House"] = "血肉葫芦",
			["entr-Flesh_Five"] = "血肉五条",
			["entr_derivative"] = "导数"
		},
		poker_hand_descriptions = {
			entr_All = {
				"包含一手标准52张牌",
				"牌组中的每一张牌。",
				"加上一整套Optics",
				"再加上每种花色的0点数牌",
				Cryptid_config.family_mode and "上帝已死" or "去NMD，上帝已死",
			},
			entr_derivative = {
				"5张无标准点数和花色的牌"
			}
		},
		challenge_names = {
			c_entr_lifelight = "生命之光",
			c_entr_vesuvius = "维苏威火山",
			c_entr_hyperaccelerated_bongcloud_opening = "超高速糊逼开局",
			c_entr_hyperbolic_chamber = "超地狱级密室逃脱",
			c_entr_daily = "每日挑战",
			c_entr_paycheck_to_paycheck = "月光族",
			c_entr_riffle_shuffle = "鸽尾洗牌法",
			c_entr_variety_content = "千变万化",
			c_entr_phantom_hand_syndrome = "幻手综合征",
			c_entr_eco_friendly = "环境友好",
		},
		v_text = {
			ch_c_entr_no_planets = { "商店中不会出现星球牌" },
			ch_c_entr_starting_ante_mten = { "以底注-10开始" },
			ch_c_entr_reverse_redeo = { "反转回溯的底注改变方向" },
			ch_c_entr_set_seed = { "设置种子: #1#" }
		},
		quips = {
			entr_lq_ee_1 = {
				"菜就多练"
			},
			entr_lq_ee_2 = {
				"你想打败我恐怕",
				"还早了1000年呢！",
			},
			entr_lq_ee_3 = {
				"或许你早就",
				"应该长按R了!"
			},
			entr_lq_ee_4 = {
				"于是故事的最后",
				"一切的一切",
				"皆屈服于熵..."
			},
			entr_lq_ee_5 = {
				"看上去，你还",
				"不够熵嘛！"
			},
			entr_lq_ee_6 = {
				"或许，你应该",
				"被多触发几次！"
			},
			entr_tq_ee_half = {
				"就这点",
				"本事吗？"
			},
			entr_lq_ee_7 = {
				"或许，你得试试",
				"加点其他mod!"
			},
			entr_lq_ee_8 = {
				"别哭，",
				"这只是个游戏...",
			},
			entr_lq_ee_9 = {
				"你真的",
				"有在努力吗？"
			},
			entr_lq_ee_10 = {
				"或许你应该，",
				"放弃挑战我！"
			},
			entr_lq_ee_revived = {
				"你真的觉得",
				"那会有用吗？",
			},
			entr_wq_ee_1 = {
				"什？",
			},
			entr_wq_ee_2 = {
				"啥！？"
			},
			entr_wq_ee_3 = {
				"你是怎么..."
			},
			entr_wq_ee_4 = {
				"揭露，你的秘密！",
			},
			entr_wq_ee_5 = {
				"那可真是",
				"有够熵的！"
			},
			entr_lq_1 = {
				"看上去",
				"命运终于抓住了你。"
			},
			entr_lq_2 = {
				"这只是一个必然的结果。"
			},
			entr_lq_3 = {
				"只管，",
				"再试一次"
			},
			entr_lq_4 = {
				"下一次，",
				"祝你好运"
			},
			entr_wq_1 = {
				"你还挺",
				"厉害的哈？"
			},
			entr_wq_2 = {
				"熵的力量",
				"照耀于你"
			},
			entr_wq_3 = {
				"我就知道",
				"我可以相信你"
			},
			entr_wq_4 = {
				"干得漂亮 现在去挑战",
				"铱金注吧"
			},
		},
		dictionary = {
			k_entr_profile_prefix = "为熵启用自定义配置",
			k_saved_heroic = "非英雄模式！"
		},
	}
}
