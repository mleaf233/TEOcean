return {
	descriptions = {

		Partner = {
			pnr_kh_sora = {
				name = "{E:kh_pulse}索拉",
				text = {
					"每张打出的{C:hearts}红桃{}牌",
					"计分时永久获得",
					"{X:mult,C:white}X#1#{}倍率",
				},
			},

			pnr_kh_donald = {
				name = "{E:kh_pulse}小鸭们",
				text = {
					"每次出牌时",
					"复制一张随机{C:attention}小丑牌{}",
					"的能力",
					"{C:inactive}（当前复制：{C:attention}#1#{C:inactive}）",
				},
			},

			pnr_kh_mickey = {
				name = "{E:kh_pulse}米奇",
				text = {
					"第一张计分牌有",
					"{C:green}#1#/#2#{}几率",
					"变为{C:attention}K{}",
				},
			},

			pnr_kh_randompartner = {
				name = '{E:kh_pulse}随机伙伴',
				text = {
					"出牌时平衡",
					"{C:chips}筹码{}和{C:mult}倍率{}的",
					"{C:purple}#1#%{}",
					"点击支付{C:money}$#3#{}",
					"并增加{C:purple}#2#%{}",
				},
			},

			pnr_kh_nobody = {
				name = '{E:kh_pulse}无存',
				text = {
					"第一张和最后一张",
					"{C:attention}留在手中的{}牌",
					"参与计分",
				},
			},
		},

		Sleeve = {
			sleeve_kh_kingdom = {
				name = "{E:kh_pulse}王国卡套",
				text = {
					"{C:legendary}王国之心{} {C:attention}小丑牌{}",
					"出现几率提高{C:attention}3倍{}",
					"开局拥有",
					"{C:attention,T:v_overstock_norm}库存过剩{}优惠券",
				}
			},

			sleeve_kh_kingdom_alt = {
				name = "{E:kh_pulse}王国卡套",
				text = {
					"{C:legendary}王国之心{} {C:attention}小丑牌{}",
					"出现几率提高{C:attention}3倍{}",
					"开局拥有{C:attention,T:v_overstock_norm}库存过剩{}",
					"和{C:attention,T:v_overstock_plus}库存过剩加强版{}",
				}
			},

			sleeve_kh_rechain = {
				name = "{E:kh_pulse}记忆之链卡套",
				text = {
					"{C:green}重掷{}花费在每个{C:attention}底注{}重置",
					"开局拥有",
					"{C:attention,T:v_kh_moogleskip}莫古跳过{}优惠券",
				},
			},
			sleeve_kh_rechain_alt = {
				name = "{E:kh_pulse}记忆之链卡套",
				text = {
					"{C:green}重掷{}花费在每个{C:attention}底注{}重置",
					"开局拥有{C:attention,T:v_kh_moogleskip}莫古跳过{}",
					"和{C:attention,T:v_reroll_surplus}多次重掷{}",
				},
			},
		},

		Back = {

			b_kh_rechain = {
				name = "{E:kh_pulse}记忆之链牌组",
				text = {
					"{C:green}重掷{}花费",
					"每个{C:attention}底注{}重置",
					"开局拥有",
					"{C:attention,T:v_kh_moogleskip}莫古跳过{}优惠券",
				},
			},
			b_kh_kingdom = {
				name = "{E:kh_pulse}王国牌组",
				text = {
					"{C:legendary}王国之心{} {C:attention}小丑牌{}",
					"出现几率提高{C:attention}3倍{}",
					"开局拥有",
					"{C:attention,T:v_overstock_norm}库存过剩{}优惠券",
				},
			},
		},
		Joker = {
			j_kh_magnet = {
				name = '{E:kh_pulse}魔尼磁石',
				text = {
					"{C:attention}钢铁{}牌被移动到",
					"你{C:attention}完整牌组{}的",
					"顶部",
					"并给予{C:money}$#1#{}",
					"当被触发时",
				},
			},

			j_kh_kingdomhearts = {
				name = '{E:kh_pulse}王国之心',
				text = {
					"本底注未使用的",
					"{C:red}弃牌{}次数",
					"会保留至",
					"{C:attention}Boss盲注{}",
					"{C:inactive}（当前{C:red}#1#{}{C:inactive}次弃牌）",
				},
			},

			j_kh_tamagotchi = {
				name = '{E:kh_pulse}拓麻歌子',
				text = {
					"在{C:attention}商店{}阶段结束时",
					"摧毁所有{C:attention}留在手中的{}消耗牌",
					"每摧毁一张",
					"获得{X:mult,C:white}X#2#{}倍率",
					"{C:inactive}（当前{X:mult,C:white}X#1#{C:inactive}倍率）",
				},
			},
			j_kh_xehanort = {
				name = '{E:kh_pulse}大师赛亚诺特',
				text = {
					{
						"每{C:attention}连续{}出牌",
						"且牌型与上一次",
						"不同时",
						"此小丑牌获得{C:mult}+#1#{}倍率",
						"{C:inactive}（当前{C:mult}+#2#{C:inactive}倍率）",
					},
				},
			},
			j_kh_com = {
				name = '{E:kh_pulse}记忆之链',
				text = {
					"将上一次出牌的",
					"{C:chips}筹码{}和{C:mult}倍率{}",
					"添加到当前出牌",
					"{C:inactive}（{C:attention}#1#{}{C:inactive}：{X:chips,C:white}#2#{} {C:mult}X{} {X:mult,C:white}#3#{}{C:inactive}）",
				},
			},
			j_kh_lethimcook = {
				name = '{E:kh_pulse}让他大显身手',
				text = {
					"当相邻的",
					"{C:attention}小丑牌{}被触发时",
					"其数值",
					"提高{X:enhanced,C:white}X0.05{}",
					"{C:inactive,s:0.8}稍等……让他大显身手",
				},
			},
			j_kh_lethimcook_alt = {
				name = '{E:kh_pulse}让他大显身手',
				text = {
					"当一张{C:attention}小丑牌{}被触发时",
					"此小丑牌获得{X:mult,C:white}X#2#{}倍率",
					"{C:inactive}（当前{X:mult,C:white}X#1# {C:inactive}倍率）",
					"{C:inactive,s:0.8}稍等……让他大显身手",
				},
			},
			j_kh_commandmenu_kh0 = {
				name = {
					"{E:kh_pulse,C:dark_edition,s:1.0}指令菜单{}",
					"{E:kh_pulse,C:dark_edition,s:0.8}攻击{}",
				},
				text = {
					{
						"当选择{C:attention}盲注{}时",
						"此小丑牌循环切换",
						"其{C:attention}模式{}：",
					},
					{
						"如果出牌包含",
						"至少{C:attention}4{}张牌",
						"则摧毁所有",
						"留在手中的牌",
					},
				},
			},

			j_kh_commandmenu_kh1 = {
				name = {
					"{E:kh_pulse,C:dark_edition,s:1.0}指令菜单{}",
					"{E:kh_pulse,C:dark_edition,s:0.8}魔法{}",
				},
				text = {
					{
						"当选择{C:attention}盲注{}时",
						"此小丑牌循环切换",
						"其{C:attention}模式{}",
					},
					{
						"计分后",
						"将第一张打出的牌",
						"返回手牌",
					},
				},
			},

			j_kh_commandmenu_kh2 = {
				name = {
					"{E:kh_pulse,C:dark_edition,s:1.0}指令菜单{}",
					"{E:kh_pulse,C:dark_edition,s:0.8}道具{}",
				},
				text = {
					{
						"当选择{C:attention}盲注{}时",
						"此小丑牌循环切换",
						"其{C:attention}模式{}",
					},
					{
						"当打出{C:attention}A{}时",
						"生成一张随机",
						"{C:attention}消耗牌{}",
						"{C:inactive}（必须有空位）",
					},
				},
			},

			j_kh_commandmenu_kh3 = {
				name = {
					"{E:kh_pulse,C:dark_edition,s:1.0}指令菜单{}",
					"{E:kh_pulse,C:dark_edition,s:0.8}驱动{}",
				},
				text = {
					{
						"当选择{C:attention}盲注{}时",
						"此小丑牌循环切换",
						"其{C:attention}模式{}",
					},
					{
						"{X:mult,C:white}X4{}倍率"
					},
				},
			},

			j_kh_sora = {
				name = '{E:kh_pulse}索拉',
				text = {
					"每张计分的{C:hearts}红桃{}牌",
					"使此小丑牌获得{X:mult,C:white}X#2#{}倍率",
					"当{C:attention}Boss盲注{}被击败时重置",
					"{C:inactive}（当前{X:mult,C:white}X#1# {C:inactive}倍率）",
					"{C:inactive,s:0.8}我的朋友就是我的力量！",
				},
			},

			j_kh_riku = {
				name = '{E:kh_pulse}利库',
				text = {
					'每{C:attention}#4#{}次{C:green}重掷{}',
					'将最常用牌型',
					'提升#2#级 {C:inactive}(#3#){}',
					'{C:inactive}（最常用：{C:attention}#1#{}{C:inactive}）',
					"{C:inactive,s:0.8}我正想着利库 利库 喔咿喔",
				}
			},

			j_kh_kairi_a = {
				name = '{E:kh_pulse}凯丽',
				text = {
					"每张计分的{C:diamonds}光之花色{}牌",
					"给予{C:chips}+#3#{}筹码",
					"每张计分的{C:spades}暗之花色{}牌",
					"给予{C:chips}-#4#{}筹码",
					"{C:inactive,s:0.8}我知道你会的！",
				}
			},
			j_kh_kairi_b = {
				name = '{E:kh_pulse}娜米妮',
				text = {
					"每张计分的{C:spades}暗之花色{}牌",
					"给予{C:mult}+#3#{}倍率",
					"每张计分的{C:diamonds}光之花色{}牌",
					"给予{C:mult}-#4#{}倍率",
					"{C:inactive,s:0.8}是我 娜米妮",
				}
			},

			j_kh_kairi_extra = {
				text = {
					"{C:inactive}（当前{C:chips}+#1#{}{C:inactive}筹码，{C:mult}+#2#{}{C:inactive}倍率）{}",
					'{C:inactive}回合结束时小丑牌翻转',
				}
			},

			j_kh_roxas = {
				name = '{E:kh_pulse}罗克萨斯',
				text = {
					"第一次出牌中",
					"每有一种独特的{C:attention}花色{}",
					"此小丑牌获得{C:chips}+#2#{}筹码",
					"{C:inactive}（当前{C:chips}+#1#{C:inactive}筹码）",
					"{C:inactive,s:0.8}看来我的暑假……结束了",
				},
			},

			j_kh_brycethenobody = {
				name = "{E:kh_pulse}无存布莱斯",
				text = {
					"每张打出的{V:1}#2#{}牌",
					"计分时永久获得",
					"{C:mult}+#1#{}倍率",
					"{s:0.8}回合结束时花色改变",
					"{C:inactive,s:0.8}很高兴能帮到一些人",
				},
			},

			j_kh_axel_alt = {
				name = '{E:kh_pulse}阿克塞尔',
				text = {
					"当{C:attention}Boss盲注{}被击败时",
					"为最左侧的{C:attention}小丑牌{}",
					"添加{C:dark_edition}闪箔{}、{C:dark_edition}镭射{}",
					"或{C:dark_edition}多彩{}版本",
					"{C:inactive,s:0.8}记住了吗？",
				},
			},

			j_kh_axel = {
				name = '{E:kh_pulse}阿克塞尔',
				text = {
					"当{C:attention}Boss盲注{}被击败时",
					"使最左侧的{C:attention}小丑牌{}",
					"数值{C:white,X:enhanced}X2{}",
					"并应用{C:spectral}易腐{}标贴",
					"{C:inactive,s:0.8}记住了吗？",
				},
			},
			j_kh_xigbar = {
				name = "{E:kh_pulse}半脸",
				text = {
					"出牌中每有一张",
					"未计分的{C:attention}人头牌{}",
					"此小丑牌获得{X:mult,C:white}X#2#{}倍率",
					"{C:inactive}（当前{X:mult,C:white}X#1#{} {C:inactive}倍率）{}",
					"{C:inactive,s:0.8}我？我已经是半个泽阿诺特了",
				},
			},

			j_kh_mickey = {
				name = '{E:kh_pulse}米奇',
				text = {
					"打出的{C:attention}K{}有",
					"{C:green}#1#/#2#{}几率",
					"添加{C:red}红色蜡封{}",
					"{C:green}#1#/#3#{}几率",
					"变为{C:attention}钢铁{}牌",
					"{C:inactive,s:0.8}有人提到过",
					"{C:inactive,s:0.8}黑暗之门吗？",
				}
			},

			j_kh_donald = {
				name = '{E:kh_pulse}唐老鸭',
				text = {
					"每回合复制一张",
					"{C:attention}随机小丑牌{}的能力",
					"{C:inactive}（当前复制：{C:attention}#1#{C:inactive}）",
					"{C:inactive,s:0.8}暴风雪在这里抓不到我们",
				},
			},

			j_kh_goofy = {
				name = "{E:kh_pulse}狂野高飞",
				text = {
					{
						"{C:attention}万能{}牌计分时",
						"给予随机增益：",
					},
					{
						"{s:0.8,X:mult,C:white}X#3#{} {s:0.8}倍率，{s:0.8,C:money}$#4#{}",
						"{s:0.8,C:mult}+#1#{} {s:0.8}倍率，{s:0.8,C:chips}+#2#{} {s:0.8}筹码",
						"{C:inactive,s:0.8}天哪……"
					},
				},
			},

			j_kh_disney = {
				name = '{E:kh_pulse}叶尼塞大师',
				text = {
					"使用{C:purple}塔罗牌{}时",
					"有{C:green}#1#/#2#{}几率",
					"升级随机{C:attention}牌型{}的等级",
					"{C:inactive,s:0.8}索拉 不要让我失望",
				},
			},

			j_kh_keyblade = {
				name = '{E:kh_pulse}钥刃',
				text = {
					"如果回合的{C:attention}第一次出牌{}",
					"是单张{C:attention}#1#{} 则将其摧毁",
					"并生成一张{C:dark_edition}随机{} {C:attention}标签{}",
					"{s:0.8}每回合点数改变",
					"{C:inactive,s:0.8}愿你的心成为指引你的钥匙",
				},
			},

			j_kh_paopufruit = {
				name = '{E:kh_pulse}帕欧普果实',
				text = {
					"为接下来{C:attention}#1#{}次",
					"出牌的第一张计分牌",
					"添加随机{C:dark_edition}版本{}",
					"{C:dark_edition}增强{}和{C:attention}蜡封{}",
					"{C:inactive,s:0.8}胜利者将和凯丽分享帕欧普果实",
				},
			},

			j_kh_sealsalt = {
				name = "{E:kh_pulse}海盐冰激凌",
				text = {
					"如果出牌包含",
					"带{C:attention}蜡封{}的牌",
					"则为一张随机",
					"{C:attention}留在手中的游戏牌{}",
					"添加随机{C:attention}蜡封{}",
					"{C:inactive,s:0.8}伙计 这冰激凌真不错 对吧？",
				},
			},

			j_kh_nobody = {
				name = '{E:kh_pulse}无存',
				text = {
					"所有{C:attention}留在手中的{}牌",
					"都参与计分",
					"并有{C:green}#1#/#2#{}几率",
					"重新触发",
					"{C:inactive,s:0.8}无存？谁是无存？",
				},
			},

			j_kh_moogle = {
				name = '{E:kh_pulse}莫古',
				text = {
					"回合结束时每有一张",
					"{C:attention}小丑牌{}",
					"获得{C:money}$#1#{}",
					"{C:inactive}（当前{C:money}$#2#{}{C:inactive}）",
					"{C:inactive,s:0.8}你好呀",
				},
			},

			j_kh_dummy = {
				name = "魔尼",
				text = {
					"回合结束时",
					"获得{C:money}$(魔尼袋售出价值){}",
					"每回合减少{C:red}$1{}",
				}
			},
			j_kh_invitation = {
				name = "{E:kh_pulse}邀请函",
				text = {
					"从{C:attention}商店{}",
					"{C:attention}购买{}的小丑牌",
					"有{C:green}#1#/#2#{}几率",
					"获得{C:dark_edition}负片{}版本",
					"{C:inactive,s:0.8}新的挑战者出现了……！",
				},
			},
			j_kh_chipanddale = {
				name = "{E:kh_pulse}奇奇与蒂蒂",
				text = {
					"当选择{C:attention}盲注{}时",
					"将{C:attention}上一次出牌{}",
					"筹码的{C:attention}十分之一{}",
					"添加到此{C:red}倍率{}",
					"{C:inactive}（上一次出牌：{C:chips}#1#{C:inactive}筹码）",
					"{C:inactive}（当前{C:mult}+#2#{C:inactive}倍率）",
				},
			},
			j_kh_luxord = {
				name = '{E:kh_pulse}拉克辛',
				text = {
					{
						'本回合每过去{C:attention}一秒{}',
						'失去{C:chips}#3#{}筹码',
					},
					{
						'当{C:attention}Boss盲注{}被击败时',
						'筹码提高{X:chips,C:white}X1.5{}',
						"{C:inactive,s:0.8}我们不如跳过这些繁文缛节",
					},
				},
			},

			j_kh_khtrilogy_kh1 = {
				name = "{E:kh_pulse}王国之心 1",
				text = {
					{
						"{C:chips}+#5#{}筹码",
						"用一次出牌击败盲注",
						"以{C:legendary}升级{}",
					},
					{
						"{C:inactive}（下一级：{C:mult}+#1#{C:inactive}倍率）",
						"{C:inactive,s:0.8}真正的经典",
					},
				}
			},

			j_kh_khtrilogy_kh2 = {
				name = "{E:kh_pulse}王国之心 2",
				text = {
					{
						"{C:mult}+#1#{}倍率",
						"弃掉{C:attention}#7#{} {C:inactive}(#6#){}张牌",
						"以{C:legendary}升级{}",
					},
					{
						"{C:inactive}（下一级：{X:mult,C:white}X#2#{C:inactive}倍率）",
						"{C:inactive,s:0.8}巅峰已至",
					},
				}
			},

			j_kh_khtrilogy_kh3 = {
				name = "{E:kh_pulse}王国之心 3",
				text = {
					"{X:mult,C:white}X#2#{}倍率",
					"{C:inactive,s:0.8}KH4 何时出？？？",
				}
			},

			j_kh_helpwanted = {
				name = "{E:kh_pulse}求助！",
				text = {
					{
						"完成任务以获得奖励！",
						"完成后出现新任务",
						"{C:red,E:2,s:1}当没有剩余任务时",
						"{C:red,E:2,s:1}自毁{}并赚取 $15",
					},
					{
						"{C:attention}当前任务：{} #1#",
						"{C:attention}当前奖励：{} #2#",
						"{C:inactive,s:0.8}也许……今天我们终于能去海滩了！",
					},
				}
			},

			j_kh_munnypouch = {
				name = '{E:kh_pulse}魔尼袋',
				text = {
					{
						"回合结束时获得",
						"其{C:money}售出价值{}的",
						"{C:money}$#3#-$#4#{}",
					},
					{
						"有{C:green}#1#/#2#{}几率",
						"此小丑牌被{C:red}摧毁！{}",
					},
					{
						"售出此小丑牌",
						"生成{C:attention,E:kh_pulse}魔尼{}",
					}
				},
			},

			j_kh_munny = {
				name = '{E:kh_pulse}魔尼',
				text = {
					"回合结束时",
					"获得{C:money}$#1#{}",
					"每回合收益减少{C:red}$1{}",
				},
			},

			j_kh_randomjoker = {
				name = '{E:kh_pulse}随机小丑牌',
				text = {
					"出牌时平衡",
					"{C:mult}倍率{}和{C:chips}筹码{}",
				},
			},
		},

		Tag = {
			tag_kh_kingdom = {
				name = "王国标签",
				text = {
					"商店有一张免费的",
					"{C:legendary}王国之心小丑牌",
				},
			},
		},

		Voucher = {

			v_kh_moogleskip = {
				name = "莫古跳过",
				text = {
					"盲注选择时",
					"可用{C:attention}+1{}次跳过按钮",
				},
			},
			v_kh_moogleshop = {
				name = "莫古商店",
				text = {
					"跳过{C:attention}盲注{}时",
					"进入{C:attention}商店{}"
				},
			},

		},
		Other = {

			kh_shuffled = {
				name = "洗乱",
				text = {
					"此小丑牌在计分前",
					"被洗乱",
				}
			},
			kh_lightsuit = {
				name = "光之花色",
				text = {
					"{C:hearts}红桃{}或{C:diamonds}方片{}",
				}
			},

			kh_darksuit = {
				name = "暗之花色",
				text = {
					"{C:spades}黑桃{}或{C:clubs}梅花{}",
				}
			},

			kh_no_blockbuster = {
				name = "注意！",
				text = {
					"由于未安装",
					"{C:attention}Blockbuster-ValueManipulation{}",
					"此小丑牌当前",
					"具有替代效果",
				}
			},
			kh_lhceffect = {
				name = "原版效果",
				text = {
					"当相邻的",
					"{C:attention}小丑牌{}被触发时",
					"其数值",
					"提高{X:enhanced,C:white}X0.05{}",
				}
			},
			kh_axleffect = {
				name = '原版效果',
				text = {
					"当{C:attention}Boss盲注{}被击败时",
					"使最左侧的{C:attention}小丑牌{}",
					"数值{x:enhanced,C:white}X2{}",
				},
			},
			kh_unstackable = {
				name = "无法叠加",
				text = {
					"无法使{C:attention}小丑牌{}",
					"数值{C:enhanced}翻倍{}",
				}
			},

			kh_perishable = {
				name = "易腐",
				text = {
					"经过{C:attention}5{}回合后",
					"被削弱",
				}
			},

			kh_play_face = {
				name = "站场大师",
				text = {
					"计分7张{C:attention}人头{}牌",
					"以获得{C:attention}+1{}次{C:blue}出牌{}",
				}
			},

			kh_drawing = {
				name = "货物攀爬",
				text = {
					"单回合内抽{C:attention}20{}张牌",
					"以获得{C:attention}+1{}张{C:green}手牌上限{}",
				}
			},

			kh_shopping = {
				name = "张贴告示",
				text = {
					"在单个商店花费{C:money}$20{}",
					"以获得{C:attention}+1{}个商店槽位",
				}
			},

			kh_luckyemblem_seal = {
				name = "幸运蜡封",
				text = {
					"{C:attention}计分{}时",
					"将一张{C:attention}留在手中的{}牌",
					"转换为此牌的{C:attention}点数{}",
					"和{C:attention}花色{}",
				}
			},

			kh_kingdom_seal = {
				name = '王国蜡封',
				text = {
                    "被{C:attention}弃掉{}时",
					"留在手中的牌",
					"永久获得",
					"{C:chips}+#1#{}筹码",
				}
			},

			kh_attack = {
				name = '攻击',
				text = {
					"如果出牌包含",
					"至少{C:attention}4{}张牌",
					"摧毁所有",
					"留在手中的牌",
				}
			},

			kh_magic = {
				name = '魔法',
				text = {
					"计分后",
					"将第一张打出的牌",
					"返回手牌",
				}
			},

			kh_items = {
				name = '道具',
				text = {
					"当打出{C:attention}A{}时",
					"生成一张随机",
					"{C:attention}消耗牌{}",
					"{C:inactive}（必须有空位）",
				}
			},

			kh_drive = {
				name = '驱动',
				text = {
					"{X:mult,C:white}X4{}倍率"
				}
			},

			p_kh_drive_mini = {
				name = "迷你驱动包",
				text = {
					"选择{C:attention}#1#{}张",
					"{C:orange}驱动{}牌",
				},
			},

			p_kh_drive_normal = {
				name = "驱动包",
				text = {
					"从最多{C:attention}#2#张",
					"{C:orange}驱动{}牌中",
					"选择{C:attention}#1#{}张",
				},
			},
			p_kh_drive_jumbo = {
				name = "巨型驱动包",
				text = {
					"从最多{C:attention}#2#张",
					"{C:orange}驱动{}牌中",
					"选择{C:attention}#1#{}张",
				},
			},
			p_kh_drive_mega = {
				name = "超级驱动包",
				text = {
					"从最多{C:attention}#2#张",
					"{C:orange}驱动{}牌中",
					"选择{C:attention}#1#{}张",
				},
			},
		},

		Spectral = {

			c_kh_sorcerer = {
				name = "巫师",
				text = {
					"选择{C:attention}#1#{}张牌",
					"应用{C:attention}幸运蜡封{}",
				}
			},
			c_kh_kingdom = {
				name = "心",
				text = {
					"选择{C:attention}#1#{}张牌",
					"应用{C:attention}王国蜡封{}",
				}
			},
			c_kh_gummiship = {
				name = "高姆飞船",
				text = {
					"摧毁一张随机{C:attention}小丑牌{}",
					"并生成一张",
					"相同稀有度的新{C:attention}小丑牌{}",
				},
			},

		},

		Tarot = {

			c_kh_awakening = {
				name = "觉醒",
				text = {
					"生成一张随机",
					"{C:legendary}王国之心{} {C:attention}小丑牌{}",
					"{C:inactive}（必须有空位）",
				},
			},

		},

		Drive = {

			c_kh_valorform = {
				name = "英勇形态",
				text = {
					"为下一次出牌",
					"添加{C:mult}+4{}基础{C:mult}倍率{}",
					"在计分前",
				},
			},

			c_kh_wisdomform = {
				name = "智慧形态",
				text = {
					"为下一次出牌",
					"{C:enhanced}交换{}基础{C:chips}筹码{}和{C:mult}倍率{}",
					"在计分前",
					"{C:inactive}（无法叠加）{}",
				},
			},

			c_kh_limitform = {
				name = "极限形态",
				text = {
					"为下一次出牌",
					"添加{C:chips}+30{}基础{C:chips}筹码{}",
					"在计分前",
				},
			},

			c_kh_masterform = {
				name = "大师形态",
				text = {
					"为下一次出牌",
					"计分时",
					"{X:mult,C:white}X2{} {C:mult}倍率{}",
				},
			},


			c_kh_finalform = {
				name = "终极形态",
				text = {
					"为下一次出牌",
					"{C:enhanced}翻倍{}基础{C:chips}筹码{}和{C:mult}倍率{}",
					"在计分前",
				},
			},

			c_kh_antiform = {
				name = "反形态",
				text = {
					"为下一次出牌",
					"计分时{C:enhanced}平衡{}",
					"{C:blue}筹码{}和{C:red}倍率{}",
					"{C:inactive}（无法叠加）{}",
				},
			},


		},
		Mod = {
			kingdomhearts = {
				name = "Final Mix",
				text = {
					"新增{C:red}30{}张小丑牌及更多内容",
					"基于{C:attention,E:kh_pulse}王国之心{}系列！",
					"代码与美术由{C:attention}cloudz{}制作！",
					" ",
					" ",
					"这里是{C:blue}网站{}：",
					"{C:attention}https://cloudzxiii.github.io/{}",
				}
			},
		},

	},

	misc = {
		quips = {

			kh_friendsmult = {
				"我的朋友就是我的倍率！"
			},

			kh_simpleclean = {
				"简单而纯粹",
				"正是今夜",
				"你给我的感觉！"
			},

			kh_walkaway = {
				"当你离开时……",
				"听不到我说",
				"{C:attention}弃牌{}！"
			},

			kh_kairiinside = {
				"凯丽……凯丽在我心里？"
			},

			kh_rikubugs = {
				"米奇！是利库！",
				"他们给他装了窃听器！",
			},

			kh_theyregone = {
				"他们不见了！我们所有的",
				"{E:kh_pulse}筹码{}都没了！"
			},

			kh_icecream = {
				"不！我还能和谁一起吃冰激凌？"
			},

		},

		achievement_descriptions = {},
		achievement_names = {},
		blind_states = {},
		challenge_names = {},
		collabs = {},

		dictionary = {
			-- config
			k_finalmix_config_jokers = "启用KH小丑牌",
			k_finalmix_config_tarots = "启用塔罗牌",
			k_finalmix_config_spectrals = "启用幻灵牌",
			k_finalmix_config_vouchers = "启用优惠券",
			k_finalmix_config_seal = "启用蜡封",
			k_finalmix_config_blind = "启用 Boss 盲注",
			k_finalmix_config_drive = "启用驱动牌（制作中）",
			k_finalmix_config_menu_toggle = "切换自定义标题界面",
			k_finalmix_config_restart = "（需要重启）",

			-- kairi/namine
			kh_a_side = '凯丽',
			kh_b_side = '娜米妮',

			-- misc text
			kh_plus_consumeable = '+1 消耗牌！',
			kh_king = '老铁们！',
			b_open_link = "在浏览器中打开",
			kh_destroyed = "已摧毁！",
			kh_copying = "复制中！",
			kh_riku_no = "利库 不！",
			kh_sealed = "已封印！",
			kh_tasks_complete = "任务完成！",
			kh_complete = "完成！",
			kh_stolen = "已窃取！",
			kh_munny = "魔尼！",
			kh_returned = "已归还！"
		},

		high_scores = {},
		labels = {
			kh_luckyemblem_seal = "幸运蜡封",
			kh_kingdom_seal = "王国蜡封",
			kh_shuffled = "洗乱"
		},
		poker_hand_descriptions = {},
		poker_hands = {},
		ranks = {},
		suits_plural = {
			kh_com = "王国牌"
		},
		suits_singular = {
			kh_com = "王国牌"
		},
		tutorial = {},
		v_dictionary = {},

		v_text = {
			ch_c_kh_got_it_memorized = { "所有盲注均为{C:attention}Boss盲注{}" },
			ch_c_no_skipping = { "跳过功能{C:attention}禁用{}" },
			ch_c_no_time = { "如果{C:attention}拉克辛{}被{C:attention}售出{}或{C:attention}摧毁{}则游戏结束" },
		},
	},
}