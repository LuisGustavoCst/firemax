if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[X] Este script requer privilegios de ADMINISTRADOR!" -ForegroundColor Red
    exit
}

Clear-Host
Write-Host ""
Write-Host "========== FIREMAX INSTALADOR v2.0 ==========" -ForegroundColor Cyan
Write-Host ""
Write-Host "Instalando FIREMAX..." -ForegroundColor Yellow
Write-Host ""

$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

Write-Host "[*] Criando diretorios..." -ForegroundColor Cyan

@(
    "$scriptPath\logs",
    "$scriptPath\backups",
    "$scriptPath\config"
) | ForEach-Object {
    if (-not (Test-Path $_)) {
        New-Item -ItemType Directory -Path $_ -Force | Out-Null
        Write-Host "  [+] Criado: $_" -ForegroundColor Green
    } else {
        Write-Host "  [+] Ja existe: $_" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "[*] Configurando permissoes de execucao..." -ForegroundColor Cyan

$currentPolicy = Get-ExecutionPolicy -Scope CurrentUser

if ($currentPolicy -eq "Unrestricted" -or $currentPolicy -eq "Bypass") {
    Write-Host "  [+] Permissoes ja configuradas" -ForegroundColor Green
} else {
    try {
        Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force
        Write-Host "  [+] Permissoes configuradas" -ForegroundColor Green
    } catch {
        Write-Host "  [!] Nao foi possivel configurar automaticamente" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "[*] Criando atalho na area de trabalho..." -ForegroundColor Cyan

$desktopPath = [System.IO.Path]::Combine($env:USERPROFILE, "Desktop")
$shortcutPath = "$desktopPath\FIREMAX.lnk"

try {
    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = "powershell.exe"
    $shortcut.Arguments = "-NoExit -ExecutionPolicy Bypass -Command `"cd '$scriptPath'; .\firemax.ps1`""
    $shortcut.WorkingDirectory = $scriptPath
    $shortcut.IconLocation = "C:\Windows\System32\cmd.exe,0"
    $shortcut.WindowStyle = 1
    $shortcut.Save()
    Write-Host "  [+] Atalho criado em: $shortcutPath" -ForegroundColor Green
} catch {
    Write-Host "  [!] Nao foi possivel criar atalho" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[*] Criando arquivo de configuracao..." -ForegroundColor Cyan

$configContent = @"
[General]
Version=2.0
InstallDate=$(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

[Paths]
LogPath=$scriptPath\logs
BackupPath=$scriptPath\backups
ConfigPath=$scriptPath\config

[Settings]
AutoBackup=true
LogRetentionDays=30
EnableNotifications=true

[Optimization]
OptimizationLevel=4
DisableVisualEffects=true
EnableGameMode=true

[Gaming]
AutoPriority=true
GPUOptimization=true
DisableBackgroundApps=true
"@

$configFile = "$scriptPath\config\firemax.config"
if (-not (Test-Path $configFile)) {
    $configContent | Out-File -FilePath $configFile -Encoding UTF8
    Write-Host "  [+] Configuracao criada: $configFile" -ForegroundColor Green
} else {
    Write-Host "  [+] Arquivo de configuracao ja existe" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[*] Verificando compatibilidade..." -ForegroundColor Cyan

$osVersion = [System.Environment]::OSVersion.Version
$osCaption = (Get-WmiObject -Class Win32_OperatingSystem).Caption

Write-Host "  SO: $osCaption" -ForegroundColor Cyan
Write-Host "  Versao: $osVersion" -ForegroundColor Cyan

if ($osVersion.Major -ge 10) {
    Write-Host "  [+] SO compativel" -ForegroundColor Green
} else {
    Write-Host "  [X] SO nao suportado (Windows 10+ requerido)" -ForegroundColor Red
}

$psVersion = $PSVersionTable.PSVersion
Write-Host "  PowerShell: $psVersion" -ForegroundColor Cyan

if ($psVersion.Major -ge 5) {
    Write-Host "  [+] PowerShell compativel" -ForegroundColor Green
} else {
    Write-Host "  [!] PowerShell 5.1+ recomendado" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[*] Verificando privilegios..." -ForegroundColor Cyan

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($isAdmin) {
    Write-Host "  [+] Privilegios de administrador detectados" -ForegroundColor Green
} else {
    Write-Host "  [X] Privilegios insuficientes" -ForegroundColor Red
}

Write-Host ""
Write-Host "[*] Criando backup inicial de seguranca..." -ForegroundColor Cyan

$backupName = "backup_install_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
$backupDir = "$scriptPath\backups\$backupName"

try {
    New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
    
    reg export "HKCU\Software\Microsoft\Windows\CurrentVersion" "$backupDir\registry_user.reg" /y 2>$null
    reg export "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion" "$backupDir\registry_system.reg" /y 2>$null
    
    Write-Host "  [+] Backup criado: $backupDir" -ForegroundColor Green
} catch {
    Write-Host "  [!] Nao foi possivel criar backup automatico" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "===============================================" -ForegroundColor Magenta
Write-Host "[+] INSTALACAO CONCLUIDA COM SUCESSO!" -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Magenta
Write-Host ""

Write-Host "Informacoes de Instalacao:" -ForegroundColor Yellow
Write-Host "  Diretorio: $scriptPath"
Write-Host "  Logs: $scriptPath\logs"
Write-Host "  Backups: $scriptPath\backups"
Write-Host "  Configuracao: $scriptPath\config"
Write-Host ""

Write-Host "PROXIMAS ETAPAS:" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Opcao 1 - Executar agora:"
Write-Host "    .\firemax.ps1"
Write-Host ""
Write-Host "  Opcao 2 - Usar atalho da area de trabalho:"
Write-Host "    Procure 'FIREMAX' na area de trabalho"
Write-Host ""
Write-Host "  Opcao 3 - Executar depois:"
Write-Host "    cd $scriptPath"
Write-Host "    .\firemax.ps1"
Write-Host ""

Write-Host "===============================================" -ForegroundColor Magenta
Write-Host ""
Write-Host "Deseja executar o FIREMAX agora? (S/N)" -ForegroundColor Magenta
$response = Read-Host

if ($response -eq "S" -or $response -eq "s") {
    Write-Host ""
    Write-Host "Iniciando FIREMAX..." -ForegroundColor Green
    Start-Sleep -Seconds 2
    & "$scriptPath\firemax.ps1"
} else {
    Write-Host ""
    Write-Host "Instalacao concluida. Execute firemax.ps1 quando desejar." -ForegroundColor Yellow
    Write-Host ""
}

