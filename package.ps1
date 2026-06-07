# Package script for FIREMAX
# Creates a distributable zip in the 'dist' folder

param(
    [string]$OutDir = "$PSScriptRoot\dist",
    [string]$ZipName = "FIREMAX-$(Get-Date -Format 'yyyyMMdd').zip"
)

if (-not (Test-Path $OutDir)) { New-Item -ItemType Directory -Path $OutDir | Out-Null }

$files = @(Get-ChildItem -Path $PSScriptRoot -File -Include *.ps1,*.bat,*.md,*.txt | Where-Object { $_.Name -ne $MyInvocation.MyCommand.Name })

$zipPath = Join-Path $OutDir $ZipName

try {
    if (Test-Path $zipPath) { Remove-Item $zipPath -Force }
    $tempList = $files | ForEach-Object { $_.FullName }
    Compress-Archive -Path $tempList -DestinationPath $zipPath -Force
    Write-Host "[+] Pacote criado: $zipPath" -ForegroundColor Green
} catch {
    Write-Host "[X] Falha ao criar pacote: $($_.Exception.Message)" -ForegroundColor Red
}
