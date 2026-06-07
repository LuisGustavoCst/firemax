<#
install-requisitos.ps1
Verifica requisitos mínimos e prepara a pasta do projeto.
#>

function Test-IsAdmin {
    $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Write-Ok($msg){ Write-Host "[OK] $msg" -ForegroundColor Green }
function Write-Warn($msg){ Write-Host "[WARN] $msg" -ForegroundColor Yellow }
function Write-Err($msg){ Write-Host "[ERR] $msg" -ForegroundColor Red }

# Checar admin
if (-not (Test-IsAdmin)) {
    Write-Warn "Este script precisa de privilégios de Administrador para algumas verificações e ações."
    $answer = Read-Host "Deseja relançar como Administrador agora? (S/N)"
    if ($answer -match '^[sS]') {
        try {
            Start-Process powershell.exe -ArgumentList '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', $PSCommandPath -Verb RunAs
            exit 0
        } catch {
            Write-Err "Falha ao tentar elevar privilégios: $($_.Exception.Message)"
            exit 2
        }
    } else {
        Write-Warn "Continuando sem privilégios elevados. Algumas verificações podem falhar."
    }
}

# Versão do PowerShell
$psver = $PSVersionTable.PSVersion
if ($psver.Major -lt 5) {
    Write-Err "PowerShell $($psver.ToString()) detectado. É recomendada a versão 5.1 ou superior."
} else {
    Write-Ok "PowerShell $($psver.ToString())"
}

# Sistema Operacional
$os = (Get-CimInstance -ClassName Win32_OperatingSystem).Caption
if ($os -match 'Windows 10|Windows 11') { Write-Ok "SO: $os" } else { Write-Warn "SO detectado: $os. Recomendado Windows 10/11." }

# Espaço em disco (unidade do script)
$drive = Get-PSDrive -Name ($PSScriptRoot.Substring(0,1)) -ErrorAction SilentlyContinue
if ($drive) {
    $freeGB = [math]::Round($drive.Free/1GB,2)
    Write-Host "Espaço livre em $($drive.Name): $freeGB GB"
    if ($drive.Free -lt 2GB) { Write-Err "Menos de 2GB livre. Opções de backup podem falhar." } else { Write-Ok "Espaço em disco suficiente (>=2GB)." }
} else { Write-Warn "Não foi possível determinar espaço em disco." }

# Criar diretórios necessários
$dirs = @("logs","backups","config","dist") | ForEach-Object { Join-Path $PSScriptRoot $_ }
foreach ($d in $dirs) {
    if (-not (Test-Path $d)) {
        try { New-Item -ItemType Directory -Path $d -Force | Out-Null; Write-Ok "Criei: $d" } catch { Write-Err "Falha ao criar ${d}: $($_.Exception.Message)" }
    } else { Write-Ok "Existe: $d" }
}

# Ajustar ExecutionPolicy para usuário atual (silencioso)
try {
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force -ErrorAction Stop
    Write-Ok "ExecutionPolicy ajustada para Bypass (CurrentUser)."
} catch {
    Write-Warn "Não foi possível alterar ExecutionPolicy: $($_.Exception.Message)"
}

# Resumo final
Write-Host "`nResumo:" -ForegroundColor Cyan
Write-Host " - PowerShell: $($psver.ToString())"
Write-Host " - Sistema: $os"
Write-Host " - Pastas preparadas: $($dirs -join ', ')"
Write-Host "`nPróximo passo: execute .\package.ps1 para criar o ZIP de distribuição ou .\firemax.ps1 para iniciar o otimizador." -ForegroundColor Cyan
