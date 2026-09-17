$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

$dl = Join-Path $env:USERPROFILE "Downloads"

# Agarra el datos*.json MAS RECIENTE, contemple "datos (1).json" y demas
$f = Get-ChildItem (Join-Path $dl "datos*.json") -ErrorAction SilentlyContinue |
     Sort-Object LastWriteTime -Descending | Select-Object -First 1

if (-not $f) {
  Write-Host ""
  Write-Host "No encontre ningun datos.json en Descargas." -ForegroundColor Yellow
  Write-Host "Abri el tablero, apreta 'Publicar cambios' y volve a correr esto."
  Write-Host ""
  Read-Host "Enter para cerrar"; exit
}

$edad = [math]::Round((New-TimeSpan -Start $f.LastWriteTime -End (Get-Date)).TotalMinutes)
Write-Host ""
Write-Host ("Archivo encontrado: " + $f.Name)
Write-Host ("Descargado hace:    " + $edad + " minutos")
Write-Host ""

# No subir nunca algo sin cifrar
$txt = Get-Content $f.FullName -Raw
if ($txt -notmatch '"enc"') {
  Write-Host "FRENO: ese archivo NO esta cifrado. No lo subo." -ForegroundColor Red
  Write-Host "Entra al tablero con tu usuario y publica de nuevo desde ahi."
  Read-Host "Enter para cerrar"; exit
}

if ($edad -gt 60) {
  Write-Host "Ojo: el archivo tiene mas de una hora." -ForegroundColor Yellow
  $r = Read-Host "Seguro que es el que acabas de publicar? (s/n)"
  if ($r -ne "s") { Write-Host "Cancelado."; Read-Host "Enter para cerrar"; exit }
}

Copy-Item $f.FullName (Join-Path $PSScriptRoot "datos.json") -Force

# Limpia los sobrantes para que la proxima no se confunda
Get-ChildItem (Join-Path $dl "datos*.json") -ErrorAction SilentlyContinue | Remove-Item -Force

git add datos.json
if (-not (git status --porcelain datos.json)) {
  Write-Host ""
  Write-Host "El contenido es identico al que ya esta publicado." -ForegroundColor Yellow
  Write-Host "O sea: no habia cambios nuevos, o publicaste un archivo viejo."
  Read-Host "Enter para cerrar"; exit
}

git commit -m ("Ocupacion actualizada " + (Get-Date -Format "dd/MM/yyyy HH:mm"))
git push

if ($LASTEXITCODE -ne 0) {
  Write-Host ""
  Write-Host "EL PUSH FALLO. Mira el mensaje de arriba." -ForegroundColor Red
  Read-Host "Enter para cerrar"; exit
}

Write-Host ""
Write-Host "Publicado. En un minuto lo ve todo el equipo." -ForegroundColor Green
Write-Host ""
Read-Host "Enter para cerrar"
