# TEOcean Agent Guide

## 项目定位
- 这是一个面向 Balatro / SMODS 的本地化框架与语言包。
- 入口是 `main.lua`，实际逻辑在 `src/teocean.lua` 和 `src/localization.lua` 一带。
- 仓库里既有代码，也有大量翻译文件；处理方式要按“本地化项目”而不是通用应用来做。

## 开始工作前必须确认
在开始任何需要源码联动、路径拼接、运行验证、修复兼容性的问题之前，先和用户确认下面三个**本地目录**：

1. Balatro 游戏源码目录
2. SMODS 模组框架源码目录
   - 项目地址：`https://github.com/Steamodded/smods`
3. lovely-injector 运行时代码注入框架目录
   - 项目地址：`https://github.com/mleaf233/lovely-injector`

未确认这三个目录之前，不要假设路径，不要直接开始改代码，也不要默认依赖已在本机就绪。
这三个目录齐了，后续联动、定位和验证才可靠。

## 工作原则
- 优先沿用仓库现有写法，不要引入新的抽象层。
- 变更保持局部、可回滚，不要顺手重构无关模块。
- 不要回退用户或其他来源已经存在的改动。
- 文件编辑优先用 `apply_patch`。
- 搜索文件优先用 `rg` / `rg --files`。
- 如果任务涉及本地化内容，优先遵循仓库现有术语和排版，不要擅自改写风格。

## 本仓库的常见结构
- `impl/mods/<modid>/localization/`：各 mod 的覆盖或补充翻译
- `impl/backup/<modid>/localization/`：目标 mod 原始文件备份
- `impl/ai/<modid>/`：AI 翻译缓存
- `impl/todo/<modid>/`：缺失翻译清单
- `localization/`：全局语言文件
- `lovely/`：Lovely 相关配置

## 翻译与本地化约定
- 保持 Lua 结构完整，缩进和表结构不要乱改。
- 数字尽量使用阿拉伯数字。
- 尽量保留游戏术语、卡牌效果和专有名词的原有语感。
- 不要为了“更像中文”而破坏原始含义。
- 如果是补全某个 mod 的翻译，文件名、目录名、`modid` 必须严格对应。

## 修改代码时的检查点
- 改 `src/localization.lua` 时，优先检查合并、备份、运行时覆盖这三条路径。
- 改 AI 相关逻辑时，连带确认 `src/ai_manager.lua`、`src/ai_translation.lua`、`src/ai_provider_adapter.lua`。
- 改配置或加载行为时，顺带核对 `metadata.json` 和 `main.lua`。

## 交付要求
- 只报告真实完成的内容，不要把未验证的猜测当结果。
- 如果因为缺少本地目录、外部源码或运行环境而无法继续，要明确说明缺什么。
- 能做最小验证就不要扩大范围。
