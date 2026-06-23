<div align="center">
    <h1> 🌏TEOcean Localization Framework🌎 </h1>
    <p>Also is a language pack</p>
    <p><a href="https://github.com/mleaf233/TEOcean/blob/main/README_zh_CN.md">简体中文</a> &nbsp;&nbsp; English</p>
    <img src="https://img.shields.io/github/license/mleaf233/TEOcean">
    <a href="https://github.com/mleaf233/TEOcean/issues"><img src="https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat"></a>
</div>

---

## Introduction

A lightweight localization framework for mods in the Balatro/SMODS, which also functions as a language pack.

## Use Cases

- Fill in missing localization for a mod
- Override the original translations of a mod
- Apply a unified translation across multiple mods
- When a target mod is still under active development and its localization files change frequently, making PRs inconvenient

## How It Works

Translation files under `impl/mods/<modid>/localization/` are merged into the corresponding target mod's `localization/` directory, allowing unified translations to override or supplement the originals in-game.

## Features

- **Merge by modid**: Iterates over `SMODS.mod_list` and only performs merging for mods that exist in the workspace at `impl/mods/<modid>/`
- **Two operation modes**:
  - **Disk Mode** (default): Merges translations and writes to target mod files
  - **Runtime Mode** (in-memory): Applies translations to `G.localization` without disk writes
- **Backup original files (once only)**: Before the first merge, the target mod's existing `localization/<lang>.lua` / `.json` files are copied to `impl/backup/<modid>/localization/`. If a backup already exists, it is skipped to ensure the backup always represents the "original" localization files
- **Skip meaningless writes**: Before writing, the merged result is normalized for newlines and trailing whitespace and compared with the existing file. If they are identical, no write or backup is performed
- **Hot reload**: Supports execution when clicking the "Manual Reload" button in the mod configuration menu in-game
- **AI Translation** (experimental): Supports automatic translation via DeepSeek API with persistent caching
- **Original text display**: Optionally show original text alongside translations for cards and blinds

## How to Use

### Method 1

- Like any other mod, simply copy the entire project folder into `%AppData%/Balatro/mods`

### Method 2 (Hot Reload)

1. Launch the game.
2. Open the main menu → Mods.
3. Select the mod (this mod itself is **The Eighth Ocean**) and enter the `Config` tab.
4. Click the **Adapted Mods** button to enable/disable localization for specific mods.
5. Click **Manual Reload** button to trigger merging and reload.

> Note: The initial backup preserves the original files of the target mod at the moment it is triggered.
> To force a fresh backup of the original files, manually delete the corresponding backup files under
> `impl/backup/<modid>/localization/`, then click Manual Reload again.

### Configuration Options

- **Adapted Mods**: Enable/disable localization for individual installed mods
- **Runtime Override Mode**: When enabled, applies translations in-memory without writing to disk
- **Show Original Translation**: Display original text alongside translated text for cards
- **Show Original Blind Translation**: Display original text for Blind challenges
- **Enable AI Translation**: Enable automatic AI translation via DeepSeek API
- **API Key**: Your DeepSeek API key for AI translation (get one at [deepseek](https://platform.deepseek.com/api_keys))

## Development

- The merge logic is implemented in `src/localization.lua`, with functions:
  - `merge_impl_mod_localizations()` - Main entry point for disk mode
  - `TEO_apply_runtime_localization()` - Runtime override mode
  - `merge_single_mod_localization()` - Per-mod processing
  - `restore_original_localization_for_mod()` - Restore from backups
- To support additional mods, create a new folder under `impl/mods/` according to the modid. Refer to the existing examples for details.
- This mod uses `priority: -10` in metadata.json to ensure it loads before the mods it adapts.

### Upstream Localization Checks

The repository can track the upstream localization baseline for manually translated mods, so maintainers can tell when a remote mod changed its source localization files.

- Source config: `tools/upstream-sources.json`
- Baseline lock: `tools/upstream-lock.json`
- Local cache: `impl/upstream/`; only `.gitkeep` is committed, while cached upstream files are ignored
- Fetch mode: uses Git partial clone and sparse checkout, downloading only content needed by configured localization paths

Common commands:

```powershell
.\tools\upstream-localization.ps1 list
.\tools\upstream-localization.ps1 init
.\tools\upstream-localization.ps1 check
.\tools\upstream-localization.ps1 accept <modid>
.\tools\upstream-localization.ps1 accept-all
```

- `init`: initializes missing baselines and copies upstream localization files into `impl/upstream/<modid>/`.
- `check`: compares the recorded baseline commit with the latest remote commit, reporting only localization-path changes.
- `accept <modid>`: updates the baseline after the manual translation has caught up with upstream.

## Directory Structure

- `impl/mods/<modid>/localization/` — Source of your override/supplemental translations
- `impl/backup/<modid>/localization/` — Automatic backup of the target mod's original localization (backed up once only)
- `impl/ai/<modid>/` — AI translation cache (Lua format)
- `impl/todo/<modid>/` — Missing translation reports generated automatically
- `impl/upstream/` — Local upstream source localization cache for development; only `.gitkeep` is committed
- `tools/upstream-sources.json` — Upstream repository and localization path config
- `tools/upstream-lock.json` — Confirmed upstream baseline commits and file hashes
- Target write path: `<target_mod_path>/localization/<lang>.lua`

## Troubleshooting

- If no backup or output is generated after clicking the button, check the game startup logs (console output) for entries prefixed with `[TEOcean Language Packs]`.
- Ensure the target mod's `localization/` directory is writable.
- If the localization still does not take effect after merging, confirm that the selected in-game language (`G.SETTINGS.language`) matches the merged language file (e.g. `zh_CN.lua`).
- For AI translation issues, verify your API key is valid and you have sufficient credits.

## License

- This project is licensed under GPLv3.
- Please comply with each mod's individual license terms. This mod only modifies the target mod's `localization` files locally; make backups when necessary and obtain the original author's permission before distribution.

## Acknowledgments

The following projects/individuals have provided help and contributions to the development of this project (in no particular order):

- [@Brookling](https://github.com/Brookling) - Provided art support
- [smods](https://github.com/Steamodded/smods) - Provided SMODS framework support and some code inspiration
- And all players who have provided translation contributions and feedback
