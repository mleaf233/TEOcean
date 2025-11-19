# The Eighth Ocean — 本地化合并工具

这是一个为 Balatro/SMODS 环境准备的本地化合并工具模组扩展，目的是把 `impl/mods/<modid>/localization/` 下的翻译文件合并到对应的目标 mod 的 `localization/` 目录中，以便在游戏中使用统一的翻译覆盖或补充。

# 功能概览:
- **按 modid 合并**：会遍历 `SMODS.mod_list`，只针对工作区 `impl/mods/<modid>/` 存在的 mod 执行合并。
- **备份原始文件（只备份一次）**：写入前会把目标 mod 现有的 `localization/<lang>.lua` / `.json` 复制到 `impl/backup/<modid>/localization/` 下；若备份已存在则跳过，确保备份保留的是“原始”的本地化文件。
- **跳过无意义写入**：在写入前对合并结果做换行与尾部空白归一化并与现有文件比较，若一致则不写入也不备份。
- **手动触发**：合并额外支持在游戏内点击模组配置里的“手动重载”按钮时执行（不会自动覆盖）。目前手动重载后需要手动切换一轮语言


# 目录关系:
- `impl/mods/<modid>/localization/` — 你的覆盖/补充翻译来源。
- `impl/backup/<modid>/localization/` — 自动保存的原始目标 mod 本地化（仅首次备份）。
- 目标写入路径：`<target_mod_path>/localization/<lang>.lua`。

# 如何使用:

## 方法一

* 和其他mod一样，将整个项目文件夹复制到 %AppData%/Balatro/mods 文件夹即可

## 方法二（热重载）
1. 启动游戏。
2. 打开主菜单 → Mods。
3. 选择目标 mod（本 mod 即 The Eighth Ocean），进入 `Config` 标签。
4. 点击 `手动重载(切换语言生效)` 按钮来触发合并与备份。

注意：首次备份会保留目标 mod 在触发时的原始文件。若想强制重新备份原始文件，请手动删除 `impl/backup/<modid>/localization/` 下对应的备份文件，再次点击手动重载。

# 开发说明:
- 合并逻辑位于 `mod.lua` 中，函数 `merge_impl_mod_localizations()` 执行读取、合并、序列化与写入。
- 适配更多mod，需要根据modid在impl/mods/ 下新建文件夹，具体参考已有的。
- 最好确保本mod的加载优先级在适配的mod之前

# 故障排查:
- 若点击按钮后没有生成备份或写入结果，先检查游戏启动日志（控制台输出），寻找以 `[TEOcean Language Packs]` 前缀的日志项。
- 确保目标 mod 的 `localization/` 目录可写。
- 如果合并后仍未生效，确认游戏所选语言（`G.SETTINGS.language`）与你合并的语言文件（例如 `zh_CN.lua`）匹配。


**许可证 & 备注**:
- 请遵循各 mod 的许可条款；本工具仅在本地修改 mod 的 `localization` 文件，请在必要时备份并在分发前征得原作者许可。
