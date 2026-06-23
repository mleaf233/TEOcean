param(
    [Parameter(Position = 0)]
    [ValidateSet("add", "init", "check", "accept", "accept-all", "list")]
    [string]$Command = "check",

    [Parameter(Position = 1)]
    [string[]]$ModId,

    [string]$Repo,

    [string]$Ref = "HEAD",

    [string[]]$Paths,

    [switch]$Force,

    [switch]$NoInit
)

$ErrorActionPreference = "Stop"

$ToolRoot = Split-Path -Parent $PSCommandPath
$RepoRoot = (Resolve-Path (Join-Path $ToolRoot "..")).Path
$ImplModsDir = Join-Path $RepoRoot "impl\mods"
$ImplTodoDir = Join-Path $RepoRoot "impl\todo"
$UpstreamDir = Join-Path $RepoRoot "impl\upstream"
$ReposDir = Join-Path $UpstreamDir ".repos"
$SourcesPath = Join-Path $ToolRoot "upstream-sources.json"
$LockPath = Join-Path $ToolRoot "upstream-lock.json"

function Get-ObjectProperty {
    param(
        [object]$Object,
        [string]$Name
    )

    if ($null -eq $Object) {
        return $null
    }

    $property = $Object.PSObject.Properties[$Name]
    if ($null -eq $property) {
        return $null
    }

    return $property.Value
}

function Read-JsonObject {
    param(
        [string]$Path,
        [object]$DefaultValue
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        return $DefaultValue
    }

    $content = Get-Content -LiteralPath $Path -Raw
    if ([string]::IsNullOrWhiteSpace($content)) {
        return $DefaultValue
    }

    return $content | ConvertFrom-Json
}

function Write-JsonObject {
    param(
        [string]$Path,
        [object]$Value
    )

    $json = $Value | ConvertTo-Json -Depth 20
    Set-Content -LiteralPath $Path -Value ($json + [Environment]::NewLine) -Encoding UTF8
}

function Assert-GitAvailable {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        throw "git was not found in PATH."
    }
}

function Invoke-Git {
    param(
        [string]$RepoDir,
        [string[]]$Arguments,
        [switch]$AllowFailure
    )

    $previousErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        $output = & git -C $RepoDir @Arguments 2>&1
        $exitCode = $LASTEXITCODE
        $outputText = (($output | Out-String).Trim())
    }
    finally {
        $ErrorActionPreference = $previousErrorActionPreference
    }

    if ($exitCode -ne 0 -and -not $AllowFailure) {
        throw "git -C `"$RepoDir`" $($Arguments -join ' ') failed with exit code $exitCode.`n$outputText"
    }

    return [pscustomobject]@{
        ExitCode = $exitCode
        Output = $outputText
    }
}

function Invoke-GitGlobal {
    param(
        [string[]]$Arguments,
        [switch]$AllowFailure
    )

    $previousErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        $output = & git @Arguments 2>&1
        $exitCode = $LASTEXITCODE
        $outputText = (($output | Out-String).Trim())
    }
    finally {
        $ErrorActionPreference = $previousErrorActionPreference
    }

    if ($exitCode -ne 0 -and -not $AllowFailure) {
        throw "git $($Arguments -join ' ') failed with exit code $exitCode.`n$outputText"
    }

    return [pscustomobject]@{
        ExitCode = $exitCode
        Output = $outputText
    }
}

function Normalize-RepoPath {
    param([string]$Path)

    if ([string]::IsNullOrWhiteSpace($Path)) {
        return $null
    }

    return ($Path -replace "\\", "/").Trim("/")
}

function Join-RelativePath {
    param(
        [string]$BasePath,
        [string]$RelativePath
    )

    $result = $BasePath
    foreach ($part in (($RelativePath -replace "\\", "/") -split "/")) {
        if (-not [string]::IsNullOrWhiteSpace($part)) {
            $result = Join-Path $result $part
        }
    }

    return $result
}

function Assert-SafeModId {
    param([string]$ModId)

    if ([string]::IsNullOrWhiteSpace($ModId)) {
        throw "Mod id is empty."
    }

    if ($ModId -match '[\\/:*?"<>|]' -or $ModId -eq "." -or $ModId -eq "..") {
        throw "Unsafe mod id: $ModId"
    }
}

function Get-AdaptedModIds {
    if (-not (Test-Path -LiteralPath $ImplModsDir)) {
        return @()
    }

    return @(Get-ChildItem -LiteralPath $ImplModsDir -Directory | Sort-Object Name | ForEach-Object { $_.Name })
}

function Get-PropertyMap {
    param([object]$Object)

    $map = [ordered]@{}
    if ($null -eq $Object) {
        return $map
    }

    foreach ($property in $Object.PSObject.Properties) {
        $map[$property.Name] = $property.Value
    }

    return $map
}

function Get-ConfiguredPaths {
    param(
        [object]$Source,
        [string[]]$DefaultPaths
    )

    $paths = Get-ObjectProperty $Source "paths"
    if ($null -eq $paths -or @($paths).Count -eq 0) {
        $paths = $DefaultPaths
    }

    return @(
        $paths |
            ForEach-Object { Normalize-RepoPath ([string]$_) } |
            Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
            Select-Object -Unique
    )
}

function Get-SourceRef {
    param([object]$Source)

    $ref = Get-ObjectProperty $Source "ref"
    if ([string]::IsNullOrWhiteSpace($ref)) {
        return "HEAD"
    }

    return [string]$ref
}

function Ensure-ToolState {
    New-Item -ItemType Directory -Force -Path $UpstreamDir | Out-Null
    New-Item -ItemType Directory -Force -Path $ReposDir | Out-Null
}

function Remove-RepoCacheDirectory {
    param([string]$RepoDir)

    if (-not (Test-Path -LiteralPath $RepoDir)) {
        return
    }

    $reposRoot = (Resolve-Path -LiteralPath $ReposDir).Path.TrimEnd("\")
    $resolvedRepoDir = (Resolve-Path -LiteralPath $RepoDir).Path.TrimEnd("\")
    if (-not $resolvedRepoDir.StartsWith($reposRoot + "\", [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to remove path outside impl/upstream/.repos: $resolvedRepoDir"
    }

    Remove-Item -LiteralPath $resolvedRepoDir -Recurse -Force
}

function Set-SparseCheckoutPaths {
    param(
        [string]$RepoDir,
        [string[]]$SparsePaths
    )

    $paths = @(
        $SparsePaths |
            ForEach-Object { Normalize-RepoPath ([string]$_) } |
            Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
            Select-Object -Unique
    )

    if ($paths.Count -eq 0) {
        return
    }

    Invoke-Git $RepoDir @("sparse-checkout", "init", "--no-cone") | Out-Null
    Invoke-Git $RepoDir (@("sparse-checkout", "set", "--no-cone", "--") + $paths) | Out-Null
}

function Ensure-UpstreamRepo {
    param(
        [string]$ModId,
        [object]$Source
    )

    Assert-SafeModId $ModId

    $repoUrl = Get-ObjectProperty $Source "repo"
    if ([string]::IsNullOrWhiteSpace($repoUrl)) {
        throw "No repo configured for $ModId."
    }

    $repoDir = Join-Path $ReposDir $ModId
    $gitDir = Join-Path $repoDir ".git"

    if ((Test-Path -LiteralPath $repoDir) -and -not (Test-Path -LiteralPath $gitDir)) {
        Remove-RepoCacheDirectory $repoDir
    }

    if (-not (Test-Path -LiteralPath $gitDir)) {
        Write-Host "[$ModId] sparse cloning $repoUrl"
        $clone = Invoke-GitGlobal @("clone", "--filter=blob:none", "--no-checkout", $repoUrl, $repoDir) -AllowFailure
        if ($clone.ExitCode -ne 0) {
            Remove-RepoCacheDirectory $repoDir
            throw "git clone --filter=blob:none --no-checkout $repoUrl $repoDir failed with exit code $($clone.ExitCode).`n$($clone.Output)"
        }
    }
    else {
        Invoke-Git $repoDir @("remote", "set-url", "origin", $repoUrl) | Out-Null
    }

    Invoke-Git $repoDir @("fetch", "--filter=blob:none", "--prune", "origin") | Out-Null
    return $repoDir
}

function Resolve-RemoteCommit {
    param(
        [string]$RepoDir,
        [string]$Ref
    )

    if ([string]::IsNullOrWhiteSpace($Ref) -or $Ref -eq "HEAD") {
        $result = Invoke-Git $RepoDir @("rev-parse", "--verify", "origin/HEAD") -AllowFailure
        if ($result.ExitCode -ne 0) {
            Invoke-Git $RepoDir @("remote", "set-head", "origin", "-a") -AllowFailure | Out-Null
            $result = Invoke-Git $RepoDir @("rev-parse", "--verify", "origin/HEAD") -AllowFailure
        }

        if ($result.ExitCode -eq 0) {
            return $result.Output.Trim()
        }

        throw "Unable to resolve origin/HEAD."
    }

    $candidates = @("origin/$Ref", $Ref)
    foreach ($candidate in $candidates) {
        $result = Invoke-Git $RepoDir @("rev-parse", "--verify", "$candidate^{commit}") -AllowFailure
        if ($result.ExitCode -eq 0) {
            return $result.Output.Trim()
        }
    }

    throw "Unable to resolve ref '$Ref'."
}

function Test-GitPathAtCommit {
    param(
        [string]$RepoDir,
        [string]$Commit,
        [string]$RepoPath
    )

    $normalizedPath = Normalize-RepoPath $RepoPath
    if ([string]::IsNullOrWhiteSpace($normalizedPath)) {
        return $false
    }

    $spec = "$Commit`:$normalizedPath"
    $result = Invoke-Git $RepoDir @("cat-file", "-e", $spec) -AllowFailure
    return ($result.ExitCode -eq 0)
}

function Get-ExistingRepoPaths {
    param(
        [string]$RepoDir,
        [string]$Commit,
        [string[]]$CandidatePaths
    )

    $existing = New-Object System.Collections.Generic.List[string]
    foreach ($path in $CandidatePaths) {
        $normalizedPath = Normalize-RepoPath $path
        if ((-not [string]::IsNullOrWhiteSpace($normalizedPath)) -and (Test-GitPathAtCommit $RepoDir $Commit $normalizedPath)) {
            $existing.Add($normalizedPath)
        }
    }

    return @($existing.ToArray())
}

function Reset-ModCacheDirectory {
    param([string]$ModId)

    Assert-SafeModId $ModId

    $upstreamRoot = (Resolve-Path -LiteralPath $UpstreamDir).Path.TrimEnd("\")
    $target = Join-Path $UpstreamDir $ModId

    if (Test-Path -LiteralPath $target) {
        $resolvedTarget = (Resolve-Path -LiteralPath $target).Path.TrimEnd("\")
        if (-not $resolvedTarget.StartsWith($upstreamRoot + "\", [System.StringComparison]::OrdinalIgnoreCase)) {
            throw "Refusing to remove path outside impl/upstream: $resolvedTarget"
        }

        Remove-Item -LiteralPath $resolvedTarget -Recurse -Force
    }

    New-Item -ItemType Directory -Force -Path $target | Out-Null
    return $target
}

function Copy-ResolvedPaths {
    param(
        [string]$ModId,
        [string]$RepoDir,
        [string]$Commit,
        [string[]]$ResolvedPaths
    )

    Invoke-Git $RepoDir @("checkout", "--force", $Commit) | Out-Null
    $cacheDir = Reset-ModCacheDirectory $ModId

    foreach ($path in $ResolvedPaths) {
        $sourcePath = Join-RelativePath $RepoDir $path
        if (-not (Test-Path -LiteralPath $sourcePath)) {
            Write-Warning "[$ModId] source path disappeared after checkout: $path"
            continue
        }

        $destinationPath = Join-RelativePath $cacheDir $path
        $destinationParent = Split-Path -Parent $destinationPath
        New-Item -ItemType Directory -Force -Path $destinationParent | Out-Null
        Copy-Item -LiteralPath $sourcePath -Destination $destinationPath -Recurse -Force
    }

    return $cacheDir
}

function Get-FileHashes {
    param([string]$Directory)

    $hashes = [ordered]@{}
    if (-not (Test-Path -LiteralPath $Directory)) {
        return $hashes
    }

    $basePath = (Resolve-Path -LiteralPath $Directory).Path.TrimEnd("\") + "\"
    $files = Get-ChildItem -LiteralPath $Directory -File -Recurse | Sort-Object FullName
    foreach ($file in $files) {
        $relativePath = $file.FullName.Substring($basePath.Length).Replace("\", "/")
        $hash = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
        $hashes[$relativePath] = "sha256:$hash"
    }

    return $hashes
}

function Save-LockEntries {
    param([System.Collections.IDictionary]$LockEntries)

    $mods = [ordered]@{}
    foreach ($key in ($LockEntries.Keys | Sort-Object)) {
        $mods[$key] = $LockEntries[$key]
    }

    $lock = [ordered]@{
        version = 1
        mods = $mods
    }

    Write-JsonObject $LockPath $lock
}

function Save-SourceEntries {
    param(
        [string[]]$DefaultPaths,
        [System.Collections.IDictionary]$SourceEntries
    )

    $mods = [ordered]@{}
    foreach ($key in ($SourceEntries.Keys | Sort-Object)) {
        $mods[$key] = $SourceEntries[$key]
    }

    $sources = [ordered]@{
        version = 1
        defaultPaths = @($DefaultPaths)
        mods = $mods
    }

    Write-JsonObject $SourcesPath $sources
}

function New-SourceEntry {
    param(
        [string]$RepoUrl,
        [string]$SourceRef,
        [string[]]$SourcePaths
    )

    if ([string]::IsNullOrWhiteSpace($RepoUrl)) {
        throw "Command 'add' requires -Repo."
    }

    if ([string]::IsNullOrWhiteSpace($SourceRef)) {
        $SourceRef = "HEAD"
    }

    $entry = [ordered]@{
        repo = $RepoUrl
        ref = $SourceRef
    }

    $normalizedPaths = @()
    if ($null -ne $SourcePaths -and $SourcePaths.Count -gt 0) {
        $normalizedPaths = @(
            $SourcePaths |
                ForEach-Object { Normalize-RepoPath ([string]$_) } |
                Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
                Select-Object -Unique
        )
    }

    if ($normalizedPaths.Count -gt 0) {
        $entry.paths = @($normalizedPaths)
    }

    return $entry
}

function Ensure-AdaptedModSkeleton {
    param([string]$ModId)

    Assert-SafeModId $ModId

    $modDir = Join-Path $ImplModsDir $ModId
    $localizationDir = Join-Path $modDir "localization"
    New-Item -ItemType Directory -Force -Path $localizationDir | Out-Null

    $zhPath = Join-Path $localizationDir "zh_CN.lua"
    if (-not (Test-Path -LiteralPath $zhPath)) {
        $content = @(
            "return {",
            "  translator = {",
            "    `"TODO`",",
            "  },",
            "}",
            ""
        )
        Set-Content -LiteralPath $zhPath -Value $content -Encoding UTF8
        Write-Host "[$ModId] created $zhPath"
    }
    else {
        Write-Host "[$ModId] localization skeleton already exists."
    }
}

function Add-Mod {
    param(
        [string]$ModId,
        [string]$RepoUrl,
        [string]$SourceRef,
        [string[]]$SourcePaths,
        [System.Collections.IDictionary]$SourceEntries,
        [System.Collections.IDictionary]$LockEntries,
        [string[]]$DefaultPaths
    )

    Assert-SafeModId $ModId
    $shouldWriteSource = (-not $SourceEntries.Contains($ModId)) -or $Force
    if ($shouldWriteSource -and [string]::IsNullOrWhiteSpace($RepoUrl)) {
        throw "Command 'add' requires -Repo when creating or replacing source config."
    }

    Ensure-AdaptedModSkeleton $ModId

    if ($SourceEntries.Contains($ModId) -and -not $Force) {
        Write-Host "[$ModId] source config already exists; use -Force to replace it."
    }
    else {
        $SourceEntries[$ModId] = New-SourceEntry $RepoUrl $SourceRef $SourcePaths
        Save-SourceEntries $DefaultPaths $SourceEntries
        Write-Host "[$ModId] source config saved."
    }

    if ($NoInit) {
        Write-Host "[$ModId] baseline init skipped because -NoInit was set."
        return
    }

    Update-Baseline $ModId $SourceEntries[$ModId] $LockEntries $DefaultPaths $false
}

function Update-Baseline {
    param(
        [string]$ModId,
        [object]$Source,
        [System.Collections.IDictionary]$LockEntries,
        [string[]]$DefaultPaths,
        [bool]$SkipExisting
    )

    if ($SkipExisting -and $LockEntries.Contains($ModId)) {
        Write-Host "[$ModId] baseline already exists; skipped. Use -Force or accept to replace it."
        return
    }

    $ref = Get-SourceRef $Source
    $candidatePaths = Get-ConfiguredPaths $Source $DefaultPaths
    $repoDir = Ensure-UpstreamRepo $ModId $Source
    $latestCommit = Resolve-RemoteCommit $repoDir $ref
    $resolvedPaths = Get-ExistingRepoPaths $repoDir $latestCommit $candidatePaths

    if ($resolvedPaths.Count -eq 0) {
        Write-Warning "[$ModId] no configured localization source paths exist at $latestCommit."
        return
    }

    Set-SparseCheckoutPaths $repoDir $resolvedPaths
    $cacheDir = Copy-ResolvedPaths $ModId $repoDir $latestCommit $resolvedPaths
    $hashes = Get-FileHashes $cacheDir
    $repoUrl = Get-ObjectProperty $Source "repo"

    $LockEntries[$ModId] = [ordered]@{
        repo = $repoUrl
        baselineRef = $ref
        baselineCommit = $latestCommit
        resolvedPaths = @($resolvedPaths)
        hashes = $hashes
        updatedAt = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    }

    Save-LockEntries $LockEntries
    Write-Host "[$ModId] baseline set to $latestCommit"
}

function Get-LockBaseline {
    param(
        [System.Collections.IDictionary]$LockEntries,
        [string]$ModId
    )

    if (-not $LockEntries.Contains($ModId)) {
        return $null
    }

    return $LockEntries[$ModId]
}

function Write-ChangeReport {
    param(
        [string]$ModId,
        [object]$Entry,
        [string]$LatestCommit,
        [string]$DiffText
    )

    $todoDir = Join-Path $ImplTodoDir $ModId
    New-Item -ItemType Directory -Force -Path $todoDir | Out-Null

    $reportPath = Join-Path $todoDir "upstream_changed.md"
    $baselineCommit = Get-ObjectProperty $Entry "baselineCommit"
    $baselineRef = Get-ObjectProperty $Entry "baselineRef"
    $repoUrl = Get-ObjectProperty $Entry "repo"

    $content = @(
        "# $ModId upstream localization changed",
        "",
        "Repo: $repoUrl",
        "Ref: $baselineRef",
        "Baseline: $baselineCommit",
        "Latest: $LatestCommit",
        "",
        "Changed localization files:",
        "",
        "~~~text",
        $DiffText,
        "~~~",
        "",
        "Suggested flow:",
        "",
        "1. Compare the upstream source files under impl/upstream/$ModId/ with the upstream diff.",
        "2. Update impl/mods/$ModId/localization/zh_CN.lua or its split files.",
        "3. Run tools/upstream-localization.ps1 accept $ModId after the translation catches up."
    )

    Set-Content -LiteralPath $reportPath -Value $content -Encoding UTF8
    return $reportPath
}

function Check-Mod {
    param(
        [string]$ModId,
        [object]$Source,
        [System.Collections.IDictionary]$LockEntries,
        [string[]]$DefaultPaths
    )

    $entry = Get-LockBaseline $LockEntries $ModId
    if ($null -eq $entry) {
        Write-Host "[$ModId] NO BASELINE - run init or accept after choosing a baseline."
        return
    }

    $baselineCommit = Get-ObjectProperty $entry "baselineCommit"
    if ([string]::IsNullOrWhiteSpace($baselineCommit)) {
        Write-Host "[$ModId] NO BASELINE - baselineCommit is empty."
        return
    }

    $rawResolvedPaths = Get-ObjectProperty $entry "resolvedPaths"
    $resolvedPaths = @()
    if ($null -ne $rawResolvedPaths) {
        $resolvedPaths = @(
            $rawResolvedPaths |
                ForEach-Object { Normalize-RepoPath ([string]$_) } |
                Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
                Select-Object -Unique
        )
    }

    if ($resolvedPaths.Count -eq 0) {
        $resolvedPaths = Get-ConfiguredPaths $Source $DefaultPaths
    }

    $repoDir = Ensure-UpstreamRepo $ModId $Source
    $ref = Get-SourceRef $Source
    $latestCommit = Resolve-RemoteCommit $repoDir $ref

    if ($baselineCommit -eq $latestCommit) {
        Write-Host "[$ModId] OK - baseline is current."
        return
    }

    $diffArgs = @("diff", "--name-status", $baselineCommit, $latestCommit, "--") + @($resolvedPaths)
    $diff = Invoke-Git $repoDir $diffArgs

    if ([string]::IsNullOrWhiteSpace($diff.Output)) {
        Write-Host "[$ModId] OK - upstream changed, localization paths unchanged."
        return
    }

    $reportPath = Write-ChangeReport $ModId $entry $latestCommit $diff.Output
    Write-Host "[$ModId] NEEDS UPDATE - report: $reportPath"
}

function Select-TargetModIds {
    param([bool]$RequireExplicit)

    $selected = @($ModId | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
    if ($selected.Count -gt 0) {
        return $selected
    }

    if ($RequireExplicit) {
        throw "Command '$Command' requires at least one mod id."
    }

    return Get-AdaptedModIds
}

function Write-ConfigurationList {
    param(
        [string[]]$AdaptedModIds,
        [System.Collections.IDictionary]$SourceEntries,
        [System.Collections.IDictionary]$LockEntries
    )

    foreach ($id in $AdaptedModIds) {
        $state = "UNCONFIGURED"
        if ($SourceEntries.Contains($id)) {
            $state = "CONFIGURED"
            if ($LockEntries.Contains($id)) {
                $state = "TRACKED"
            }
        }

        Write-Host ("{0,-28} {1}" -f $id, $state)
    }
}

$sources = Read-JsonObject $SourcesPath ([pscustomobject]@{ version = 1; defaultPaths = @(); mods = [pscustomobject]@{} })
$sourceEntries = Get-PropertyMap (Get-ObjectProperty $sources "mods")
$rawDefaultPaths = Get-ObjectProperty $sources "defaultPaths"
$defaultPaths = @()
if ($null -ne $rawDefaultPaths) {
    $defaultPaths = @(
        $rawDefaultPaths |
            ForEach-Object { Normalize-RepoPath ([string]$_) } |
            Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
            Select-Object -Unique
    )
}
if ($defaultPaths.Count -eq 0) {
    $defaultPaths = @("localization/default.lua", "localization/en-us.lua", "localization/default.json", "localization/en-us.json")
}

$lock = Read-JsonObject $LockPath ([pscustomobject]@{ version = 1; mods = [pscustomobject]@{} })
$lockEntries = Get-PropertyMap (Get-ObjectProperty $lock "mods")
$adaptedModIds = Get-AdaptedModIds

if ($Command -eq "list") {
    Write-ConfigurationList $adaptedModIds $sourceEntries $lockEntries
    return
}

if ($Command -eq "add") {
    $selected = @($ModId | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
    if ($selected.Count -ne 1) {
        throw "Command 'add' requires exactly one mod id."
    }

    if (-not $NoInit) {
        Assert-GitAvailable
        Ensure-ToolState
    }

    Add-Mod $selected[0] $Repo $Ref $Paths $sourceEntries $lockEntries $defaultPaths
    return
}

Assert-GitAvailable
Ensure-ToolState

if ($Command -eq "accept-all") {
    foreach ($id in $adaptedModIds) {
        if (-not $sourceEntries.Contains($id)) {
            Write-Host "[$id] UNCONFIGURED - add repo info to tools/upstream-sources.json."
            continue
        }

        Update-Baseline $id $sourceEntries[$id] $lockEntries $defaultPaths $false
    }
    return
}

$requireExplicit = ($Command -eq "accept")
$targetModIds = Select-TargetModIds $requireExplicit

foreach ($id in $targetModIds) {
    if (-not $sourceEntries.Contains($id)) {
        Write-Host "[$id] UNCONFIGURED - add repo info to tools/upstream-sources.json."
        continue
    }

    switch ($Command) {
        "init" {
            Update-Baseline $id $sourceEntries[$id] $lockEntries $defaultPaths (-not $Force)
        }
        "accept" {
            Update-Baseline $id $sourceEntries[$id] $lockEntries $defaultPaths $false
        }
        "check" {
            Check-Mod $id $sourceEntries[$id] $lockEntries $defaultPaths
        }
    }
}
