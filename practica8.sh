#!/bin/bash

# Archivo de salida para información solicitada
touch salida_host.txt

mostrar_puertos() {
    echo "Estado de los puertos y protocolos:"
    netstat -tulpn 2>/dev/null
}

mostrar_hosts_activos() {
    echo "---Hosts activos en la red---"
    read -p "Ingresa el rango de red: " red
    sudo nmap -sn $red | grep "Nmap scan report for"
}

identificar_sistemas_operativos() {
    echo "---Identificación de sistemas operativos en la red---"
    read -p "Ingresa el rango de red: " red
    sudo nmap -O $red | grep "Running:"
}

guardar_informacion() {
    echo "Guardando información en salida.txt..."
    echo "Estado de los puertos y protocolos:" > salida.txt
    netstat -tulpn 2>/dev/null >> salida.txt
    echo "---Identificación de sistemas operativos en la red---" >> salida.txt
    read -p "Ingresa el rango de red: " red
    sudo nmap -O $red | grep "Running:" >> salida.txt
    echo "Información guardada en salida.txt."
}

buscar_informacion_host() {
    read -p "Ingresa la IP del host que deseas buscar: " ip_host
    echo "Buscando información del host $ip_host en salida.txt..."
    while read -r linea; do
        echo "$linea" | grep "$ip_host" && echo "$linea"
    done < salida.txt || echo "No se encontró información para el host $ip_host"
}

opcion=0
while [ "$opcion" -ne 6 ]; do
    echo "1) Mostrar el estado de los puertos con su protocolo"
    echo "2) Mostrar los hosts activos de tu red"
    echo "3) Identificar sistemas operativos de los hosts en la red"
    echo "4) Guardar información de los puntos 1 y 3 en salida.txt"
    echo "5) Buscar información de un host en salida.txt"
    echo "6) Salir"
    read -p "Selecciona una opción: " opcion

    case $opcion in
        1)
            mostrar_puertos
            ;;
        2)
            mostrar_hosts_activos
            ;;
        3)
            identificar_sistemas_operativos
            ;;
        4)
            guardar_informacion
            ;;
        5)
            buscar_informacion_host
            ;;
        6)
            echo "Saliendo del programa..."
            ;;
        *)
            echo "Opción inválida, intenta de nuevo."
            ;;
    esac
    echo
done
