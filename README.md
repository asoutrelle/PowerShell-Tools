# PowerShell-Tools

Una colección de herramientas útiles desarrolladas en PowerShell. Cada script tiene su propia funcionalidad y puede ser usado de manera independiente.

---

## Configuración del entorno

Para usar estos scripts, debes iniciar un **PROFILE** de PowerShell y agregar tus funciones. Abre el PROFILE con:

```

notepad $PROFILE

```

Agrega los scripts que quieras cargar automáticamente y luego actualiza el PROFILE ejecutando:

```

. $PROFILE

```

Ahora tus funciones estarán disponibles cada vez que abras PowerShell.

---

## Send-WakeOnline
> [!WARNING]
> Hacer port forwarding y abrir puertos en tu red puede ser inseguro.
> Asegúrate de entender los riesgos antes de usarlo.


### Descripción
Envía un **paquete mágico Wake-on-LAN (WOL)** a un dispositivo remoto para encenderlo a través de su dirección MAC, IP y puerto UDP.

### Uso
```

Send-WakeOnline -MAC "C8:60:00:67:C2:88" -IP "134.72.143.79" -Port 3456

```

### Parámetros
- **$MAC** : Dirección MAC del dispositivo.
- **$IP** : IP pública o local del dispositivo.
- **$Port** : Puerto UDP para enviar el paquete (usualmente 7 o 9 para WOL).

### Ejemplo práctico
```

Send-WakeOnline -MAC "C8:60:00:67:C2:88" -IP "134.72.143.79" -Port 9

```

### Recomendaciones
- Asegúrate de que tu red y firewall permitan el tráfico UDP hacia el puerto especificado.
- Verifica que la opción **Wake-on-LAN** esté habilitada en la BIOS/UEFI y en la tarjeta de red del dispositivo destino.
