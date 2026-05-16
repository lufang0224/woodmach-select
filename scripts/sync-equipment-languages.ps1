param(
  [Parameter(Mandatory=$true)]
  [string]$Slug
)

$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$Source = Join-Path $Root "content\en\equipment\$Slug.md"

if (-not (Test-Path -LiteralPath $Source)) {
  throw "English source file not found: $Source"
}

$Targets = @("zh", "es", "fr", "pt", "ar")
$Content = Get-Content -LiteralPath $Source -Raw -Encoding UTF8

foreach ($Lang in $Targets) {
  $Dir = Join-Path $Root "content\$Lang\equipment"
  $Target = Join-Path $Dir "$Slug.md"
  New-Item -ItemType Directory -Force -Path $Dir | Out-Null

  if (Test-Path -LiteralPath $Target) {
    Write-Host "Skip existing: $Target"
    continue
  }

  $Draft = $Content -replace '(?m)^title: "(.+)"$', 'title: "[TRANSLATE] $1"'
  $Draft = $Draft -replace '(?m)^location: "(.+)"$', 'location: "[TRANSLATE] $1"'
  $Draft = $Draft -replace '(?m)^type: "(.+)"$', 'type: "[TRANSLATE] $1"'
  $Draft = $Draft -replace '(?m)^support: "(.+)"$', 'support: "[TRANSLATE] $1"'
  $Draft = $Draft -replace '(?m)^(\s+- label: )"(.+)"$', '$1"[TRANSLATE] $2"'
  $Draft = $Draft -replace '(?m)^(\s+- )"(.+)"$', '$1"[TRANSLATE] $2"'
  $Draft = $Draft -replace '(?s)---\s*\r?\n(.+)$', "---`n`$1`n`n<!-- TRANSLATE_BODY_TO_$($Lang.ToUpper()) -->"

  Set-Content -LiteralPath $Target -Value $Draft -Encoding UTF8
  Write-Host "Created translation draft: $Target"
}

Write-Host ""
Write-Host "Next step: ask Codex to translate the [TRANSLATE] fields and body comments in the generated files."
