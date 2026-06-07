if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[X] Este script requer privilegios de ADMINISTRADOR!" -ForegroundColor Red
    exit
}

Clear-Host

Write-Host ""
Write-Host "========== MONITOR DE PERFORMANCE - FIREMAX ==========" -ForegroundColor Cyan
Write-Host "Monitoramento em Tempo Real do Sistema" -ForegroundColor Cyan
Write-Host ""
Write-Host "Pressione CTRL+C para sair" -ForegroundColor Yellow
Write-Host ""

$startTime = Get-Date

while ($true) {
    Clear-Host
    
    Write-Host "========== MONITOR DE PERFORMANCE - FIREMAX ==========" -ForegroundColor Cyan
    Write-Host ""
    
    $elapsedTime = (Get-Date) - $startTime
    Write-Host "[*] Tempo: $($elapsedTime.Hours)h $($elapsedTime.Minutes)m $($elapsedTime.Seconds)s" -ForegroundColor Yellow
    Write-Host ""
    
    $cpuLoad = Get-WmiObject -Class Win32_PerfFormattedData_PerfOS_Processor -Filter "Name='_Total'" -ErrorAction SilentlyContinue
    $cpuPercent = $cpuLoad.PercentProcessorTime
    
    $cpuColor = if ($cpuPercent -lt 30) { "Green" } elseif ($cpuPercent -lt 70) { "Yellow" } else { "Red" }
    Write-Host "=======================================================" -ForegroundColor Magenta
    Write-Host "[*] PROCESSADOR" -ForegroundColor Magenta
    Write-Host "=======================================================" -ForegroundColor Magenta
    Write-Host "  Uso: $cpuPercent%" -ForegroundColor $cpuColor
    Write-Host ""
    
    $os = Get-WmiObject -Class Win32_OperatingSystem
    $totalRam = $os.TotalVisibleMemorySize / 1MB
    $freeRam = $os.FreePhysicalMemory / 1MB
    $usedRam = $totalRam - $freeRam
    $ramPercent = [math]::Round(($usedRam / $totalRam) * 100, 1)
    
    $ramColor = if ($ramPercent -lt 50) { "Green" } elseif ($ramPercent -lt 80) { "Yellow" } else { "Red" }
    Write-Host "[*] MEMORIA RAM" -ForegroundColor Magenta
    Write-Host "  Total: $('{0:N2}' -f $totalRam) GB" -ForegroundColor Cyan
    Write-Host "  Em uso: $('{0:N2}' -f $usedRam) GB ($ramPercent%)" -ForegroundColor $ramColor
    Write-Host "  Livre: $('{0:N2}' -f $freeRam) GB" -ForegroundColor Cyan
    Write-Host ""
    
    $disks = Get-Volume | Where-Object { $_.DriveType -eq 'Fixed' }
    Write-Host "[*] DISCO" -ForegroundColor Magenta
    foreach ($disk in $disks) {
        $diskPercent = [math]::Round((($disk.Size - $disk.SizeRemaining) / $disk.Size) * 100, 1)
        $diskColor = if ($diskPercent -lt 50) { "Green" } elseif ($diskPercent -lt 80) { "Yellow" } else { "Red" }
        Write-Host "  $($disk.DriveLetter): $('{0:N2}' -f ($disk.SizeRemaining / 1GB)) GB livre ($([int]$diskPercent)% em uso)" -ForegroundColor $diskColor
    }
    Write-Host ""
    
    Write-Host "[*] TOP 10 PROCESSOS (Memoria)" -ForegroundColor Magenta
    Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 10 | ForEach-Object {
        $ramUsage = [math]::Round($_.WorkingSet / 1MB, 2)
        Write-Host "  $($_.ProcessName): $ramUsage MB" -ForegroundColor Cyan
    }
    Write-Host ""
    
    Write-Host "[*] GPU" -ForegroundColor Magenta
    $gpu = Get-WmiObject -Class Win32_VideoController
    foreach ($g in $gpu) {
        $gpuRam = $g.AdapterRAM
        if ($gpuRam) {
            Write-Host "  $($g.Name): $('{0:N2}' -f ($gpuRam / 1GB)) GB" -ForegroundColor Cyan
        } else {
            Write-Host "  $($g.Name)" -ForegroundColor Cyan
        }
    }
    Write-Host ""
    
    Write-Host "[*] REDE" -ForegroundColor Magenta
    $networkStats = netstat -b | Select-String "ESTABLISHED" | Measure-Object
    Write-Host "  Conexoes ativas: $($networkStats.Count)" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "=======================================================" -ForegroundColor Magenta
    Write-Host "Atualizando em 2 segundos (CTRL+C para sair)..." -ForegroundColor Yellow
    
    Start-Sleep -Seconds 2
}

