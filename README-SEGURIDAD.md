# Cómo funciona la seguridad de este tablero

## Lo primero, sin vueltas

GitHub Pages entrega archivos estáticos. **No hay servidor que valide nada.**
Cualquier pantalla de login hecha en JavaScript se saltea escribiendo la URL del
archivo de datos directamente. Por eso acá el candado no está en la puerta:
está en los datos.

**El `datos.json` publicado está cifrado.** El que lo baje se lleva ruido.

## Qué protege y qué no

| | |
|---|---|
| Alguien encuentra la URL | Ve una pantalla de acceso. Sin usuario y contraseña, nada. |
| Alguien baja `datos.json` a mano | Se lleva texto cifrado, ilegible. |
| Un bot rastrea el sitio | `robots.txt` y `noindex` lo mantienen fuera de Google. Si igual lo baja, ver punto anterior. |
| Alguien con el archivo prueba contraseñas offline | **Acá está el límite real.** Nadie lo frena. Lo único que lo detiene es que tu frase sea larga. |
| Sacás a alguien del equipo | No entra más al tablero. Pero si guardó una copia vieja del `datos.json` y se acuerda su contraseña, puede abrir esa copia vieja. |

## El detalle técnico

- Una clave maestra aleatoria de 256 bits cifra los datos con **AES-GCM**.
- Esa clave maestra se guarda una vez por persona, envuelta con la contraseña
  de cada una, derivada con **PBKDF2-SHA256, 600.000 iteraciones**.
- Nadie ve la contraseña de nadie. Ni siquiera vos, que creaste el tablero.
- El borrador local que queda en tu navegador también va cifrado.

## Las reglas que no se negocian

1. **Frases largas, no contraseñas.** Doce caracteres es el mínimo que acepta,
   pero apuntá a una frase de cuatro o cinco palabras. Es la única defensa
   contra alguien que se baje el archivo y pruebe combinaciones sin apuro.
2. **Anotala en un gestor de contraseñas antes de crearla.** Si se pierde, los
   datos no se recuperan. No hay "olvidé mi contraseña". No hay forma.
3. **Exportá el CSV de vez en cuando.** Es tu red por si algo sale mal.
4. Nunca subas al repo un `datos.json` sin cifrar.

## Si querés seguridad de verdad

Lo de arriba es lo máximo que da un sitio estático. Si en algún momento querés
control de acceso real —bloquear a alguien al instante, ver quién entró, frenar
bots antes de que toquen el archivo— la salida es **Cloudflare Pages + Access**,
gratis hasta 50 personas, con login por código al mail.

Lo bueno: Cloudflare Pages se conecta al mismo repo de GitHub. No cambia nada de
tu rutina, ni el `publicar.bat`. Solo cambia dónde se sirve el sitio.
