@echo off
setlocal

if "%~1"=="" (
    echo Uso: %~nx0 ^<SID^>
    echo Ejemplo: %~nx0 SPI
    exit /b 1
)

set SID=%~1
set BACKUP_DIR=C:\backup-SYB

if not exist %BACKUP_DIR% mkdir %BACKUP_DIR%

rem --- Armar timestamp tipo YYYYMMDD_HHMMSS, independiente del formato regional ---
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set DT=%%I
set TIMESTAMP=%DT:~0,8%_%DT:~8,6%

set DUMPFILE=%BACKUP_DIR%\%SID%_%TIMESTAMP%.dmp
set LOGFILE=%BACKUP_DIR%\%SID%_%TIMESTAMP%_log.txt

cd /d C:\sybase\%SID%\OCS-15_0\bin
set SYBASE=C:\sybase\%SID%
set SYBASE_OCS=OCS-15_0
set PATH=%SYBASE%\%SYBASE_OCS%\dll;%SYBASE%\%SYBASE_OCS%\bin;%PATH%

(
echo dump database %SID% to '%DUMPFILE%'
echo go
) | isql -Usapsa -PSAPInstall.12 -S%SID% -X -o %LOGFILE%

echo Dump finalizado: %DUMPFILE%
echo Log: %LOGFILE%
endlocal
pause
