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

## 已适配本地化的mod

点击这里： [已适配mod](https://github.com/mleaf233/TEOcean/blob/main/mod_list.md)
## 原理
把 `impl/mods/<modid>/localization/` 下的翻译文件合并到对应目标mod的 `localization/` 目录中，以便在游戏中使用统一的翻译覆盖或补充。

## 特性
- **按 modid 合并**：会遍历 `SMODS.mod_list`，只针对工作区 `impl/mods/<modid>/` 存在的 mod 执行合并
- **备份原始文件（只备份一次）**：首次合并前会把目标 mod 现有的 `localization/<lang>.lua` / `.json` 复制到 `impl/backup/<modid>/localization/` 下；若备份已存在则跳过，确保备份保留的是“原始”的本地化文件
- **跳过无意义写入**：在写入前对合并结果做换行与尾部空白归一化并与现有文件比较，若一致则不写入也不备份
- **热重载**：支持在游戏内点击模组配置里的“手动重载”按钮时执行


## 如何使用

### 方法一

* 和其他mod一样，将整个项目文件夹复制到 %AppData%/Balatro/mods 文件夹即可

### 方法二（热重载）
1. 启动游戏。
2. 打开主菜单 → Mods。
3. 选择目标 mod（本 mod 即 The Eighth Ocean），进入 `Config` 标签。
4. 点击 `手动重载(切换语言生效)` 按钮来触发合并与备份。

注意：首次备份会保留目标 mod 在触发时的原始文件。若想强制重新备份原始文件，请手动删除 `impl/backup/<modid>/localization/` 下对应的备份文件，再次点击手动重载。

## 交流群

QQ群: 
```
1074056375
```
## 开发说明
- 合并逻辑位于 `mod.lua` 中，函数 `merge_impl_mod_localizations()` 执行读取、合并、序列化与写入。
- 适配更多mod，需要根据modid在impl/mods/ 下新建文件夹，具体参考已有的。
- 最好确保本mod的加载优先级在适配的mod之前

## 目录关系
- `impl/mods/<modid>/localization/` — 你的覆盖/补充翻译来源
- `impl/backup/<modid>/localization/` — 自动备份原来mod自带的本地化（仅备份一次）
- 目标写入路径：`<target_mod_path>/localization/<lang>.lua`

## 故障排查
- 若点击按钮后没有生成备份或写入结果，先检查游戏启动日志（控制台输出），寻找以 `[TEOcean Language Packs]` 前缀的日志项。
- 确保目标 mod 的 `localization/` 目录可写。
- 如果合并后仍未生效，确认游戏所选语言（`G.SETTINGS.language`）与你合并的语言文件（例如 `zh_CN.lua`）匹配。


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

}
```
6. 将此mod安装到游戏，并启动游戏
7. 启动后会自动在：./impl/todo/<modid>/ 下生成对应语言的翻译缺失项
8. 按照缺失项进行翻译填充即可
9. 如果你看到某些项有若干行的nil，那些是因为中文和英文的翻译行数不一致导致的，可以忽略或者让其行数一致