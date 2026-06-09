# FIREMAX - v1.0
# Otimizacao de PC

if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[X] Este script requer privilegios de ADMINISTRADOR!" -ForegroundColor Red
    Write-Host "Por favor, execute como Administrador e tente novamente." -ForegroundColor Yellow
    Read-Host "Pressione ENTER para sair"
    exit
}

$script:LogPath = "$PSScriptRoot\logs"
$script:BackupPath = "$PSScriptRoot\backups"
$script:ConfigPath = "$PSScriptRoot\config"

function Initialize-Folders {
    New-Item -ItemType Directory -Force -Path $LogPath | Out-Null
    New-Item -ItemType Directory -Force -Path $BackupPath | Out-Null
    New-Item -ItemType Directory -Force -Path $ConfigPath | Out-Null
}

function Write-Log {
    param([string]$Message, [string]$Type = "INFO")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logFile = "$LogPath\firemax_$(Get-Date -Format 'yyyyMMdd').log"
    
    $colorMap = @{
        "INFO"    = "Cyan"
        "SUCCESS" = "Green"
        "WARNING" = "Yellow"
        "ERROR"   = "Red"
    }
    
    Write-Host "[$Type] [$timestamp] $Message" -ForegroundColor $colorMap[$Type]
    "[$Type] [$timestamp] $Message" | Add-Content -Path $logFile
}

function Show-Banner {
    Clear-Host
    $w = 65
    $line = ('═' * ($w - 2))
    Write-Host "" 
    Write-Host "╔$line╗" -ForegroundColor Cyan
    $title = "FIREMAX v1.0"
    $titlePad = ([int](($w - 2 - $title.Length) / 2))
    $left = ' ' * $titlePad
    $right = ' ' * ($w - 2 - $titlePad - $title.Length)
    Write-Host "║$left$title$right║" -ForegroundColor Cyan
    Write-Host "║" + (' ' * ($w - 2)) + "║" -ForegroundColor Cyan
    $subtitle = "Otimizador de PC para Games"
    $subPad = ([int](($w - 2 - $subtitle.Length) / 2))
    $left2 = ' ' * $subPad
    $right2 = ' ' * ($w - 2 - $subPad - $subtitle.Length)
    Write-Host "║$left2" -NoNewline; Write-Host $subtitle -ForegroundColor Green -NoNewline; Write-Host "$right2║"
    Write-Host "║" + (' ' * ($w - 2)) + "║" -ForegroundColor Cyan
    Write-Host "╠$line╣" -ForegroundColor Magenta
    Write-Host "" 
}

function Show-Menu {
    Write-Host "===== MENU PRINCIPAL - FIREMAX v1.0 =====" -ForegroundColor Magenta
    Write-Host "feito por Firemax developer team" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  OTIMIZACOES" -ForegroundColor Yellow
    Write-Host "  1  - Limpeza de Sistema (Temp, Cache, Lixo)"
    Write-Host "  2  - Otimizar Inicializacao (Desabilitar Programas)"
    Write-Host "  3  - Liberar Memoria RAM"
    Write-Host "  4  - Desabilitar Efeitos Visuais (Boost Gaming)"
    Write-Host "  5  - Otimizar Disco (TRIM, Desfragmentacao)"
    Write-Host ""
    Write-Host "  GAMING" -ForegroundColor Cyan
    Write-Host "  6  - Modo Jogo (Desabilitar Notificacoes e Background Apps)"
    Write-Host "  7  - Gerenciar Prioridade de Processo"
    Write-Host "  8  - Boost FPS (Configuracoes de Energia)"
    Write-Host ""
    Write-Host "  MONITORAMENTO" -ForegroundColor Green
    Write-Host "  9  - Status do Sistema"
    Write-Host "  10 - Monitorar Temperatura do PC"
    Write-Host "  11 - Gerenciador de Processos"
    Write-Host ""
    Write-Host "  GERENCIAMENTO" -ForegroundColor Blue
    Write-Host "  12 - Fazer Backup de Configuracoes"
    Write-Host "  13 - Restaurar de Backup"
    Write-Host "  14 - Gerenciar Arquivos Temporarios"
    Write-Host ""
    Write-Host "  AVANCADO" -ForegroundColor Magenta
    Write-Host "  15 - Otimizacao Completa (Tudo de uma vez)"
    Write-Host "  16 - Restaurar Padroes"
    Write-Host ""
    Write-Host "  UTILITARIOS" -ForegroundColor Cyan
    Write-Host "  17 - Otimizar Rede (TCP)"
    Write-Host "  18 - Desabilitar Servicos Desnecessarios"
    Write-Host "  19 - Relatorio de Drivers"
    Write-Host "  20 - Excluir pasta de jogos do Defender"
    Write-Host "  21 - Limpar cache do Windows Update"
    Write-Host "  22 - Alternar Game Bar/Gravacao"
    Write-Host ""
    Write-Host "  GAME PROFILES" -ForegroundColor Cyan
    Write-Host "  23 - Perfil: Valorant / FPS Competitivo"
    Write-Host "  24 - Perfil: Counter-Strike 2 / FPS Competitivo"
    Write-Host "  25 - Perfil: Fortnite / Battle Royale"
    Write-Host "  26 - Perfil: Among Us / Leve"
    Write-Host "  27 - Perfil: Far Cry 5 / AAA"
    Write-Host "  28 - Perfil: The Forest / Survival"
    Write-Host "  29 - Perfil: Minecraft / Java"
    Write-Host "  30 - Perfil: Roblox / Cliente"
    Write-Host ""
    Write-Host "  0  - Sair" -ForegroundColor Red
    Write-Host ""
}

function Optimize-SystemCleanup {
    Show-Banner
    Write-Host "[*] INICIANDO LIMPEZA DE SISTEMA..." -ForegroundColor Yellow
    Write-Host ""
    
    $totalFreed = 0
    
    Write-Host "  -> Limpando arquivos temporarios..." -ForegroundColor Cyan
    $tempPaths = @(
        "$env:TEMP",
        "$env:SystemRoot\Temp",
        "$env:LOCALAPPDATA\Temp"
    )
    
    foreach ($path in $tempPaths) {
        if (Test-Path $path) {
            $size = (Get-ChildItem $path -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
            Remove-Item "$path\*" -Force -ErrorAction SilentlyContinue -Recurse
            $totalFreed += $size
        }
    }
    
    Write-Host "  -> Limpando cache do sistema..." -ForegroundColor Cyan
    Remove-Item "$env:LocalAppData\Microsoft\Windows\INetCache\*" -Force -Recurse -ErrorAction SilentlyContinue
    
    Write-Host "  -> Esvaziando Lixeira..." -ForegroundColor Cyan
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue
    
    Write-Host "  -> Limpando arquivos obsoletos do Windows..." -ForegroundColor Cyan
    Cleanmgr /sageset:1 -ErrorAction SilentlyContinue
    Cleanmgr /sagerun:1 -ErrorAction SilentlyContinue
    
    Write-Log "Limpeza concluida. Espaco liberado: $('{0:N2}' -f ($totalFreed / 1MB)) MB" "SUCCESS"
    Write-Host ""
    Write-Host "[+] Limpeza concluida! Espaco liberado: $('{0:N2}' -f ($totalFreed / 1MB)) MB" -ForegroundColor Green
    Read-Host "Pressione ENTER para continuar"
}

    function Apply-GameProfile {
        param([string]$ProfileName)
        Show-Banner
        Write-Host "[*] Aplicando perfil: $ProfileName" -ForegroundColor Cyan
        Write-Host "  -> Aplicando otimizacoes gerais (FPS, energia, background)" -ForegroundColor Cyan
        Boost-FPS
        Optimize-Startup
        Optimize-Memory
        Optimize-VisualEffects
        Write-Log "Perfil aplicado: $ProfileName" "SUCCESS"
        Write-Host "[+] Perfil $ProfileName aplicado. Inicie o jogo agora." -ForegroundColor Green
        Read-Host "Pressione ENTER para continuar"
    }

    function Profile-Valorant { Apply-GameProfile -ProfileName 'Valorant (FPS Competitivo)' }
    function Profile-CS2 { Apply-GameProfile -ProfileName 'CS 2 (FPS Competitivo)' }
    function Profile-Fortnite { Apply-GameProfile -ProfileName 'Fortnite (Battle Royale)' }
    function Profile-AmongUs { Apply-GameProfile -ProfileName 'Among Us (Leve)' }
    function Profile-FarCry5 { Apply-GameProfile -ProfileName 'Far Cry 5 (AAA)' }
    function Profile-TheForest { Apply-GameProfile -ProfileName 'The Forest (Survival)' }

    function Profile-Minecraft {
        Apply-GameProfile -ProfileName 'Minecraft (Java)'
        Write-Host "[*] Aplicando otimizações específicas para Minecraft..." -ForegroundColor Cyan
        try {
            $proc = Get-Process -Name 'javaw' -ErrorAction SilentlyContinue
            if ($proc) {
                $proc | ForEach-Object {
                    try { $_.PriorityClass = 'High' } catch {}
                }
                Write-Host "[+] Prioridade de 'javaw' ajustada para High" -ForegroundColor Green
                Write-Log "Minecraft: javaw priority set to High" "SUCCESS"
            } else {
                Write-Host "[!] Processo 'javaw' nao encontrado. Inicie o Minecraft e aplique novamente." -ForegroundColor Yellow
            }
        } catch {
            Write-Host "[X] Erro ao ajustar processo javaw: $($_.Exception.Message)" -ForegroundColor Red
            Write-Log "Minecraft profile error: $($_.Exception.Message)" "ERROR"
        }
        Read-Host "Pressione ENTER para continuar"
    }

    function Profile-Roblox {
        Apply-GameProfile -ProfileName 'Roblox (Cliente)'
        Write-Host "[*] Aplicando otimizações específicas para Roblox..." -ForegroundColor Cyan
        try {
            $proc = Get-Process -Name 'RobloxPlayerBeta' -ErrorAction SilentlyContinue
            if (-not $proc) { $proc = Get-Process -Name 'RobloxPlayer' -ErrorAction SilentlyContinue }
            if ($proc) {
                $proc | ForEach-Object {
                    try { $_.PriorityClass = 'High' } catch {}
                }
                Write-Host "[+] Prioridade do processo Roblox ajustada para High" -ForegroundColor Green
                Write-Log "Roblox: process priority set to High" "SUCCESS"
            } else {
                Write-Host "[!] Processo do Roblox nao encontrado. Inicie o jogo e aplique novamente." -ForegroundColor Yellow
            }
        } catch {
            Write-Host "[X] Erro ao ajustar processo Roblox: $($_.Exception.Message)" -ForegroundColor Red
            Write-Log "Roblox profile error: $($_.Exception.Message)" "ERROR"
        }
        Read-Host "Pressione ENTER para continuar"
    }

function Optimize-Startup {
    Show-Banner
    Write-Host "[*] OTIMIZANDO INICIALIZACAO..." -ForegroundColor Yellow
    Write-Host ""
    
    $startupItems = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -ErrorAction SilentlyContinue
    $i = 1
    
    $startupItems.PSObject.Properties | Where-Object { $_.Name -notmatch "^PS" } | ForEach-Object {
        Write-Host "$i. $($_.Name)"
        $i++
    }
    
    Write-Host ""
    Write-Host "Desabilitar programas desnecessarios? (S/N)" -ForegroundColor Yellow
    $confirm = Read-Host
    
    if ($confirm -eq "S" -or $confirm -eq "s") {
        Write-Host ""
        Write-Host "Recomendados: OneDrive, Cortana, Weather, Tips" -ForegroundColor Green
        Write-Host ""
        
        Get-CimInstance Win32_StartupCommand | Where-Object { $_.Name -like "*OneDrive*" -or $_.Name -like "*Cortana*" } | ForEach-Object {
            Write-Host "  Desabilitando: $($_.Name)" -ForegroundColor Cyan
            Remove-ItemProperty -Path $_.Location -Name $_.Name -ErrorAction SilentlyContinue
        }
        
        Write-Log "Inicializacao otimizada" "SUCCESS"
        Write-Host "[+] Otimizacao concluida!" -ForegroundColor Green
    }
    
    Read-Host "Pressione ENTER para continuar"
}

function Optimize-Memory {
    Show-Banner
    Write-Host "[*] LIBERANDO MEMORIA RAM..." -ForegroundColor Yellow
    Write-Host ""
    
    $memBefore = (Get-WmiObject win32_operatingsystem).TotalVisibleMemorySize
    $memUsedBefore = (Get-WmiObject win32_operatingsystem).TotalVisibleMemorySize - (Get-WmiObject win32_operatingsystem).FreePhysicalMemory
    
    Write-Host "Memoria antes: $('{0:N2}' -f ($memBefore / 1MB)) GB" -ForegroundColor Cyan
    Write-Host "Em uso: $('{0:N2}' -f ($memUsedBefore / 1MB)) GB" -ForegroundColor Cyan
    Write-Host ""
    
        Write-Host "  -> Limpando cache..." -ForegroundColor Cyan
        Get-Process | ForEach-Object {
            try {
                if ($_.MinWorkingSet -ne $null -and $_.MaxWorkingSet -ne $null) {
                    $_.MinWorkingSet = $_.MinWorkingSet
                    $_.MaxWorkingSet = $_.MaxWorkingSet
                }
            } catch {
                # Ignorar processos que nao permitem alteracoes
            }
        }
    
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
    
    Start-Sleep -Seconds 2
    
    $memAfter = (Get-WmiObject win32_operatingsystem).TotalVisibleMemorySize
    $memUsedAfter = (Get-WmiObject win32_operatingsystem).TotalVisibleMemorySize - (Get-WmiObject win32_operatingsystem).FreePhysicalMemory
    $memFreed = $memUsedBefore - $memUsedAfter
    
    Write-Host ""
    Write-Host "Liberado: $('{0:N2}' -f ($memFreed / 1024)) MB" -ForegroundColor Green
    Write-Host "Em uso agora: $('{0:N2}' -f ($memUsedAfter / 1MB)) GB" -ForegroundColor Green
    
    Write-Log "Memoria liberada: $('{0:N2}' -f ($memFreed / 1024)) MB" "SUCCESS"
    
    Read-Host "Pressione ENTER para continuar"
}

function Optimize-VisualEffects {
    Show-Banner
    Write-Host "[*] DESABILITANDO EFEITOS VISUAIS..." -ForegroundColor Yellow
    Write-Host ""
    
    Write-Host "[!] Efeitos a desabilitar:" -ForegroundColor Yellow
    Write-Host "  - Animacoes de transicao"
    Write-Host "  - Sombras em janelas"
    Write-Host "  - Transparency"
    Write-Host ""
    Write-Host "Continuar? (S/N)" -ForegroundColor Cyan
    $confirm = Read-Host
    
    if ($confirm -eq "S" -or $confirm -eq "s") {
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisallowShaking /t REG_DWORD /d 1 /f
        reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012078002000000 /f
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f
        
        Write-Log "Efeitos visuais desabilitados" "SUCCESS"
        Write-Host "[+] Concluido!" -ForegroundColor Green
        Write-Host "[!] Pode ser necessario reiniciar." -ForegroundColor Yellow
    }
    
    Read-Host "Pressione ENTER para continuar"
}

function Optimize-Disk {
    Show-Banner
    Write-Host "[*] OTIMIZANDO DISCO..." -ForegroundColor Yellow
    Write-Host ""
    
    $drives = Get-Volume | Where-Object { $_.DriveType -eq 'Fixed' }
    
    foreach ($drive in $drives) {
        $letter = $drive.DriveLetter
        if (-not $letter) {
            Write-Host "Pulando volume sem letra de unidade." -ForegroundColor Yellow
            continue
        }

        Write-Host "Drive: $letter" -ForegroundColor Cyan
        Write-Host "  -> Executando TRIM..." -ForegroundColor Cyan
        try {
            Optimize-Volume -DriveLetter $letter -Defrag -ErrorAction Stop
        } catch {
            Write-Host "  [!] Erro ao otimizar $($letter): $($_.Exception.Message)" -ForegroundColor Red
        }

        $size = $drive.Size
        $sizeRemaining = $drive.SizeRemaining
        $percentFree = [math]::Round(($sizeRemaining / $size) * 100, 2)

        Write-Host "  Total: $('{0:N2}' -f ($size / 1GB)) GB" -ForegroundColor Green
        Write-Host "  Livre: $('{0:N2}' -f ($sizeRemaining / 1GB)) GB ($percentFree%)" -ForegroundColor Green
        Write-Host ""
    }
    
    Write-Log "Disco otimizado" "SUCCESS"
    Write-Host "[+] Concluido!" -ForegroundColor Green
    Read-Host "Pressione ENTER para continuar"
}

function Enable-GameMode {
    Show-Banner
    Write-Host "[*] ATIVANDO MODO JOGO..." -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "  -> Desabilitando notificacoes..." -ForegroundColor Cyan
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v NOC_GLOBAL_SETTING_ALLOW_NOTIFICATION_SOUND /t REG_DWORD /d 0 /f
    
    Write-Host "  -> Pausando Windows Update..." -ForegroundColor Cyan
    Stop-Service wuauserv -Force -ErrorAction SilentlyContinue
    
    Write-Host "  -> Desabilitando background apps..." -ForegroundColor Cyan
    Get-AppXPackage | ForEach-Object {
        try {
            Remove-AppxPackage $_ -ErrorAction SilentlyContinue
        } catch {}
    }
    
    Write-Host "  -> Otimizando GPU..." -ForegroundColor Cyan
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v UseOLEDTaskbarTransparency /t REG_DWORD /d 0 /f
    
    Write-Log "Modo jogo ativado" "SUCCESS"
    Write-Host "[+] Ativado!" -ForegroundColor Green
    Write-Host "    Notificacoes e background apps desabilitados." -ForegroundColor Yellow
    
    Read-Host "Pressione ENTER para continuar"
}

function Manage-ProcessPriority {
    Show-Banner
    Write-Host "[*] GERENCIADOR DE PRIORIDADE..." -ForegroundColor Magenta
    Write-Host ""
    
    Write-Host "Processos:" -ForegroundColor Cyan
    Get-Process | Select-Object -First 15 -Property @{Label="ID";Expression={$_.Id}},@{Label="Nome";Expression={$_.ProcessName}},@{Label="MB";Expression={[math]::Round($_.WorkingSet/1MB,2)}} | Format-Table -AutoSize
    
    Write-Host ""
    Write-Host "Digite o nome do processo:" -ForegroundColor Yellow
    $processName = Read-Host "Nome"
    
    if ($processName) {
        $process = Get-Process -Name $processName -ErrorAction SilentlyContinue
        
        if ($process) {
            Write-Host ""
            Write-Host "Prioridades:" -ForegroundColor Cyan
            Write-Host "1=Low  2=BelowNormal  3=Normal  4=AboveNormal  5=High  6=Realtime"
            Write-Host ""
            
            $priority = Read-Host "Selecione (1-6)"
            $priorityMap = @{"1" = "Low"; "2" = "BelowNormal"; "3" = "Normal"; "4" = "AboveNormal"; "5" = "High"; "6" = "Realtime"}
            
            if ($priorityMap.ContainsKey($priority)) {
                $process.PriorityClass = $priorityMap[$priority]
                Write-Log "Prioridade alterada: $($priorityMap[$priority])" "SUCCESS"
                Write-Host "[+] Alterado para: $($priorityMap[$priority])" -ForegroundColor Green
            }
        } else {
            Write-Host "[X] Processo nao encontrado!" -ForegroundColor Red
        }
    }
    
    Read-Host "Pressione ENTER para continuar"
}

function Boost-FPS {
    Show-Banner
    Write-Host "[*] OTIMIZACAO DE FPS..." -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "  -> Configurando modo de alta performance..." -ForegroundColor Cyan
    
    $guid = $null
    try {
        $lines = (powercfg /L) -split "`n"
        foreach ($ln in $lines) {
            if ($ln -match 'Power Scheme GUID:\s*([a-fA-F0-9\-]{36})\s*\((.*)\)') {
                $foundGuid = $matches[1]
                $name = $matches[2]
                if ($name -match '(High performance|High-performance|Alto desempenho|Alto desempenho)') {
                    $guid = $foundGuid; break
                }
            }
        }
    } catch {
        $guid = $null
    }

    if (-not $guid) { $guid = '8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c' }
    try {
        powercfg /setactive $guid
        Write-Host "  [+] Plano de energia alterado" -ForegroundColor Green
    } catch {
        Write-Host "  [!] Nao foi possivel alterar o plano de energia: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    Write-Host "  -> Desabilitando economia de energia..." -ForegroundColor Cyan
    powercfg /change monitor-timeout-ac 0
    powercfg /change disk-timeout-ac 0
    
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v HistoricalCaptureEnabled /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\XboxGameBarUI" /v UseNexusForGameBarEnabled /t REG_DWORD /d 0 /f
    
    Write-Log "FPS otimizado" "SUCCESS"
    Write-Host "[+] Otimizacao concluida!" -ForegroundColor Green
    Write-Host "    Modo de alta performance ativado!" -ForegroundColor Yellow
    
    Read-Host "Pressione ENTER para continuar"
}

function Optimize-Network {
    Show-Banner
    Write-Host "[*] OTIMIZANDO REDE (TCP)..." -ForegroundColor Cyan
    Write-Host ""
    try {
        Write-Host "  -> Desabilitando heuristicas TCP e autotuning..." -ForegroundColor Cyan
        netsh int tcp set heuristics disabled | Out-Null
        netsh int tcp set global autotuninglevel=disabled | Out-Null
        netsh int tcp set global congestionprovider=ctcp | Out-Null
        Write-Log "Network: TCP heuristics and autotuning adjusted" "SUCCESS"
        Write-Host "[+] Configuracoes de rede ajustadas." -ForegroundColor Green
    } catch {
        Write-Log "Network optimization failed: $($_.Exception.Message)" "ERROR"
        Write-Host "[X] Nao foi possivel aplicar ajustes de rede: $($_.Exception.Message)" -ForegroundColor Red
    }
    Read-Host "Pressione ENTER para continuar"
}

function Optimize-Services {
    Show-Banner
    Write-Host "[*] GERENCIAR SERVICOS DESNECESSARIOS..." -ForegroundColor Cyan
    Write-Host ""
    $candidates = @('SysMain','WSearch')
    Write-Host "Servicos recomendados para desabilitar: $($candidates -join ', ')" -ForegroundColor Yellow
    Write-Host "Deseja desabilitar estes servicos? (S/N)" -ForegroundColor Cyan
    $confirm = Read-Host
    if ($confirm -eq 'S' -or $confirm -eq 's') {
        foreach ($svc in $candidates) {
            try {
                Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
                Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
                Write-Host "  [+] $svc desabilitado" -ForegroundColor Green
                Write-Log "Servico desabilitado: $svc" "SUCCESS"
            } catch {
                Write-Host "  [!] Nao foi possivel desabilitar $($svc): $($_.Exception.Message)" -ForegroundColor Red
            }
        }
    }
    Read-Host "Pressione ENTER para continuar"
}

function Driver-Report {
    Show-Banner
    Write-Host "[*] GERANDO RELATORIO DE DRIVERS..." -ForegroundColor Cyan
    $out = "$PSScriptRoot\backups\drivers_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
    try {
        driverquery /v /fo list > $out
        Write-Log "Driver report generated: $out" "SUCCESS"
        Write-Host "[+] Relatorio salvo em: $out" -ForegroundColor Green
    } catch {
        Write-Log "Driver report failed: $($_.Exception.Message)" "ERROR"
        Write-Host "[X] Falha ao gerar relatorio: $($_.Exception.Message)" -ForegroundColor Red
    }
    Read-Host "Pressione ENTER para continuar"
}

function Defender-ExcludeGames {
    Show-Banner
    Write-Host "[*] ADICIONAR EXCECAO AO WINDOWS DEFENDER..." -ForegroundColor Cyan
    Write-Host "Digite o caminho da pasta de jogos (ex: C:\Games)" -ForegroundColor Yellow
    $path = Read-Host
    if (-not (Test-Path $path)) {
        Write-Host "[X] Caminho nao encontrado!" -ForegroundColor Red
        Read-Host "Pressione ENTER para continuar"
        return
    }
    try {
        Add-MpPreference -ExclusionPath $path -ErrorAction Stop
        Write-Log "Added Defender exclusion: $path" "SUCCESS"
        Write-Host "[+] Pasta adicionada às exclusoes do Defender." -ForegroundColor Green
    } catch {
        Write-Log "Defender exclusion failed: $($_.Exception.Message)" "ERROR"
        Write-Host "[X] Nao foi possivel adicionar a exclusao: $($_.Exception.Message)" -ForegroundColor Red
    }
    Read-Host "Pressione ENTER para continuar"
}

function Clean-WindowsUpdateCache {
    Show-Banner
    Write-Host "[*] LIMPAR CACHE DO WINDOWS UPDATE..." -ForegroundColor Cyan
    Write-Host "Isso ira pausar o servico Windows Update e apagar os arquivos de download." -ForegroundColor Yellow
    Write-Host "Deseja continuar? (S/N)" -ForegroundColor Cyan
    $confirm = Read-Host
    if ($confirm -eq 'S' -or $confirm -eq 's') {
        try {
            Stop-Service wuauserv -Force -ErrorAction SilentlyContinue
            Remove-Item -Path "$env:SystemRoot\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
            Start-Service wuauserv -ErrorAction SilentlyContinue
            Write-Log "Windows Update cache cleared" "SUCCESS"
            Write-Host "[+] Cache do Windows Update limpo." -ForegroundColor Green
        } catch {
            Write-Log "Failed to clear Windows Update cache: $($_.Exception.Message)" "ERROR"
            Write-Host "[X] Falha ao limpar cache: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
    Read-Host "Pressione ENTER para continuar"
}

function Toggle-GameBar {
    Show-Banner
    Write-Host "[*] ALTERNAR GAME BAR E GRAVACAO..." -ForegroundColor Cyan
    try {
        $val = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name AppCaptureEnabled -ErrorAction SilentlyContinue
        $current = $val.AppCaptureEnabled
        if ($current -eq 1) { $new = 0 } else { $new = 1 }
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d $new /f
        Write-Log "GameBar toggled to: $new" "SUCCESS"
        Write-Host "[+] Game Bar agora: $new" -ForegroundColor Green
    } catch {
        Write-Log "Toggle GameBar failed: $($_.Exception.Message)" "ERROR"
        Write-Host "[X] Falha ao alternar Game Bar: $($_.Exception.Message)" -ForegroundColor Red
    }
    Read-Host "Pressione ENTER para continuar"
}

function Show-SystemStatus {
    Show-Banner
    Write-Host "[*] STATUS DO SISTEMA..." -ForegroundColor Green
    Write-Host ""
    
    $cpu = Get-WmiObject -Class Win32_Processor
    Write-Host "=== PROCESSADOR ===" -ForegroundColor Yellow
    Write-Host "  Nome: $($cpu.Name)" -ForegroundColor Cyan
    Write-Host "  Nucleos: $($cpu.NumberOfCores)" -ForegroundColor Cyan
    Write-Host "  Threads: $($cpu.ThreadCount)" -ForegroundColor Cyan
    Write-Host "  Velocidade: $($cpu.MaxClockSpeed) MHz" -ForegroundColor Cyan
    Write-Host ""
    
    $os = Get-WmiObject -Class Win32_OperatingSystem
    $totalRam = $os.TotalVisibleMemorySize / 1MB
    $freeRam = $os.FreePhysicalMemory / 1MB
    $usedRam = $totalRam - $freeRam
    $ramPercent = [math]::Round(($usedRam / $totalRam) * 100, 2)
    
    Write-Host "=== MEMORIA RAM ===" -ForegroundColor Yellow
    Write-Host "  Total: $('{0:N2}' -f $totalRam) GB" -ForegroundColor Cyan
    Write-Host "  Em uso: $('{0:N2}' -f $usedRam) GB ($ramPercent%)" -ForegroundColor Cyan
    Write-Host "  Livre: $('{0:N2}' -f $freeRam) GB" -ForegroundColor Cyan
    Write-Host ""
    
    $disks = Get-Volume | Where-Object { $_.DriveType -eq 'Fixed' }
    Write-Host "=== DISCO ===" -ForegroundColor Yellow
    foreach ($disk in $disks) {
        $percentFree = [math]::Round(($disk.SizeRemaining / $disk.Size) * 100, 2)
        Write-Host "  $($disk.DriveLetter): $('{0:N2}' -f ($disk.SizeRemaining / 1GB)) GB livre ($percentFree%)" -ForegroundColor Cyan
    }
    Write-Host ""
    
    Write-Host "=== PLACA DE VIDEO ===" -ForegroundColor Yellow
    $gpu = Get-WmiObject -Class Win32_VideoController
    foreach ($g in $gpu) {
        Write-Host "  $($g.Name)" -ForegroundColor Cyan
        Write-Host "  VRAM: $('{0:N2}' -f ($g.AdapterRAM / 1GB)) GB" -ForegroundColor Cyan
    }
    Write-Host ""
    
    Write-Host "=== TOP 5 PROCESSOS ===" -ForegroundColor Yellow
    Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 5 | ForEach-Object {
        Write-Host "  $($_.ProcessName): $('{0:N2}' -f ($_.WorkingSet / 1MB)) MB" -ForegroundColor Cyan
    }
    Write-Host ""
    
    Read-Host "Pressione ENTER para continuar"
}

function Monitor-Temperature {
    Show-Banner
    Write-Host "[*] MONITORANDO TEMPERATURA..." -ForegroundColor Green
    Write-Host ""
    
    Write-Host "[!] Requer software de monitoramento" -ForegroundColor Yellow
    Write-Host ""
    
    Write-Host "Para monitorar temperatura, instale:" -ForegroundColor Cyan
    Write-Host "  - HWiNFO (hwinfo.com)"
    Write-Host "  - Open Hardware Monitor"
    Write-Host "  - GPU-Z (NVIDIA)"
    Write-Host "  - Ryzen Master (AMD)"
    
    Write-Host ""
    Write-Host "Intervalos seguros:" -ForegroundColor Cyan
    Write-Host "  CPU: 30-50C (ocioso), ate 80-85C (carga)" -ForegroundColor Green
    Write-Host "  GPU: 30-55C (ocioso), ate 70-80C (gaming)" -ForegroundColor Green
    Write-Host ""
    
    Read-Host "Pressione ENTER para continuar"
}

function Process-Manager {
    Show-Banner
    Write-Host "[*] GERENCIADOR DE PROCESSOS..." -ForegroundColor Magenta
    Write-Host ""
    
    Write-Host "1. Listar processos"
    Write-Host "2. Buscar processo"
    Write-Host "3. Encerrar processo"
    Write-Host "4. Voltar"
    Write-Host ""
    
    $choice = Read-Host "Opcao"
    
    switch ($choice) {
        "1" {
            Show-Banner
            Get-Process | Select-Object -Property ID,ProcessName,@{Label="MB";Expression={[math]::Round($_.WorkingSet/1MB,2)}} | Format-Table -AutoSize
            Read-Host "Pressione ENTER"
        }
        "2" {
            Show-Banner
            $search = Read-Host "Nome do processo"
            Get-Process -Name "*$search*" -ErrorAction SilentlyContinue | Select-Object -Property ID,ProcessName,@{Label="MB";Expression={[math]::Round($_.WorkingSet/1MB,2)}} | Format-Table -AutoSize
            Read-Host "Pressione ENTER"
        }
        "3" {
            Show-Banner
            $pname = Read-Host "Nome do processo"
            $p = Get-Process -Name $pname -ErrorAction SilentlyContinue
            
            if ($p) {
                Write-Host "Encontrado: $($p.ProcessName)" -ForegroundColor Yellow
                $confirm = Read-Host "Encerrar? (S/N)"
                
                if ($confirm -eq "S" -or $confirm -eq "s") {
                    $p | Stop-Process -Force -ErrorAction SilentlyContinue
                    Write-Host "[+] Encerrado!" -ForegroundColor Green
                }
            } else {
                Write-Host "[X] Nao encontrado!" -ForegroundColor Red
            }
            Read-Host "Pressione ENTER"
        }
    }
}

function Backup-Configuration {
    Show-Banner
    Write-Host "[*] FAZENDO BACKUP..." -ForegroundColor Magenta
    Write-Host ""
    
    $backupName = "backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    $backupDir = "$BackupPath\$backupName"
    
    New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
    
    Write-Host "  -> Registry..." -ForegroundColor Cyan
    reg export "HKCU\Software\Microsoft\Windows\CurrentVersion" "$backupDir\registry_user.reg" /y
    reg export "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion" "$backupDir\registry_system.reg" /y
    
    Write-Host "  -> Rede..." -ForegroundColor Cyan
    ipconfig /all | Out-File "$backupDir\network_config.txt"
    
    Write-Host "  -> Drivers..." -ForegroundColor Cyan
    driverquery /v | Out-File "$backupDir\drivers.txt"
    
    Write-Host "  -> Programas..." -ForegroundColor Cyan
    Get-WmiObject -Class Win32_Product | Export-Csv "$backupDir\installed_programs.csv" -NoTypeInformation
    
    Write-Log "Backup criado: $backupName" "SUCCESS"
    Write-Host "[+] Concluido: $backupDir" -ForegroundColor Green
    
    Read-Host "Pressione ENTER para continuar"
}

function Restore-Backup {
    Show-Banner
    Write-Host "[*] RESTAURAR BACKUP..." -ForegroundColor Magenta
    Write-Host ""
    
    $backups = Get-ChildItem $BackupPath -Directory | Sort-Object Name -Descending
    
    if ($backups.Count -eq 0) {
        Write-Host "[X] Nenhum backup!" -ForegroundColor Red
        Read-Host "Pressione ENTER"
        return
    }
    
    Write-Host "Backups disponiveis:" -ForegroundColor Cyan
    for ($i = 0; $i -lt $backups.Count; $i++) {
        Write-Host "$($i + 1). $($backups[$i].Name)"
    }
    
    Write-Host ""
    $idx = [int](Read-Host "Selecione") - 1
    
    if ($idx -ge 0 -and $idx -lt $backups.Count) {
        $sel = $backups[$idx]
        Write-Host "Restaurando: $($sel.Name)" -ForegroundColor Yellow
        Write-Host "[!] Isso pode substituir suas configs!" -ForegroundColor Red
        $confirm = Read-Host "Continuar? (S/N)"
        
        if ($confirm -eq "S" -or $confirm -eq "s") {
            Write-Host "  -> Restaurando Registry..." -ForegroundColor Cyan
            reg import "$($sel.FullName)\registry_user.reg" 2>$null
            
            Write-Log "Backup restaurado: $($sel.Name)" "SUCCESS"
            Write-Host "[+] Concluido!" -ForegroundColor Green
        }
    } else {
        Write-Host "[X] Selecao invalida!" -ForegroundColor Red
    }
    
    Read-Host "Pressione ENTER"
}

function Manage-TempFiles {
    Show-Banner
    Write-Host "[*] ARQUIVOS TEMPORARIOS..." -ForegroundColor Blue
    Write-Host ""
    
    $tempFolders = @(
        "$env:TEMP",
        "$env:SystemRoot\Temp",
        "$env:LOCALAPPDATA\Temp",
        "$env:ProgramData\Microsoft\Windows\Caches"
    )
    
    Write-Host "Analisando..." -ForegroundColor Cyan
    Write-Host ""
    
    $totalSize = 0
    $fileCount = 0
    
    foreach ($folder in $tempFolders) {
        if (Test-Path $folder) {
            $items = Get-ChildItem $folder -Recurse -ErrorAction SilentlyContinue
            $size = ($items | Measure-Object -Property Length -Sum).Sum
            $count = ($items | Measure-Object).Count
            
            Write-Host "[*] $folder"
            Write-Host "    Tamanho: $('{0:N2}' -f ($size / 1MB)) MB" -ForegroundColor Yellow
            Write-Host "    Arquivos: $count" -ForegroundColor Yellow
            Write-Host ""
            
            $totalSize += $size
            $fileCount += $count
        }
    }
    
    Write-Host "=====================================" -ForegroundColor Cyan
    Write-Host "Total: $('{0:N2}' -f ($totalSize / 1MB)) MB | $fileCount arquivos" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Limpar tudo? (S/N)" -ForegroundColor Magenta
    $confirm = Read-Host
    
    if ($confirm -eq "S" -or $confirm -eq "s") {
        foreach ($folder in $tempFolders) {
            if (Test-Path $folder) {
                Remove-Item "$folder\*" -Force -Recurse -ErrorAction SilentlyContinue
                Write-Host "[+] Limpado: $folder" -ForegroundColor Green
            }
        }
        Write-Host "[+] Concluido!" -ForegroundColor Green
    }
    
    Read-Host "Pressione ENTER"
}

function Full-Optimization {
    Show-Banner
    Write-Host "[*] OTIMIZACAO COMPLETA..." -ForegroundColor Magenta
    Write-Host ""
    Write-Host "[!] Isso pode levar varios minutos!" -ForegroundColor Yellow
    $confirm = Read-Host "Continuar? (S/N)"
    
    if ($confirm -eq "S" -or $confirm -eq "s") {
        Write-Log "Otimizacao completa iniciada" "INFO"
        
        Backup-Configuration
        Optimize-SystemCleanup
        Optimize-Startup
        Optimize-Memory
        Optimize-VisualEffects
        Optimize-Disk
        Boost-FPS
        
        Write-Log "Otimizacao completa concluida" "SUCCESS"
        Show-Banner
        Write-Host "[+] CONCLUIDA!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Mudancas:" -ForegroundColor Yellow
        Write-Host "  [+] Sistema limpo"
        Write-Host "  [+] Inicializacao otimizada"
        Write-Host "  [+] Memoria liberada"
        Write-Host "  [+] Efeitos visuais desabilitados"
        Write-Host "  [+] Disco otimizado"
        Write-Host "  [+] FPS otimizado"
        Write-Host ""
        Write-Host "[!] RECOMENDA-SE REINICIAR!" -ForegroundColor Yellow
    }
    
    Read-Host "Pressione ENTER"
}

function Restore-Defaults {
    Show-Banner
    Write-Host "[!] RESTAURAR PADROES..." -ForegroundColor Red
    Write-Host ""
    Write-Host "[X] ATENCAO: Vai reverter TUDO!" -ForegroundColor Red
    $confirm = Read-Host "Continuar? (S/N)"
    
    if ($confirm -eq "S" -or $confirm -eq "s") {
        Write-Host "Confirme digitando: CONFIRMAR" -ForegroundColor Red
        $confirm2 = Read-Host
        
        if ($confirm2 -eq "CONFIRMAR") {
            Write-Host "Restaurando..." -ForegroundColor Yellow
            
            reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f
            reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisallowShaking /t REG_DWORD /d 0 /f
            reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 1 /f
            reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v NOC_GLOBAL_SETTING_ALLOW_NOTIFICATION_SOUND /t REG_DWORD /d 1 /f
            Start-Service wuauserv -ErrorAction SilentlyContinue
            
            Write-Log "Padroes restaurados" "SUCCESS"
            Write-Host "[+] Concluido!" -ForegroundColor Green
            Write-Host "[!] RECOMENDA-SE REINICIAR!" -ForegroundColor Yellow
        } else {
            Write-Host "Cancelado." -ForegroundColor Yellow
        }
    }
    
    Read-Host "Pressione ENTER"
}

function Main {
    Initialize-Folders
    
    while ($true) {
        Show-Banner
        Show-Menu
        
        $choice = Read-Host "Opcao"
        
        switch ($choice) {
            "1" { Optimize-SystemCleanup }
            "2" { Optimize-Startup }
            "3" { Optimize-Memory }
            "4" { Optimize-VisualEffects }
            "5" { Optimize-Disk }
            "6" { Enable-GameMode }
            "7" { Manage-ProcessPriority }
            "8" { Boost-FPS }
            "9" { Show-SystemStatus }
            "10" { Monitor-Temperature }
            "11" { Process-Manager }
            "12" { Backup-Configuration }
            "13" { Restore-Backup }
            "14" { Manage-TempFiles }
            "15" { Full-Optimization }
            "16" { Restore-Defaults }
            "17" { Optimize-Network }
            "18" { Optimize-Services }
            "19" { Driver-Report }
            "20" { Defender-ExcludeGames }
            "21" { Clean-WindowsUpdateCache }
            "22" { Toggle-GameBar }
            "23" { Profile-Valorant }
            "24" { Profile-CSGO }
            "25" { Profile-Fortnite }
            "26" { Profile-AmongUs }
            "27" { Profile-FarCry5 }
            "28" { Profile-TheForest }
            "29" { Profile-Minecraft }
            "30" { Profile-Roblox }
            "0" {
                Show-Banner
                Write-Host "Obrigado por usar FIREMAX!" -ForegroundColor Cyan
                Write-Host ""
                Write-Host "Logs: $LogPath" -ForegroundColor Yellow
                Write-Host "Backups: $BackupPath" -ForegroundColor Yellow
                exit
            }
            default {
                Write-Host "[X] Opcao invalida!" -ForegroundColor Red
                Read-Host "Pressione ENTER"
            }
        }
    }
}

Main

