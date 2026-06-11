param(
  [Parameter(Mandatory = $true)]
  [string]$FilePath,

  [string[]]$Arguments = @(),

  [string]$WorkingDirectory = (Get-Location).Path
)

$devecoRoot = 'C:\workspace\apps\DevEco Studio'
$env:DEVECO_SDK_HOME = Join-Path $devecoRoot 'sdk'
$env:NODE_HOME = Join-Path $devecoRoot 'tools\node'

$toolPaths = @(
  Join-Path $devecoRoot 'tools\node'
  Join-Path $devecoRoot 'tools\ohpm\bin'
  Join-Path $devecoRoot 'sdk\default\openharmony\toolchains'
)

$prefix = $toolPaths -join ';'
if ($env:PATH) {
  $env:PATH = "$prefix;$env:PATH"
} else {
  $env:PATH = $prefix
}

Push-Location $WorkingDirectory
try {
  & $FilePath @Arguments
} finally {
  Pop-Location
}
