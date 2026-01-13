-- this is just for CardSleeves, tutorials and notifications
return {
    translator = {
        ":)"
    }
	descriptions = {
		Mod = {
			mayhem = {
				name = 'Mayhem',
				text = {
					"将{C:dark_edition}融合{}兼容的{C:attention}小丑牌{}置入{C:attention}大型融合链{}中", 
					"可获得{C:may_ethereal,E:1}极致强力{}的新小丑牌并{C:mult,E:1}彻底瓦解Balatro{}",
					"但请{C:green}小心{}！{C:may_col_mayhem_gradient}混沌浩劫{}将{C:mult,E:1}猛烈反噬{}", 
					"若想{C:mult,E:1}见证游戏彻底崩坏{}且{C:dark_edition,E:1}不受阻碍{}", 
					"请在{C:may_col_eternum_green,E:1}永恒模式{}下游玩",
					" ", 
					"当前推荐模式为{C:may_col_mayhem_gradient,E:1}混沌浩劫{}，",
					"该模式下所有近期{C:chips}平衡性调整{}均会生效",
					" ",
					"{C:green,E:1,s:2}感谢游玩！{}", 
				}
			}, 
		}, 
		Spectral = {
			c_cry_pointer = {
				name = "指针://",
				text = {
					"创建一张{C:cry_code}自定义卡牌{}",
					"{C:inactive,s:0.8}(神话级及以上小丑牌、尧塔牌与",
					"{C:inactive,s:0.8}充能消耗牌除外)",
				},
			},
		},
		Sleeve = {
			sleeve_may_orange_sleeve = {
				name = "橙色牌套",
				text = { "{C:attention}+#1# 手牌上限{}" }
			},
			sleeve_may_orange_sleeve_alt = {
				name = "橙色牌套",
				text = { "{C:attention}+#1# 手牌上限{}" }
			},
			
			sleeve_may_purple_sleeve = {
				name = "紫色牌套",
				text = { 
					"可从{C:attention}补充包{}中",
					"多选{C:green}1张卡牌{}"
				}
			},
			sleeve_may_purple_sleeve_alt = {
				name = "紫色牌套",
				text = { 
					"可从{C:attention}补充包{}中",
					"选取{C:green}全部卡牌{}"
				}
			},
			
			sleeve_may_pink_sleeve = {
				name = "粉色牌套",
				text = { 
					"盲注目标额度 {X:attention,C:white}X#1#{}"
				}
			},
			sleeve_may_pink_sleeve_alt = {
				name = "粉色牌套",
				text = { 
					"Boss盲注额度 {X:attention,C:white}X0.5{}"
				}
			},
			
			sleeve_may_lime_sleeve = {
				name = "青柠牌套",
				text = { 
					"{C:attention}+1{} 个{C:attention}商店{}{C:green}优惠券{}槽位"
				}
			},
			sleeve_may_lime_sleeve_alt = {
				name = "青柠牌套",
				text = { 
					"商店中{C:attention}+1{}个{C:green}优惠券{}槽位",
					"选择{C:attention}盲注{}时，为牌组中{C:attention}所有卡牌{}",
					"附加{C:attention}铜质蜡封{}"
				}
			},
			
			sleeve_may_brown_sleeve = {
				name = "棕色牌套",
				text = { 
					"{C:attention}出牌{}额外提供{X:attention,C:white}X10{} {C:chips}筹码{}"
				}
			},
			sleeve_may_brown_sleeve_alt = {
				name = "棕色牌套",
				text = { 
					"{C:attention}出牌{}提供{X:chips,C:white}X筹码{}，",
					"数额基于牌面点数"
				}
			},
			
			sleeve_may_gray_sleeve = {
				name = "灰色牌套",
				text = { 
					"牌组中所有{C:attention}卡牌{}初始自带",
					"{C:attention}随机{} {C:dark_edition}蜡封{}"
				}
			},
			sleeve_may_gray_sleeve_alt = {
				name = "灰色牌套",
				text = { 
					"牌组中所有{C:attention}卡牌{}初始自带",
					"{C:attention}随机{} {C:dark_edition}蜡封{}",
					"选择{C:attention}盲注{}时，为牌组中",
					"所有{C:attention}无蜡封卡牌{}附加{C:dark_edition}蜡封{}"
				}
			},
			
			sleeve_may_turqoise_sleeve = {
				name = "青绿牌套",
				text = { 
					"商店中所有{C:attention}卡牌{}",
					"{C:money}售价{}降低{C:attention}25%{}"
				}
			},
			sleeve_may_turqoise_sleeve_alt = {
				name = "青绿牌套",
				text = { 
					"商店中所有{C:attention}卡牌{}",
					"{C:money}售价{}降低{C:attention}25%{}",
					"购买的{C:attention}物品{}有固定{C:green}1/5{}概率",
					"获得{C:attention}全额退款{}"
				}
			},
			
			sleeve_may_blurple_sleeve = {
				name = "蓝紫牌套",
				text = { 
					"开局携带一张随机{X:mult,C:white}稀有{}",
					"{C:attention}小丑牌{}"
				}
			},
			sleeve_may_blurple_sleeve_alt = {
				name = "蓝紫牌套",
				text = { 
					"开局携带一张随机{X:legendary,C:white}传说{}",
					"{C:attention}小丑牌{}"
				}
			},
			sleeve_may_monochrome_sleeve = {
				name = "单色牌套",
				text = { 
					"开局携带{C:attention}5{}张{C:dark_edition}负片{}，",
					"来自一张随机{X:green,C:white}罕见{} {C:attention}小丑牌{}的复制品"
				}
			},
			sleeve_may_monochrome_sleeve_alt = {
				name = "单色牌套",
				text = { 
					"选择{C:attention}Boss盲注{}时，",
					"生成一张随机{C:dark_edition}负片{}",
					"{X:uncommon,C:white}罕见{} {C:attention}小丑牌{}"
				}
			},
			
			sleeve_may_rainbow_sleeve = {
				name = "彩虹牌套",
				text = { 
					"{C:chips}+1出牌次数{}、{C:mult}+1弃牌次数{}与{C:attention}+1手牌上限{}",
					"盲注目标额度{X:attention,C:white}X0.9{}",
					"开局额外获得{C:money}$10{}",
					"及一张随机{X:mult,C:white}稀有{} {C:attention}小丑牌{}"
				}
			},
			sleeve_may_rainbow_sleeve_alt = {
				name = "彩虹牌套",
				text = { 
					"商店中所有{C:attention}卡牌{}",
					"{C:money}售价{}降低{C:attention}25%{}",
					"{C:attention}出牌{}额外提供{X:attention,C:white}X10{} {C:chips}筹码{}",
					"牌组中所有{C:attention}卡牌{}初始自带",
					"一道{C:attention}随机{} {C:dark_edition}蜡封{}",
					"可从{C:attention}补充包{}中",
					"多选{C:green}1张卡牌{}",
					"每{C:mult}弃牌{}1次，{C:attention}回合结束时{}",
					"获得{C:money}$1{}"
				}
			},
			
			sleeve_may_aaaa_sleeve = {
				name = "AAAA牌套",
				text = { 
					"开局携带{C:attention}AAAA{}",
					"及一副仅含{C:attention}A{}的牌组"
				}
			},
			sleeve_may_aaaa_sleeve_alt = {
				name = "AAAA牌套",
				text = { 
					"开局携带{C:dark_edition}累计之牌{}"
				}
			},
			
			sleeve_may_unstable_sleeve = {
				name = "失稳牌套",
				text = { 
					"开局携带{C:dark_edition}万象崩解{}"
				}
			},
			sleeve_may_unstable_sleeve_alt = {
				name = "失稳牌套",
				text = { 
					"{C:spectral}创生{}使用时",
					"{C:attention}不会提高底注{}"
				}
			},
			
			sleeve_may_stellar_sleeve = {
				name = "星界牌套",
				text = { 
					"选择{C:attention}盲注{}时",
					"生成{C:dark_edition}负片{}的{C:attention}马塔卡{}复制品"
				}
			},
			sleeve_may_stellar_sleeve_alt = {
				name = "星界牌套",
				text = { 
					"{C:purple}牌型{}升级时，",
					"获得{X:purple,C:white}X2{} {C:may_interdimensional}层级{}的",
					"{C:mult}倍率{}与{C:chips}筹码{}"
				}
			},
			
			sleeve_may_mythic_sleeve = {
				name = "神话牌套",
				text = { 
					"开局携带一张随机",
					"{X:may_mythic,C:white}神话{} {C:attention}小丑牌{}"
				}
			},
			sleeve_may_mythic_sleeve_alt = {
				name = "神话牌套",
				text = { 
					"{X:may_mythic,C:white}神话{} {C:attention}小丑牌{}",
					"提供{X:mult,C:white}^^3{}倍率"
				}
			},
			
			sleeve_may_transcendent_sleeve = {
				name = "超验牌套",
				text = { 
					"开局携带一张随机",
					"{X:dark_edition,C:white}超验{} {C:attention}小丑牌{}",
					"{C:chips}-1出牌次数{}与{C:mult}-1弃牌次数{}"
				}
			},
			sleeve_may_transcendent_sleeve_alt = {
				name = "超验牌套",
				text = { 
					"开局额外携带一张随机",
					"{X:may_interdimensional,C:white}次元{} {C:attention}小丑牌{}"
				}
			},
			
			sleeve_may_surreal_sleeve = {
				name = "幻梦牌套",
				text = { 
					"开局携带一张随机",
					"{X:may_surreal,C:white}幻梦{} {C:attention}小丑牌{}",
					"{C:chips}-2出牌次数{}"
				}
			},
			sleeve_may_surreal_sleeve_alt = {
				name = "幻梦牌套",
				text = { 
					"{C:spectral}名望{}无次要效果{}"
				}
			},
			
			sleeve_may_interdimensional_sleeve = {
				name = "次元牌套",
				text = { 
					"开局携带一张随机",
					"{X:may_interdimensional,C:white}次元{} {C:attention}小丑牌{}",
					"{C:chips}-1出牌次数{}、{C:mult}-1弃牌次数{}、{C:attention}-1手牌上限{}",
					"及{C:attention}-1小丑槽位{}"
				}
			},
			sleeve_may_interdimensional_sleeve_alt = {
				name = "次元牌套",
				text = { 
					"{C:spectral}宏宇宙{}会生成",
					"{X:may_interdimensional,C:white}次元{} {C:attention}小丑牌{}"
				}
			},
			sleeve_may_ethereal_sleeve = {
				name = "缥缈牌套",
				text = { 
					"开局携带一张随机",
					"{X:may_ethereal,C:white}缥缈{} {C:attention}小丑牌{}",
					"{C:chips}-2出牌次数{}、{C:mult}-2弃牌次数{}与{C:attention}-3小丑槽位{}"
				}
			},
			sleeve_may_ethereal_sleeve_alt = {
				name = "缥缈牌套",
				text = { 
					"{C:attention}禁用{} {C:dark_edition}缥缈牌组{}的",
					"{C:mult}负面效果{}"
				}
			},
			
			sleeve_may_power_sleeve = {
				name = "威能牌套",
				text = { 
					"{C:green}1/10{}概率在{C:attention}出牌{}后",
					"使{C:dark_edition}计分算子{}等级{C:attention}+1{}"
				}
			},
			sleeve_may_power_sleeve_alt = {
				name = "威能牌套",
				text = { 
					"选择{C:attention}Boss盲注{}时，",
					"使{C:dark_edition}计分算子{}等级{C:attention}+1{}"
				}
			},
			
			sleeve_may_centurion_sleeve = {
				name = "百夫长牌套",
				text = { 
					"开局携带{C:attention,T:v_may_increment}增量{}、",
					"{C:attention,T:v_may_increase}增幅{}、{C:attention,T:v_may_stardust}星尘{}",
					"与{C:attention,T:v_may_meteor}流星{}",
					"所有{C:purple}牌型{}初始为",
					"{C:planet}等级{C:attention}3{}，且",
					"提供{X:purple,C:white}X2{}倍率与筹码",
					"{C:attention}Boss盲注{}额度{X:attention,C:white}X5{}"
				}
			},
			sleeve_may_centurion_sleeve_alt = {
				name = "百夫长牌套",
				text = { 
					"开局携带{C:attention,T:v_may_powerful}威能{}、",
					"{C:attention,T:v_may_unstoppable}势不可挡{}、{C:attention,T:v_may_food_chain}食物链{}",
					"与{C:attention,T:v_may_natural_selection}自然选择{}",
					"{X:may_score,C:white}X2{}分数",
					"{C:attention}小盲注{}与{C:attention}大盲注{}",
					"额度{X:attention,C:white}X4{}"
				}
			},
			
		},
		Spectral = {
			c_cry_pointer = {
				name = "指针://",
				text = {
					"创建一张{C:cry_code}自定义卡牌{}",
					"{C:inactive,s:0.8}(指针://、稀有品质版卡牌、奇珍及以上小丑牌、",
					"{C:inactive,s:0.8}尧塔牌与充能消耗牌除外)",
				},
			},
		},
		Back = {
			b_cry_antimatter = {
				name = "反物质牌组",
				text = {
					"获得{C:attention}所有{} {C:spectral}Cryptid{}模组",
					"与{C:green}Vanilla{}模组中牌组的{C:legendary,E:1}正面效果{}"
				},
			},
		},
		Other = {
			may_modocation_tutorial = {
				name = "模组定位器",
				text = {
					"aYb = aXb+(1+log10(a)Xa)",
					"{C:inactive}创意提供：Superb Thing{}"
				},
			},
			may_ccd_tutorial = {
				name = "CCD（牌组消耗牌）",
				text = {
					"{C:dark_edition}CCD{} 指作为{C:dark_edition}增强效果{}",
					"被附加在{C:attention}扑克牌{}上的",
					"{C:attention}消耗牌{}",
					"{C:attention}使用{} {C:dark_edition}CCD{} 会",
					"{C:mult}将其从{C:attention}牌组{}中移除{}"
				},
			},
			may_level_multchips_tutorial = {
				name = "层级倍率/筹码",
				text = {
					"{C:may_ethereal}层级{} {C:mult}倍率{}/{C:chips}筹码{}指",
					"{C:purple}牌型{} {C:planet}升级{}时",
					"获得的额外{C:mult}倍率{}/{C:chips}筹码{}"
				},
			},
			may_hand_score_tutorial = {
				name = "牌型分数",
				text = {
					"若{C:purple}牌型{}拥有{C:score}分数{}",
					"该分数将在{C:attention}结算后{}",
					"累加到{C:attention}初始{}",
					"{C:attention}得分{}之上"
				},
			},
			may_hand_dollars_tutorial = {
				name = "牌型资金",
				text = {
					"若{C:purple}牌型{}拥有{C:money}资金{}",
					"当打出该{C:purple}牌型{}时",
					"将在{C:attention}结算前{}",
					"{C:green}获得{}对应{C:money}资金{}"
				},
			},
			may_interest_tutorial = {
				name = "利息",
				text = {
					"{C:money}利息{}按{C:money}提现时{}", 
					"每持有{C:money}$5{}获得$1计算", 
					"计算{C:money}利息{}时{C:attention}计入{}的金额", 
					"受{C:money}利息上限{} {C:mult}封顶{}", 
					"{C:inactive}示例：3.2利息率，持有$15 → 获得$9.6{}"
				},
			},
			may_ultrablind = {
				name = "终极盲注",
				text = {
					"特殊强力{C:attention}Boss盲注{}，",
					"可能于{C:attention}第8底注{}后出现",
					"{C:inactive,s:0.7,E:1}务必当心...{}"
				},
			},
			
			may_enf_cosmic = {
				name = "星球牌宇宙能力",
				text = {
					"为{C:purple}牌型{} {C:planet}升级{}时", 
					"创建对应{C:planet}星球牌{}的",
					"{C:dark_edition}负片复制品{}"
				},
			},
			may_enf_inverted = {
				name = "星球牌反转能力",
				text = {
					"{C:money}+0.01 利息率{}"
				},
			},
			may_enf_twilight = {
				name = "星球牌暮光能力",
				text = {
					"不应用{C:mult}基础倍率{}",
					"或{X:money,C:white}X资金{}效果"
				},
			},
			may_enf_laminated = {
				name = "星球牌覆膜能力",
				text = {
					"{C:attention}生效区域{}被视为",
					"{C:attention}消耗牌槽位{}"
				},
			},
			
			may_enf_hydra = {
				name = "九头蛇版能力",
				text = {
					"生成的{C:attention}卡牌{}",
					"继承此牌的{C:dark_edition}版本{}"
				},
			},
			may_enf_moon = {
				name = "月蚀版能力",
				text = {
					"生成的{C:attention}卡牌{}",
					"继承此牌的{C:dark_edition}版本{}"
				},
			},
			may_enf_satellite = {
				name = "卫星版能力",
				text = {
					"生成的{C:attention}卡牌{}",
					"继承此牌的{C:dark_edition}版本{}"
				},
			},
			may_enf_sun = {
				name = "日耀版能力",
				text = {
					"生成的{C:attention}卡牌{}",
					"继承此牌的{C:dark_edition}版本{}"
				},
			},
			may_enf_dysnomia = {
				name = "难律星版能力",
				text = {
					"生成的{C:attention}卡牌{}",
					"继承此牌的{C:dark_edition}版本{}"
				},
			},
			may_enf_matakka = {
				name = "马塔卡版能力",
				text = {
					"生成的{X:legendary,C:white}传说{} {C:planet}星球牌{}",
					"继承此牌的{C:dark_edition}版本{}"
				},
			},
			may_enf_chronos = {
				name = "柯罗诺斯版能力",
				text = {
					"被触发的{C:planet}星球牌{}",
					"获得此牌的{C:dark_edition}版本{}"
				},
			}, 
			may_enf_umbriel = {
				name = "乌伯瑞尔版能力",
				text = {
					"根据卡牌的{C:dark_edition}版本{}",
					"生成对应{C:attention}标签{}"
				},
			},
		},
	},
	dictionary = {
		may_cry_plus_edition_card = '+1 版本牌',
		may_cry_plus_retro_card = '+1 复古牌',
		may_cry_plus_yotta = '+1 尧塔牌',
		may_cry_plus_voucher = '+1 优惠券',
		may_cry_plus_booster = '+1 补充包',
		may_cry_plus_universal = '+1 消耗牌',
		v_dictionary = {
			mult_xp = "X#1# 经验",
			hyp_xp = "#1##2# 经验",
		},
	}, 
	misc = {
		dictionary = {
			may_notif_slaythejokers_1 = 'Slay the Jokers兼容警告', 
		    may_notif_stj_d1 = '如果您是内容创作者，', 
		    may_notif_stj_d2 = '请确保使用的Slay the Jokers为最新提交版本，', 
		    may_notif_stj_d3 = '而非稳定版（如0.2），因其存在兼容性问题。', 
			may_notif_stj_d4 = '您也可查阅Mayhem模组仓库中的“内容创作者指南”章节。',
			
			may_notif_cryptid_1 = 'Cryptid模组注意事项', 
		    may_notif_cry_d1 = 'Mayhem模组与Cryptid模组同时运行时', 
		    may_notif_cry_d2 = '可能无法按预期生效。', 
		    may_notif_cry_d3 = '即便存在跨模组联动，仍不建议同时游玩以获得完整体验。',
			
			may_notif_amulet_1 = 'Amulet/cdataman模组通知', 
		    may_notif_amulet_d1 = 'Mayhem模组兼容Amulet/cdataman模组，', 
		    may_notif_amulet_d2 = '但仍建议使用Talisman模组作为替代，', 
		    may_notif_amulet_d3 = '否则部分功能（如超验系统）可能异常。',
			
			may_notif_smods_1 = 'Steamodded版本提示', 
		    may_notif_smods_d1 = 'Mayhem模组在Steamodded 1221a上极不稳定。', 
		    may_notif_smods_d2 = '建议改用SMODS 1016c', 
		    may_notif_smods_d3 = '或更早的受支持版本。',
			
			may_notif_welcome_1 = '欢迎来到Mayhem！', 
		    may_notif_welcome_d1 = '这是您首次游玩本模组，感谢支持！', 
			may_notif_welcome_d2 = '在完整教程实装前，建议查阅维基页面', 
			may_notif_welcome_d3 = '以了解模组机制与设置选项。', 
		    may_notif_welcome_d4 = '本模组包含大量特殊效果，建议采用', 
		    may_notif_welcome_d5 = '特定的原版配置方案。是否立即应用推荐配置？', 
			
			may_n_yes = '是', 
			may_n_no = '否',
		}
	}
}