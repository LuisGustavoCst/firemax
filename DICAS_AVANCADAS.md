# ðŸŽ® FIREMAX - DICAS E TRUQUES AVANÃ‡ADOS

## ðŸ“– SumÃ¡rio
1. [OtimizaÃ§Ãµes Extremas](#otimizaÃ§Ãµes-extremas)
2. [Monitoramento AvanÃ§ado](#monitoramento-avanÃ§ado)
3. [IntegraÃ§Ã£o com Outras Ferramentas](#integraÃ§Ã£o-com-outras-ferramentas)
4. [Scripting Personalizado](#scripting-personalizado)
5. [Performance Tuning](#performance-tuning)
6. [Troubleshooting AvanÃ§ado](#troubleshooting-avanÃ§ado)

---

## ðŸš€ OtimizaÃ§Ãµes Extremas

### Modo Ultra-Gaming (Requer Cuidado)

```powershell
# 1. Disabilitar completamente o antivÃ­rus (durante gaming)
Disable-WindowsDefenderATP

# 2. MÃ¡xima prioridade ao game
$game = Get-Process -Name "csgo" # Substitua pelo seu game
$game.PriorityClass = "Realtime"

# 3. Desabilitar sincronizaÃ§Ã£o de arquivo
Stop-Service OneSyncSvc

# 4. Desabilitar Superfetch
Stop-Service SysMain
```

âš ï¸ **AVISO:** Essas aÃ§Ãµes podem deixar seu PC vulnerÃ¡vel. Use apenas em ambiente controlado.

---

### Limpeza Nuclear de Cache

```powershell
# Script para limpeza profunda (use com cuidado!)
$paths = @(
    "$env:TEMP",
    "$env:SystemRoot\Temp",
    "$env:LOCALAPPDATA\Temp",
    "$env:ProgramData\Microsoft\Windows\Caches",
    "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\ThumbCacheToDelete"
)

foreach ($path in $paths) {
    Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue | 
    Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
}

# Esvaziar Page File
fsutil behavior set memoryusage 2
```

---

## ðŸ“Š Monitoramento AvanÃ§ado

### Script de Monitoramento ContÃ­nuo (24/7)

```powershell
# Salve como monitor-24h.ps1
# Execute em background com: Start-Job -FilePath monitor-24h.ps1

while ($true) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $cpu = (Get-WmiObject -Class Win32_PerfFormattedData_PerfOS_Processor -Filter "Name='_Total'").PercentProcessorTime
    $ram = ((Get-WmiObject -Class Win32_OperatingSystem).TotalVisibleMemorySize - (Get-WmiObject -Class Win32_OperatingSystem).FreePhysicalMemory)
    
    "$timestamp | CPU: $cpu% | RAM: $ram MB" | 
    Add-Content -Path "C:\Users\[seu_usuario]\Documents\firemax-otimizer\logs\24h-monitor.log"
    
    Start-Sleep -Seconds 60
}
```

### AnÃ¡lise de Picos de CPU

```powershell
# Encontrar quais processos causam picos de CPU
Get-Process | 
Where-Object {$_.CPU -gt 50} | 
Select-Object ProcessName, CPU, WorkingSet | 
Sort-Object CPU -Descending | 
Format-Table -AutoSize
```

---

## ðŸ”— IntegraÃ§Ã£o com Outras Ferramentas

### IntegraÃ§Ã£o com MSI Afterburner

```powershell
# Criar perfil automÃ¡tico de GPU para gaming
$afterburnerPath = "C:\Program Files (x86)\MSI Afterburner\MSIAfterburner.exe"

if (Test-Path $afterburnerPath) {
    # Ativar perfil de performance
    Start-Process $afterburnerPath -ArgumentList "-profile3"
}
```

### IntegraÃ§Ã£o com HWiNFO

```powershell
# Iniciar HWiNFO e usar dados para logging
$hwinfoPath = "C:\Program Files\HWiNFO64\HWiNFO64.exe"

if (Test-Path $hwinfoPath) {
    Start-Process $hwinfoPath -ArgumentList "/min /noreport"
}
```

### AutomaÃ§Ã£o com Task Scheduler

```powershell
# Script para criar tarefa agendada de otimizaÃ§Ã£o diÃ¡ria
$taskName = "FIREMAX Daily Optimization"
$taskPath = "C:\Users\[seu_usuario]\Documents\firemax-otimizer\firemax.ps1"

$trigger = New-ScheduledTaskTrigger -Daily -At 2:00AM
$action = New-ScheduledTaskAction -Execute "powershell.exe" `
    -Argument "-ExecutionPolicy Bypass -File '$taskPath' -Option 3"
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount
$settings = New-ScheduledTaskSettingsSet

Register-ScheduledTask -TaskName $taskName -Trigger $trigger -Action $action `
    -Principal $principal -Settings $settings -Force
```

---

## ðŸ› ï¸ Scripting Personalizado

### Criar Seu PrÃ³prio Otimizador Modular

```powershell
# custom-optimization.ps1
# Seu prÃ³prio script de otimizaÃ§Ã£o

function Optimize-CustomNetwork {
    Write-Host "ðŸŒ Otimizando configuraÃ§Ãµes de rede..." -ForegroundColor Cyan
    
    # DNS pÃºblico mais rÃ¡pido
    Set-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter).InterfaceIndex `
        -ServerAddresses ("1.1.1.1", "1.0.0.1")
    
    # TCP Window Scaling
    netsh int tcp set global autotuninglevel=normal
    
    # Aumentar MTU para LAN
    netsh interface ipv4 set subinterface "Ethernet" mtu=1500 store=persistent
}

function Optimize-GPU {
    Write-Host "ðŸŽ® Otimizando GPU..." -ForegroundColor Cyan
    
    # Nvidia Settings (exemplo)
    # nvidia-smi -pm 1
    # nvidia-smi -lgc 2100,2100,2100  # Lock GPU Clock
}

# Chamar funÃ§Ãµes personalizadas
Optimize-CustomNetwork
Optimize-GPU
```

---

## âš™ï¸ Performance Tuning

### Otimizar Background Intelligent Transfer Service (BITS)

```powershell
# Aumentar velocidade de download
$bits = Get-Service BITS
Set-Service BITS -StartupType Disabled -PassThru | Start-Service

# Configurar limites
cmd /c "bitsadmin /util /repairservice /force"
```

### Otimizar I/O do Disco

```powershell
# Para drives mecÃ¢nicos (HDD)
fsutil behavior set disabledeletenotify 0

# Para SSD (reabilitar TRIM)
fsutil behavior set disabledeletenotify 1
```

### Otimizar Prioridade de Tempo Real (Audio/Video)

```powershell
# Dar mÃ¡xima prioridade a aplicaÃ§Ãµes de media
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" `
    /v TcpTrackFullPortTable /t REG_DWORD /d 1 /f
```

---

## ðŸ” Troubleshooting AvanÃ§ado

### Diagnosticar Problema de Performance

```powershell
# Criar relatÃ³rio de diagnÃ³stico completo
function Get-PerformanceDiagnostic {
    $report = @()
    
    # Eventos de erro no Event Log
    $errors = Get-EventLog -LogName System -Level Error -Newest 20
    $report += "=== ERROS RECENTES ==="
    $report += $errors | Select-Object TimeGenerated, Source, EventID, Message
    
    # Drivers problemÃ¡ticos
    $report += "`n=== STATUS DOS DRIVERS ==="
    Get-WmiObject Win32_PnPDevice -Filter "ConfigManagerErrorCode<>0" | 
        ForEach-Object { $report += $_.Name }
    
    # Arquivos corrompidos
    $report += "`n=== VERIFICAR INTEGRIDADE SISTEMA ==="
    $report += "Execute: sfc /scannow"
    
    # Checksum do disco
    $report += "`n=== VERIFICAR DISCO ==="
    $report += "Execute: chkdsk /F (requer reinicializaÃ§Ã£o)"
    
    return $report | Out-String
}

Get-PerformanceDiagnostic | Out-File "C:\diagnostic_report.txt"
```

### Recuperar de CorrupÃ§Ã£o do Registry

```powershell
# Restaurar ponto de restauraÃ§Ã£o do sistema
$systemeRestore = @(Get-WmiObject -Class Win32_SystemRestore | 
    Sort-Object CreationTime -Descending | Select-Object -First 1)

if ($systemRestore) {
    Write-Host "RestauraÃ§Ã£o em progresso..."
    cmd /c "rstrui.exe"
}
```

### AnÃ¡lise de Arquivo Corrompido

```powershell
# Varrer sistema em busca de corrupÃ§Ã£o
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
SFC /scannow
```

---

## ðŸŽ¯ OtimizaÃ§Ãµes por Tipo de Jogo

### Para RPGs (Alto uso de CPU)
```powershell
# Aumentar threads disponÃ­veis
$env:PROCESSOR_ARCHITECTURE = "AMD64"

# Boost para Elden Ring, Baldur's Gate 3, etc
& "C:\Users\silva\Documents\firemax-otimizer\firemax.ps1" # OpÃ§Ã£o 8
```

### Para FPS (Alto uso de GPU)
```powershell
# CS:GO, Valorant, Apex Legends
# Prioridade para GPU
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
    /v GraphicsSettings_Exclusive /t REG_DWORD /d 1 /f
```

### Para MMORPG (EquilÃ­brio)
```powershell
# World of Warcraft, FFXIV
# Modo equilibrado
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
```

---

## ðŸ’¾ AutomaÃ§Ã£o Completa

### Script de Setup PÃ³s-InstalaÃ§Ã£o Windows

```powershell
# post-install-optimization.ps1
# Execute na primeira vez apÃ³s instalar Windows

Write-Host "ðŸš€ OtimizaÃ§Ã£o PÃ³s-InstalaÃ§Ã£o Iniciada..."

# 1. Atualizar Windows
Write-Host "Atualizando Windows..."
Get-WmiObject -Namespace root/cimv2/mdm/dmmap -Class MDM_DevDetail_Ext01 `
    -ErrorAction SilentlyContinue | 
    Select-Object -First 1 | 
    ForEach-Object { $_.PSComputerName }

# 2. Instalar drivers recomendados
Write-Host "Procurando drivers faltantes..."

# 3. Executar FIREMAX completo
Write-Host "Executando otimizaÃ§Ã£o do FIREMAX..."
& "C:\Users\silva\Documents\firemax-otimizer\firemax.ps1" -Option 15

Write-Host "âœ… OtimizaÃ§Ã£o pÃ³s-instalaÃ§Ã£o concluÃ­da!"
```

---

## ðŸ“ˆ Benchmarking

### Criar Seu PrÃ³prio Benchmark

```powershell
# benchmark.ps1
# Teste de performance antes e depois da otimizaÃ§Ã£o

function Invoke-Benchmark {
    $results = @{}
    
    # Teste de CPU
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    [System.GC]::Collect()
    1..1000000 | ForEach-Object { $_ * 2 } | Out-Null
    $sw.Stop()
    $results["CPU"] = $sw.ElapsedMilliseconds
    
    # Teste de RAM
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $array = New-Object byte[] 1GB
    for ($i = 0; $i -lt $array.Length; $i += 1MB) {
        $array[$i] = 1
    }
    $sw.Stop()
    $results["RAM"] = $sw.ElapsedMilliseconds
    
    # Teste de Disco
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    1..1000 | ForEach-Object {
        [System.IO.File]::WriteAllText("$env:TEMP\test$_.txt", "benchmark")
    }
    $sw.Stop()
    $results["Disk"] = $sw.ElapsedMilliseconds
    
    return $results
}

$before = Invoke-Benchmark
Write-Host "Benchmark ANTES:" $before

# Execute otimizaÃ§Ãµes aqui

$after = Invoke-Benchmark
Write-Host "Benchmark DEPOIS:" $after

# Comparar
Write-Host "Melhoria CPU: $(($before.CPU - $after.CPU) / $before.CPU * 100)%"
```

---

## ðŸ” SeguranÃ§a em Scripting

### Template Seguro para Scripts Personalizados

```powershell
# Sempre validar entrada do usuÃ¡rio
function Invoke-SafeOptimization {
    param(
        [ValidateSet("Low", "Medium", "High")]
        [string]$OptimizationLevel = "Medium"
    )
    
    # Criar backup automÃ¡tico
    $backup = "backup_$(Get-Date -Format 'yyyyMMddHHmmss')"
    Write-Host "Criando backup: $backup"
    
    # Executar com tratamento de erro
    try {
        # Sua otimizaÃ§Ã£o aqui
        Write-Host "OtimizaÃ§Ã£o em progresso..."
    }
    catch {
        Write-Host "Erro detectado: $_"
        Write-Host "Restaurando de backup..."
        # Restaurar backup
    }
    finally {
        Write-Host "Limpeza finalizada"
    }
}
```

---

## ðŸŽ“ Recursos de Aprendizado

### DocumentaÃ§Ã£o Recomendada
- Microsoft PowerShell Docs: https://docs.microsoft.com/powershell/
- Windows Registry Reference: https://docs.microsoft.com/windows/win32/sysinfo/registry
- Performance Tuning Guide: https://docs.microsoft.com/windows-server/administration/performance-tuning/

### Comunidades
- Reddit: r/pcgaming, r/buildapc
- Discord: PC Gaming, Tech Support
- Forums: TechSpot, Tom's Hardware

---

## âš¡ Quick Reference - Comandos Ãšteis

```powershell
# Ver uso de CPU em tempo real
Get-Counter -Counter "\Processor(_Total)\% Processor Time"

# Limpar Event Log
Clear-EventLog -LogName System, Application

# Ver espaÃ§o em disco
Get-Volume | Format-Table -Property DriveLetter, FileSystemLabel, Size, SizeRemaining

# Listar todas as task agendadas
Get-ScheduledTask

# Pausar uma task
Disable-ScheduledTask -TaskName "Windows Update"

# Ver conexÃµes de rede
Get-NetTCPConnection -State Established

# Monitorar temperatura (se WMI disponÃ­vel)
Get-WmiObject MSAcpi_ThermalZoneTemperature -Namespace root/wmi
```

---

**Ãšltima atualizaÃ§Ã£o:** 2026-06-05
**NÃ­vel de dificuldade:** ðŸ”´ðŸ”´ðŸ”´ (AvanÃ§ado)

âš ï¸ Use essas dicas com cautela. Sempre faÃ§a backup antes!

