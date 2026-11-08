# Compiles one C file for the 8051 with SDCC (sdcc -mmcs51, small model), the second compiler of the comparison.
#   powershell -File tools/sdcc_c.ps1 <file.c> <outdir> [extra sdcc options, e.g. -DTUNED --opt-code-size]
# Headers next to the .c file are copied along. Writes <outdir>/<name>.hex (packihx of the .ihx), the .rst listing
# with addresses, the .map and errors.txt. Run from PowerShell: under Git Bash sdcpp cannot start its cc1.
param([Parameter(Mandatory = $true)][string]$Src, [Parameter(Mandatory = $true)][string]$Out, [Parameter(ValueFromRemainingArguments = $true)][string[]]$Extra)
$ErrorActionPreference = 'Stop'
$sdcc = 'C:\Program Files\SDCC\bin'
$env:PATH = "$sdcc;" + $env:PATH
$name = [IO.Path]::GetFileNameWithoutExtension($Src)
New-Item -ItemType Directory -Force $Out | Out-Null
Get-ChildItem $Out -File | Remove-Item -Force
Copy-Item $Src $Out
Copy-Item (Join-Path (Split-Path $Src) '*.h') $Out
Push-Location $Out
try {
  $log = & cmd /c "sdcc -mmcs51 --model-small $($Extra -join ' ') $name.c 2>&1"
  $log | Set-Content -Encoding utf8 errors.txt
  if (-not (Test-Path "$name.ihx")) { Write-Output "FAILED: $name.ihx not made"; $log | Select-Object -First 10; exit 1 }
  & cmd /c "packihx $name.ihx > $name.hex 2> nul"
  Write-Output ("$Out\$name.hex: " + (Get-Item "$name.hex").Length + " characters; sdcc " + ($Extra -join ' '))
} finally { Pop-Location }
