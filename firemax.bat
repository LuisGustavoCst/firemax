@echo off
chcp 65001 >nul 2>&1

title Administrador: firemax - Atalho
mode con: cols=120 lines=50 >nul 2>&1
cls
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ============================================================
    echo.
    echo [X] ERRO: Este arquivo requer privilegios de ADMINISTRADOR!
    echo.
    echo Por favor:
    echo 1. Clique com botao direito neste arquivo
    echo 2. Selecione "Executar como administrador"
    echo.
    echo ============================================================
    echo.
    pause
    exit /b
)

setlocal enabledelayedexpansion
set SCRIPT_DIR=%~dp0

cls

echo.
echo ============================================================
echo.
echo   FIREMAX - v1.0
echo   Otimizador Profissional de PC para Games
echo.
echo ============================================================
echo.

where powershell.exe >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [X] ERRO: PowerShell nao encontrado no sistema!
    echo.
    echo PowerShell e necessario para executar o FIREMAX.
    echo Instale PowerShell 5.1 ou superior.
    echo.
    pause
    exit /b
)

echo.
echo [*] Iniciando FIREMAX...
echo.

cd /d "%SCRIPT_DIR%"
powershell.exe -NoExit -ExecutionPolicy Bypass -Command ".\firemax.ps1"

if %errorlevel% neq 0 (
    echo.
    echo [X] Erro ao executar FIREMAX!
    echo Pressione qualquer tecla para sair...
    pause >nul
    exit /b %errorlevel%
)

exit /b

