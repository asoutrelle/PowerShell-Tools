Function Send-WakeOnline {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)] [string]$MAC,
        [Parameter(Mandatory=$true)] [string]$IP,
        [Parameter(Mandatory=$true)] [int]$Port
    )

    Write-Verbose "===== DEBUG WOL START ====="

    Write-Verbose "MAC recibida: ${MAC}"
    ${MacBytes} = ${MAC} -split "[:-]" | ForEach-Object { 
        Write-Verbose "Convirtiendo parte MAC: $_ -> 0x$_"
        [byte]("0x$_") 
    }

    Write-Verbose "MAC convertida en bytes: $(${MacBytes} -join ', ')"

    [byte[]]${Packet} = (,0xFF * 6) + (${MacBytes} * 16)
    Write-Verbose "Magic Packet length: $(${Packet}.Length)"
    Write-Verbose "Primeros 20 bytes del Magic Packet: $([System.BitConverter]::ToString(${Packet}[0..19]))"

    try {
        Write-Verbose "Creando objeto UdpClient"
        ${Udp} = New-Object System.Net.Sockets.UdpClient

        Write-Verbose "Intentando conectar a ${IP}:${Port}"
        ${Udp}.Connect(${IP}, ${Port})
        Write-Host "Conexion UDP exitosa a ${IP}:${Port}"

        Write-Verbose "Enviando paquete magico..."
        ${Sent} = ${Udp}.Send(${Packet}, ${Packet}.Length)

        if(${Sent} -eq ${Packet}.Length) {
            Write-Host "Paquete magico enviado correctamente (${Sent} bytes)"
        } else {
            Write-Host "Paquete enviado parcialmente (${Sent}/${Packet}.Length bytes)"
        }

        ${Udp}.Close()
    }
    catch {
        Write-Host "ERROR: no se pudo enviar el paquete"
        Write-Host "Mensaje: $($_.Exception.Message)"
        Write-Host "StackTrace: $($_.Exception.StackTrace)"
    }

    Write-Verbose "===== DEBUG WOL END ====="
}

