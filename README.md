# Pickup de ocupación — Mar Azul Suites

Tablero de seguimiento semanal de ocupación. Temporada 2026 y alta 26/27 hasta marzo.

## Cómo funciona

- `index.html` — el tablero, con la pantalla de acceso.
- `datos.json` — los datos publicados, **cifrados**. Es lo único que se toca semana a semana.
- `publicar.bat` — sube el `datos.json` nuevo al repo.
- `robots.txt` — mantiene el sitio fuera de los buscadores.
- `README-SEGURIDAD.md` — leelo antes de crear tu contraseña.

El equipo abre la URL y ve siempre lo último publicado. Cuando **vos** cargás un corte,
queda como borrador en tu navegador (aparece "● borrador sin publicar" arriba a la derecha)
hasta que lo publiques. Nadie más lo ve hasta ese momento.

## Puesta en marcha (una sola vez)

Desde esta carpeta, en la terminal:

```bash
git init
git add .
git commit -m "Tablero de ocupacion"
git branch -M main
git remote add origin https://github.com/USUARIO/ocupacion-marazul.git
git push -u origin main
```

Después, en GitHub: **Settings → Pages → Source: Deploy from a branch → main / (root) → Save**.
En un par de minutos queda en `https://USUARIO.github.io/ocupacion-marazul/`.

## Rutina de cada viernes

1. Abrir la URL y entrar con tu usuario.
2. `+ Nuevo viernes` (arrastra los valores del corte anterior).
3. Cargar los que se movieron.
4. `Publicar cambios` → descarga `datos.json`.
5. Doble clic en `publicar.bat`.

## Ojo con esto

- Cargá siempre desde la **misma computadora y el mismo navegador**. El borrador vive ahí.
  Si publicás antes de cambiar de máquina, no hay problema.
- Si abrís el tablero en otra máquina con un borrador viejo sin publicar, vas a ver ese
  borrador en vez de lo publicado. `Descartar borrador` lo arregla.
- Los datos van cifrados, así que el repo puede ser público sin drama. Lo que
  no se puede es recuperar una contraseña perdida. Ver `README-SEGURIDAD.md`.

## Qué mide cada fila

- **2026 mes a mes**: ocupación del mes completo.
- **Períodos 26/27**: los bloques de temporada. `01/12 al 23/12` es media, después Navidad,
  Año Nuevo y las quincenas de enero, febrero y marzo.
- **12/2026 mes completo** vs **23/12 al 31/12**: son dos números distintos. En 2025 el mes
  cerró 45% pero el bloque alto estuvo en 85%. No mezclarlos al comparar.

Las columnas de referencia a la derecha son los mismos meses de años anteriores.
Los históricos cargados: 2023, 2024, 2025 completos y 2026 hasta julio cerrado.
