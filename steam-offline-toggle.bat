@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
title Bloqueo/Desbloqueo de Steam (modo offline forzado)

:: ============================================================
:: Este script BLOQUEA o DESBLOQUEA el acceso a internet de
:: Steam.exe usando el Firewall de Windows, para forzar que el
:: cliente entre en modo sin conexion de verdad.
:: Cada vez que lo abres, hace lo contrario de lo que estaba
:: haciendo (interruptor: si estaba bloqueado, desbloquea; si
:: no lo estaba, bloquea).
::
:: IMPORTANTE: tienes que ejecutarlo como ADMINISTRADOR.
:: Boton derecho sobre el archivo -> "Ejecutar como administrador".
:: Si lo abres con doble clic normal, Windows no le deja tocar
:: el Firewall y no hara nada (o dara error de "acceso denegado").
:: ============================================================

echo.
echo Comprobando permisos de administrador...
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo ===================================================
    echo   FALTAN PERMISOS DE ADMINISTRADOR
    echo ===================================================
    echo.
    echo   Este script necesita ejecutarse como administrador
    echo   para poder tocar el Firewall de Windows.
    echo.
    echo   Cierra esta ventana y vuelve a abrir el archivo asi:
    echo     1. Boton derecho sobre BloqueoSteamOffline.bat
    echo     2. "Ejecutar como administrador"
    echo     3. Acepta el aviso de Windows si te lo pide
    echo.
    pause
    exit /b
)
echo   OK, tengo permisos de administrador.
echo.

set "RULENAME=BloqueoSteamOffline"

:: --- Intentar encontrar Steam.exe automaticamente en el registro ---
set "STEAMPATH="
for /f "tokens=2,*" %%A in ('reg query "HKLM\SOFTWARE\WOW6432Node\Valve\Steam" /v InstallPath 2^>nul') do set "STEAMPATH=%%B"
if "%STEAMPATH%"=="" (
    for /f "tokens=2,*" %%A in ('reg query "HKCU\Software\Valve\Steam" /v SteamPath 2^>nul') do set "STEAMPATH=%%B"
)
if "%STEAMPATH%"=="" set "STEAMPATH=C:\Program Files (x86)\Steam"

set "STEAMEXE=%STEAMPATH%\Steam.exe"

echo Ruta de Steam detectada: %STEAMEXE%
echo.

if not exist "%STEAMEXE%" (
    echo No he encontrado Steam.exe en esa ruta.
    echo.
    echo Haz clic derecho en este archivo -^> Editar / Modificar,
    echo busca mas arriba la linea que empieza por:
    echo   set "STEAMPATH=C:\Program Files (x86)\Steam"
    echo y cambiala por la carpeta real donde tienes Steam
    echo instalado ^(la que contiene Steam.exe^).
    echo.
    pause
    exit /b
)

:: --- Comprobar si la regla ya existe (esta bloqueado o no) ---
netsh advfirewall firewall show rule name="%RULENAME%" >nul 2>&1
if %errorLevel% equ 0 (
    echo Steam esta BLOQUEADO ahora mismo. Quitando el bloqueo...
    netsh advfirewall firewall delete rule name="%RULENAME%"
    echo.
    echo ===================================================
    echo   Steam ya tiene acceso a internet de nuevo.
    echo ===================================================
) else (
    echo Steam tiene acceso a internet ahora mismo. Bloqueando...
    echo.
    echo Antes de continuar: CIERRA STEAM DEL TODO
    echo ^(boton derecho en el icono de la bandeja, junto al
    echo reloj, y "Salir"^). Si sigue abierto, este bloqueo no
    echo cortara las conexiones que ya tenia hechas.
    echo.
    pause
    netsh advfirewall firewall add rule name="%RULENAME%" dir=out program="%STEAMEXE%" action=block enable=yes
    netsh advfirewall firewall add rule name="%RULENAME%" dir=in  program="%STEAMEXE%" action=block enable=yes
    echo.
    echo ===================================================
    echo   Steam esta ahora BLOQUEADO de internet.
    echo   Abrelo otra vez: deberia entrar directo en Offline.
    echo ===================================================
)

echo.
pause
