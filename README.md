# Steam Offline Toggle

A tiny Windows script that forces Steam into true offline mode by blocking its internet access at the firewall level — useful when Steam's own "Go Offline" option doesn't actually work (it still tries to reconnect, prompts for a network connection, etc.).

Double-click it once and it **switches**: if Steam currently has internet access, it blocks it; if it's already blocked, it removes the block. No need for two separate files.

🇪🇸 *Lee esto en español más abajo.*

## How it works

It adds (or removes) a couple of rules in the Windows Defender Firewall that block `Steam.exe` from making or receiving any network connection. Windows Firewall always makes an explicit "block" rule win over any "allow" rule, so this reliably cuts Steam off from the internet regardless of your other settings.

## Requirements

- Windows 10/11
- Administrator rights (the script checks and tells you if you're missing them)

## Usage

1. **Close Steam completely** — right-click the Steam icon in the system tray (near the clock) and choose "Exit". Just closing the window isn't enough; the background process needs to stop too.
2. **Right-click** `steam-offline-toggle.bat` → **"Run as administrator"**.
3. Follow the on-screen messages (in Spanish). The first run will block Steam.
4. Open Steam — it should now start in offline mode.
5. To go back online later, just run the script again (as administrator) — it detects the block and removes it.

If it can't find your Steam installation automatically, it will tell you which line to edit in the script (`set "STEAMPATH=..."`) to point it at the right folder.

## Disclaimer

This only affects `Steam.exe`'s network access — it doesn't touch any other app, and it's fully reversible by running the script again or by deleting the `BloqueoSteamOffline` rule from Windows Defender Firewall manually (Control Panel → Windows Defender Firewall → Advanced settings → Inbound/Outbound Rules). Use at your own risk; this isn't affiliated with Valve or Steam in any way.

## License

MIT — see [LICENSE](LICENSE).

---

## En español

Un pequeño script para Windows que fuerza a Steam a entrar en modo sin conexión de verdad, bloqueando su acceso a internet a nivel de firewall — útil cuando el propio "Ir sin conexión" de Steam no funciona de verdad (sigue intentando reconectar, pide red, etc.).

Ábrelo una vez y actúa como un interruptor: si Steam tiene acceso a internet, lo bloquea; si ya estaba bloqueado, lo desbloquea. No hacen falta dos archivos distintos.

### Cómo funciona

Añade (o quita) un par de reglas en el Firewall de Windows que bloquean que `Steam.exe` pueda hacer o recibir cualquier conexión de red. El Firewall de Windows siempre hace que una regla de "bloqueo" explícita gane a cualquier regla de "permitir", así que esto corta el internet de Steam de forma fiable pase lo que pase con el resto de tu configuración.

### Requisitos

- Windows 10/11
- Permisos de administrador (el script lo comprueba y te avisa si te faltan)

### Uso

1. **Cierra Steam del todo** — botón derecho en el icono de la bandeja del sistema (junto al reloj) y "Salir". Cerrar solo la ventana no basta, el proceso de fondo tiene que pararse también.
2. **Botón derecho** sobre `steam-offline-toggle.bat` → **"Ejecutar como administrador"**.
3. Sigue los mensajes en pantalla. La primera vez bloqueará Steam.
4. Abre Steam — debería arrancar ya en modo sin conexión.
5. Para volver a tener internet más adelante, ejecuta el script otra vez (como administrador) — detecta el bloqueo y lo quita.

Si no encuentra tu instalación de Steam automáticamente, te dirá qué línea editar en el script (`set "STEAMPATH=..."`) para apuntar a la carpeta correcta.

### Aviso

Esto solo afecta al acceso a internet de `Steam.exe` — no toca ninguna otra aplicación, y es totalmente reversible ejecutando el script otra vez o borrando manualmente la regla `BloqueoSteamOffline` del Firewall de Windows (Panel de control → Firewall de Windows Defender → Configuración avanzada → Reglas de entrada/salida). Úsalo bajo tu propia responsabilidad; esto no tiene ninguna afiliación con Valve ni con Steam.

### Licencia

MIT — mira [LICENSE](LICENSE).
