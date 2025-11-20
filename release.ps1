# 设置控制台与日志编码为 UTF-8，防止中文乱码
chcp 65001 > $null
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# 获取当前脚本所在目录
$CurrentDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $CurrentDir

# 当前目录名（包括目录本身）
$Source = Get-Item $CurrentDir
$SourceName = $Source.Name

# 目标目录路径 ../../Mods
$DestinationRoot = Resolve-Path "$CurrentDir\..\..\Mods"
$Destination = Join-Path $DestinationRoot $SourceName

# 日志文件路径
$LogFile = Join-Path $CurrentDir "copy_log.txt"

# 写入日志函数（UTF-8 编码）
function Write-Log {
    param([string]$Message)
    $Time = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    $Entry = "[$Time] $Message"
    Write-Output $Entry
    $Entry | Out-File -FilePath $LogFile -Append -Encoding utf8
}

Write-Log "==== 开始复制: $SourceName ===="
Write-Log "源路径: $Source"
Write-Log "目标路径: $Destination"

try {
    # 创建目标根目录
    if (-not (Test-Path $DestinationRoot)) {
        New-Item -ItemType Directory -Path $DestinationRoot | Out-Null
        Write-Log "已创建目标根目录: $DestinationRoot"
    }

    # 获取所有文件和文件夹（排除任何路径下的名为 Libs、smods 的目录及其内容，以及任何路径下的名为 release.ps1 的文件）
    $Items = Get-ChildItem -Path $Source.FullName -Recurse -Force |
        Where-Object {
            # 跳过路径中包含 "\Libs\" 或以 "\Libs" 结尾的项
            # 跳过路径中包含 "\smods\" 或以 "\smods" 结尾的项
            # 跳过路径中包含 "\Balatro\" 或以 "\Balatro" 结尾的项
            # 跳过名为 release.ps1 的文件
            # 合并后的正则表达式
            ($_.FullName -inotmatch "[\\/]((Libs|smods|game)[\\/]?|release\.ps1$)")
        }

    foreach ($Item in $Items) {
        $TargetPath = $Item.FullName.Replace($Source.FullName, $Destination)

        if ($Item.PSIsContainer) {
            if (-not (Test-Path $TargetPath)) {
                New-Item -ItemType Directory -Path $TargetPath | Out-Null
            }
        } else {
            # 确保目标目录存在
            $TargetDir = Split-Path $TargetPath -Parent
            if (-not (Test-Path $TargetDir)) {
                New-Item -ItemType Directory -Path $TargetDir | Out-Null
            }
            Copy-Item -Path $Item.FullName -Destination $TargetPath -Force
        }
    }

    Write-Log "✅ 复制完成（已排除 Libs、smods、Balatro 文件夹和 release.ps1 文件）"
}
catch {
    Write-Log "❌ 复制失败: $($_.Exception.Message)"
}

Write-Log "日志文件: $LogFile"
Write-Log "=============================="