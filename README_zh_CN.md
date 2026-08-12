<div align="center">
    <h1> 🌏TEOcean本地化框架🌎 </h1>
    <p>兼汉化语言包</p>
    <p><a href="https://github.com/mleaf233/TEOcean/blob/main/README.md">English</a> &nbsp;&nbsp; 简体中文</p>
    <img src="https://img.shields.io/github/license/mleaf233/TEOcean">
    <a href="https://github.com/mleaf233/TEOcean/issues"><img src="https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat"></a>
</div>

---

## 介绍

一个为 Balatro/SMODS 体系下的Mod进行本地化的简易框架，同时也是一个语言包。

## 使用场景

- 对一个mod的本地化缺失部分进行补充
- 覆盖原mod的翻译
- 想对多个mod进行统一翻译
- 目标mod开发阶段，本地化文件改动频繁，不方便进行PR时
- 想要体验AI集成翻译

## 人工翻译的mod

点击这里： [已适配mod](https://github.com/mleaf233/TEOcean/blob/main/mod_list.md)

## 原理

把 `impl/mods/<modid>/localization/` 下的翻译文件合并到对应目标mod的 `localization/` 目录中，以便在游戏中使用统一的翻译覆盖或补充。

## 特性

- **按 modid 合并**：会遍历 `SMODS.mod_list`，只针对工作区 `impl/mods/<modid>/` 存在的 mod 执行合并
- **两种运行模式**：
  - **磁盘模式**（默认）：合并翻译并写入目标mod文件
  - **运行时模式**（内存）：直接修改 `G.localization`，不写入磁盘
- **备份原始文件（只备份一次）**：首次合并前会把目标 mod 现有的 `localization/<lang>.lua` / `.json` 复制到 `impl/backup/<modid>/localization/` 下；若备份已存在则跳过，确保备份保留的是"原始"的本地化文件
- **跳过无意义写入**：在写入前对合并结果做换行与尾部空白归一化并与现有文件比较，若一致则不写入也不备份
- **热重载**：支持在游戏内点击模组配置里的"手动重载"按钮时执行
- **AI翻译**（实验性）：支持通过配置任意模型进行AI自动翻译，带持久化缓存
- **原文显示**：可选在卡牌和盲注描述旁显示原文
- **故事显示**：可选在卡牌悬停详情中显示本地化条目里的注释（译者撰写的背景故事），支持条目前注释块与行尾注释两种写法

## 如何使用

### 方法一

和其他mod一样，将整个项目文件夹复制到 %AppData%/Balatro/mods/ 文件夹下
注意：首次备份会保留目标 mod 在触发时的原始文件。若想强制重新备份原始文件，请手动删除 `impl/backup/<modid>/localization/` 下对应的备份文件。

### 配置选项

- **已适配的模组**：为单个已安装的模组启用/禁用本地化
- **运行时覆盖模式**：启用后在内存中应用翻译，不写入磁盘
- **显示原文翻译**：在卡牌描述旁显示原文
- **显示盲注原文**：显示盲注挑战的原文
- **显示故事**：在卡牌悬停详情中显示本地化条目里的注释（背景故事）
- **启用AI翻译**：启用AI自动翻译
- **API URL**：你应该输入API接口地址，以http开头，支持（Openai、Claude、Gemini）三种主流格式
- **API密钥**：你的 API 密钥（推荐在 https://platform.deepseek.com/api_keys 获取）

### AI翻译功能说明
1. AI翻译点击启用后，将鼠标悬停在任意卡片上即可触发自动翻译
2. AI翻译需要发起网络请求，等待几秒钟后，把鼠标移开卡片再次悬停在卡片即可展现效果
3. 文本不是实时刷新，会有一个5秒的更新队列，每5秒触发一次文本刷新
4. AI翻译的质量跟AI模型有关，翻译效果差请更换模型
5. AI翻译的质量也跟提示词（Prompt）有关，提示词目前内置在源码中，如果对目前的提示词不满意可以自行修改
6. AI翻译功能为**非流式响应**，触发大量卡牌翻译（鼠标快速扫过每个卡牌）可能会触发API的频率限制
7. AI翻译会将翻译结果进行缓存，以节省Token消耗，可以前往AI缓存管理进行手动清除缓存
8. AI翻译会优先读取本地的缓存以及人工翻译，两者都找不到才会触发联网翻译

## 交流群

QQ群:
```
1074056375
```

## 开发说明

- 合并逻辑位于 `src/localization.lua` 中，核心函数：
  - `merge_impl_mod_localizations()` - 磁盘模式主入口
  - `TEO_apply_runtime_localization()` - 运行时覆盖模式
  - `merge_single_mod_localization()` - 单模组处理
  - `restore_original_localization_for_mod()` - 从备份恢复
- 适配更多mod，需要根据modid在impl/mods/ 下新建文件夹，具体参考已有的。
- 本mod使用 `priority: -10` 确保在适配的mod之前加载。

### 上游本地化变更检查

本仓库可以记录每个已人工翻译 mod 的上游本地化基线，用来判断远程仓库是否改动了 `default.lua`、`en-us.lua` 等原始翻译文件。

- 源配置：`tools/upstream-sources.json`
- 基线锁：`tools/upstream-lock.json`
- 本地缓存：`impl/upstream/`，只提交 `.gitkeep`，实际缓存文件会被 `.gitignore` 忽略
- 拉取方式：使用 Git partial clone 与 sparse checkout，只下载配置中的本地化路径所需内容

常用命令：

```powershell
.\tools\upstream-localization.ps1 list
.\tools\upstream-localization.ps1 add <modid> -Repo <repo-url>
.\tools\upstream-localization.ps1 init
.\tools\upstream-localization.ps1 check
.\tools\upstream-localization.ps1 accept <modid>
.\tools\upstream-localization.ps1 accept-all
```

- `list`：列出 `impl/mods/*` 中已适配 mod 的配置状态。
- `add <modid> -Repo <repo-url>`：创建 `impl/mods/<modid>/localization/zh_CN.lua`，写入 `tools/upstream-sources.json`，并默认建立上游基线；可用 `-Ref <branch>` 指定分支，`-Paths <path1>,<path2>` 指定特殊本地化路径，`-NoInit` 仅登记不联网初始化。
- `init`：为尚未建立基线的 mod 拉取上游本地化文件，写入 `impl/upstream/<modid>/`，并记录当前 commit 到 `tools/upstream-lock.json`。
- `check`：比较 `tools/upstream-lock.json` 记录的 baseline commit 和远程最新 commit；只有本地化路径发生变化时才标记为需要更新。
- `accept <modid>`：人工翻译已经追上游后，刷新本地缓存并把该 mod 的 baseline 更新到远程最新 commit。
- `accept-all`：对所有已配置 mod 执行 `accept`。

如果 `check` 发现上游本地化变更，会生成：

```text
impl/todo/<modid>/upstream_changed.md
```

如果某个 mod 显示 `UNCONFIGURED`，可以用 `add <modid> -Repo <repo-url> -Force` 补充或替换上游仓库配置。

## 目录关系

- `impl/mods/<modid>/localization/` — 你的覆盖/补充翻译来源
- `impl/backup/<modid>/localization/` — 自动备份原来mod自带的本地化（仅备份一次）
- `impl/ai/<modid>/` — AI翻译缓存（Lua格式）
- `impl/todo/<modid>/` — 自动生成的缺失翻译报告
- `impl/upstream/` — 开发用上游原始本地化缓存，仅 `.gitkeep` 会提交
- `tools/upstream-sources.json` — 上游仓库和本地化路径配置
- `tools/upstream-lock.json` — 已确认翻译基线的上游 commit 与文件 hash
- 目标写入路径：`<target_mod_path>/localization/<lang>.lua`

## 故障排查

- 若点击按钮后没有生成备份或写入结果，先检查游戏启动日志（控制台输出），寻找以 `[TEOcean Language Packs]` 前缀的日志项。
- 确保目标 mod 的 `localization/` 目录可写。
- 如果合并后仍未生效，确认游戏所选语言（`G.SETTINGS.language`）与你合并的语言文件（例如 `zh_CN.lua`）匹配。
- AI翻译问题时，请验证API密钥有效且余额充足。

## 许可说明

- 本项目采用 GPLv3 许可证
- 请遵循各 mod 的许可条款；本mod仅在本地修改目标mod 的 `localization` 文件，请在必要时备份并在分发前征得原作者许可

## 题外话

* 这个mod起初是我个人自用，在游玩Balatro的过程中，看到一些mod没有汉化或者是机翻质量不佳，所以想优化翻译
* 只要我还在玩小丑牌及其mod，这个项目会一直更新
* 不要随便给对应的mod提交本地化支持的PR，除非你觉得这份翻译足够好
* 这个仓库的部分汉化是搬运的，但它们都经过了原翻译作者的允许，未经授权的翻译文件不会进行整合并合并到此仓库

## 如何通过此框架汉化一个mod

1. 下载源码或者通过git克隆此仓库
2. 选择你要汉化的mod，找到其modid，modid可以在目标mod的 <mod名称>.json / mod主函数入口中找到
3. 在 impl/mod/ 下创建一个文件夹，文件夹以modid命名，即: ./impl/mod/<modid>
4. 创建 ./impl/mod/<modid>/localization/ 文件夹
5. 新建空的 zh_CN.lua 文件：

```lua
return {
  translator = {
    "留下翻译的作者",
    "第二个翻译者",
  },
}
```
6. 将此mod安装到游戏，并启动游戏
7. 启动后会自动在：./impl/todo/<modid>/ 下生成对应语言的翻译缺失项
8. 按照缺失项进行翻译填充即可
9. 如果你看到某些项有若干行的nil，那些是因为中文和英文的翻译行数不一致导致的，可以忽略或者让其行数一致
10. 可选：为条目添加 Lua 注释作为“故事”，开启“显示故事”后，悬停卡牌时会在详情中显示该注释（详见下文“故事注释”）

## 翻译原则

1. 遵循原版翻译的lua格式
2. 翻译中的游戏术语尽量还原
3. 遇到数字时，统一用阿拉伯数字，除非代码里明确了固定的数值（即无法被Cryptid的油灯等小丑更改数值）
4. 尽量遵循官方中文翻译风格
5. 翻译讲究"信达雅"，但一般只需要满足第一个要求——准确
6. 遇到"倍乘""增加"等这些表述时，不需要翻译出来，只需要写数字表示（例如X3、+10）
7. 尽量避免使用逗号，而是改成另起一行文本，句号同理
8. 可以为条目添加 Lua 注释作为“故事”，悬停卡牌时会显示在详情页的“故事”框中（需要开启“显示故事”配置项）

## 故事注释

在本地化文件中，条目（例如 `c_abn_hyperborea`）的注释会被提取为“故事”，显示在卡牌悬停详情中。支持两种写法：

1. **条目前注释块**：紧贴在 `key = {` 之前的连续 `--` 注释行

```lua
c_abn_lemuria = {
    -- Lemuria（雷姆利亚）是一个科学史上的假想地质概念，
    -- 后来演变成与亚特兰蒂斯齐名的传说中沉没的神秘大陆。
    name = "雷姆利亚",
    text = { ... },
},
```

2. **行尾注释**：条目内任意行 `--` 之后的注释，例如 `name` 行

```lua
c_abn_hyperborea = {
    name = "极北之地",  -- 译为许珀耳玻瑞亚或极北之地。在希腊神话中指……
    text = { ... },
},
```

两种注释可以同时存在，按文件中的顺序依次显示；超长注释会自动按 25 个可见字符换行，注释中的 `{C:xxx}` 颜色标记同样生效。

另外，本地化文件既可以是 `localization/<lang>.lua` 单文件，也可以是 `localization/<lang>/` 目录下多个文件（含子目录）的布局，例如 JoyousSpring，两种布局都会被扫描。

## 致谢

以下这些项目/个人为本项目的开发提供了帮助和贡献（排名不分先后）：

- [@Brookling](https://github.com/Brookling) - 提供了美术支持
- [smods](https://github.com/Steamodded/smods) - 提供了SMODS框架支持以及部分代码灵感
- 以及所有提供翻译贡献和反馈的玩家们
