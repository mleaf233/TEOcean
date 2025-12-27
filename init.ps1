# 预定义modid变量，可以直接修改此变量
$modid = "blueprint"  # 在这里直接设置modid，或者通过命令行参数传入


# 如果modid仍然为空，则显示帮助信息并退出
if ($modid -eq "") {
    Write-Host "错误: 未提供modid。" -ForegroundColor Red
    Write-Host "用法1: 直接在脚本中设置 \$modid 变量" -ForegroundColor Yellow
    Write-Host "用法2: 通过命令行参数传递 -modidParam 'your_mod_id'" -ForegroundColor Yellow
    exit 1
}

# 创建目录路径
$basePath = Join-Path "impl" "mods"
$modPath = Join-Path $basePath $modid
$localizationPath = Join-Path $modPath "localization"

# 检查目录是否已存在
if (Test-Path $modPath) {
    Write-Host "目录 $modPath 已存在，无需创建。" -ForegroundColor Yellow
} else {
    # 创建目录
    New-Item -ItemType Directory -Path $modPath -Force | Out-Null
    Write-Host "已创建目录: $modPath" -ForegroundColor Green
}

# 检查 localization 目录是否已存在
if (Test-Path $localizationPath) {
    Write-Host "目录 $localizationPath 已存在，无需创建。" -ForegroundColor Yellow
} else {
    # 创建 localization 目录
    New-Item -ItemType Directory -Path $localizationPath -Force | Out-Null
    Write-Host "已创建目录: $localizationPath" -ForegroundColor Green
}

Write-Host "目录创建完成！路径: $localizationPath" -ForegroundColor Cyan