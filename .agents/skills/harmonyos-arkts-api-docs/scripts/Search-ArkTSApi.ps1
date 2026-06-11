param(
  [Parameter(Mandatory = $true, Position = 0)]
  [string]$Pattern,

  [string]$SdkRoot = 'C:\workspace\apps\DevEco Studio\sdk',

  [int]$MaxMatches = 80
)

if (-not (Test-Path -LiteralPath $SdkRoot)) {
  throw "SDK root not found: $SdkRoot"
}

$rg = Get-Command rg -ErrorAction SilentlyContinue
if ($rg) {
  & rg --line-number --fixed-strings --glob '*.d.ts' --glob '*.ets' --glob '*.ts' --glob '*.json5' --max-count 3 $Pattern $SdkRoot |
    Select-Object -First $MaxMatches
  exit $LASTEXITCODE
}

Get-ChildItem -LiteralPath $SdkRoot -Recurse -Include *.d.ts,*.ets,*.ts,*.json5 |
  Select-String -Pattern ([regex]::Escape($Pattern)) |
  Select-Object -First $MaxMatches |
  ForEach-Object {
    '{0}:{1}:{2}' -f $_.Path, $_.LineNumber, $_.Line.Trim()
  }
