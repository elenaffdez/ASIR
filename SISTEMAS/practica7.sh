#!/bin/bash

# Variables para el control del menú
opc=0

# Menú interactivo
while [ "$opc" -ne 4 ]; do
    clear
    echo "--- MENÚ DE CONFIGURACIÓN DE IPTABLES ---"
    echo "1. Bloquear paquetes entrantes desde una IP específica"
    echo "2. Bloquear paquetes salientes hacia un rango de IPs"
    echo "3. Bloquear acceso a www.facebook.com"
    echo "4. Salir"
    read -p "Seleccione una opción: " opc

    case "$opc" in
        1)
            read -p "Ingrese la dirección IP que desea bloquear (entrante): " ip_entrante
            sudo iptables -A INPUT -s $ip_entrante -j DROP
            echo "Regla agregada: Bloquear paquetes entrantes desde $ip_entrante"
            ;;

        2)
            read -p "Ingrese el rango de IPs que desea bloquear: " rango_ips
            sudo iptables -A OUTPUT -d $rango_ips -j DROP
            echo "Regla agregada: Bloquear paquetes salientes hacia el rango $rango_ips"
            ;;

        3)
            echo "Resolviendo la IP de www.facebook.com..."
            facebook_ip=$(getent ahosts www.facebook.com | grep "^[0-9]" | awk '{ print $1 }' | head -n 1)
            if [ -z "$facebook_ip" ]; then
                echo "Error: No se pudo resolver el dominio www.facebook.com a una dirección IPv4."
            else
                sudo iptables -A OUTPUT -p tcp -d $facebook_ip -j DROP
                sudo iptables -A OUTPUT -p tcp -d $facebook_ip -j DROP
                echo "Regla agregada: Bloquear acceso a www.facebook.com ($facebook_ip)"
            fi
            ;;

        4)
            echo "Saliendo y guardando reglas..."
            if command -v iptables-save &> /dev/null; then
                sudo /sbin/iptables-save 
                echo "Reglas guardadas en /etc/iptables/rules.v4."
            else
                echo "Advertencia: No se pudo guardar las reglas de forma persistente automáticamente."
            fi
            exit 0
            ;;

        *)
            echo "Opción no válida, intente nuevamente."
            ;;
    esac
    echo "Presione Enter para continuar..."
    read
done


