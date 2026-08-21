@echo off
chcp 65001 >nul
cd /d "%~dp0"

set "DL=%USERPROFILE%\Downloads\datos.json"

if not exist "%DL%" (
  echo.
  echo No encontre datos.json en la carpeta Descargas.
  echo Abri el tablero, apreta "Publicar cambios" y volve a correr esto.
  echo.
  pause
  exit /b 1
)

move /y "%DL%" "%~dp0datos.json" >nul
if errorlevel 1 (
  echo No pude mover el archivo. Cerra el datos.json si lo tenes abierto.
  pause
  exit /b 1
)

git add datos.json
git commit -m "Ocupacion actualizada %date%"
git push

echo.
echo Publicado. En un minuto lo ve todo el equipo.
echo.
pause
