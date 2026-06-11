param(
  [string]$WindowTitlePattern = '*MyApplication*',
  [string]$OutputDirectory = 'docs',
  [int]$CropX = 0,
  [int]$CropY = 0,
  [int]$CropWidth = 0,
  [int]$CropHeight = 0
)

Add-Type -AssemblyName System.Drawing
Add-Type @'
using System;
using System.Text;
using System.Runtime.InteropServices;
public class DevEcoPreviewCapture {
  public delegate bool EnumWindowsProc(IntPtr hWnd, IntPtr lParam);
  [DllImport("user32.dll")] public static extern bool EnumWindows(EnumWindowsProc lpEnumFunc, IntPtr lParam);
  [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr hWnd);
  [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr hWnd, StringBuilder lpString, int nMaxCount);
  [DllImport("user32.dll")] public static extern int GetWindowTextLength(IntPtr hWnd);
  [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);
  [DllImport("user32.dll")] public static extern bool PrintWindow(IntPtr hwnd, IntPtr hdcBlt, uint nFlags);
  public struct RECT { public int Left; public int Top; public int Right; public int Bottom; }
}
'@

if (-not (Test-Path -LiteralPath $OutputDirectory)) {
  New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null
}

$target = [IntPtr]::Zero
$title = ''
[DevEcoPreviewCapture]::EnumWindows({
  param($handle, $unused)
  if ([DevEcoPreviewCapture]::IsWindowVisible($handle)) {
    $length = [DevEcoPreviewCapture]::GetWindowTextLength($handle)
    if ($length -gt 0) {
      $builder = New-Object System.Text.StringBuilder($length + 1)
      [void][DevEcoPreviewCapture]::GetWindowText($handle, $builder, $builder.Capacity)
      $candidate = $builder.ToString()
      if ($candidate -like $WindowTitlePattern) {
        $script:target = $handle
        $script:title = $candidate
        return $false
      }
    }
  }
  return $true
}, [IntPtr]::Zero) | Out-Null

if ($target -eq [IntPtr]::Zero) {
  throw "No visible DevEco window matched pattern: $WindowTitlePattern"
}

$rect = New-Object DevEcoPreviewCapture+RECT
[void][DevEcoPreviewCapture]::GetWindowRect($target, [ref]$rect)
$width = $rect.Right - $rect.Left
$height = $rect.Bottom - $rect.Top
$bitmap = New-Object System.Drawing.Bitmap($width, $height)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$hdc = $graphics.GetHdc()
$ok = [DevEcoPreviewCapture]::PrintWindow($target, $hdc, 2)
$graphics.ReleaseHdc($hdc)
$graphics.Dispose()

$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$windowPath = Join-Path $OutputDirectory "deveco-preview-window-$timestamp.png"
$bitmap.Save((Resolve-Path -LiteralPath $OutputDirectory).Path + "\deveco-preview-window-$timestamp.png", [System.Drawing.Imaging.ImageFormat]::Png)

$cropPath = $null
if ($CropWidth -gt 0 -and $CropHeight -gt 0) {
  $cropRect = [System.Drawing.Rectangle]::new($CropX, $CropY, [Math]::Min($CropWidth, $width - $CropX), [Math]::Min($CropHeight, $height - $CropY))
  $cropped = $bitmap.Clone($cropRect, $bitmap.PixelFormat)
  $cropPath = Join-Path $OutputDirectory "deveco-preview-crop-$timestamp.png"
  $cropped.Save((Resolve-Path -LiteralPath $OutputDirectory).Path + "\deveco-preview-crop-$timestamp.png", [System.Drawing.Imaging.ImageFormat]::Png)
  $cropped.Dispose()
}

$bitmap.Dispose()

[pscustomobject]@{
  WindowTitle = $title
  PrintWindowOk = $ok
  WindowPath = $windowPath
  CropPath = $cropPath
  Width = $width
  Height = $height
}
