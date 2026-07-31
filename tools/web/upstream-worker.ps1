param(
    [Parameter(Mandatory = $true)]
    [string]$ScriptPath,

    [Parameter(Mandatory = $true)]
    [string]$SpecPath
)

$ErrorActionPreference = "Stop"
$utf8 = New-Object Text.UTF8Encoding($false)
[Console]::OutputEncoding = $utf8
$OutputEncoding = $utf8

try {
    $spec = Get-Content -LiteralPath $SpecPath -Raw | ConvertFrom-Json
    $parameters = @{ Command = [string]$spec.command }
    if (@($spec.modIds).Count -gt 0) { $parameters.ModId = [string[]]@($spec.modIds) }
    if (-not [string]::IsNullOrWhiteSpace([string]$spec.repo)) { $parameters.Repo = [string]$spec.repo }
    if (-not [string]::IsNullOrWhiteSpace([string]$spec.ref)) { $parameters.Ref = [string]$spec.ref }
    if (@($spec.paths).Count -gt 0) { $parameters.Paths = [string[]]@($spec.paths) }
    if ([bool]$spec.force) { $parameters.Force = $true }
    if ([bool]$spec.noInit) { $parameters.NoInit = $true }

    & $ScriptPath @parameters *>&1 | ForEach-Object {
        [Console]::Out.WriteLine(($_ | Out-String).TrimEnd())
    }
}
catch {
    $message = $_.Exception.Message
    [Console]::Error.WriteLine("ERROR: $message")
    exit 1
}
