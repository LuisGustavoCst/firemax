@echo off
REM FIREMAX - instalador de requisitos em lote

set SCRIPT=%~dp0install-requisitos.ps1
if not exist "%SCRIPT%" (
    echo Arquivo install-requisitos.ps1 nao encontrado.
    pause
    exit /b 1
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT%"
pause
