#!/bin/bash

# Variable para controlar el ciclo
opcion=0

# Bucle para mostrar el menú y ejecutar las opciones
while [ $opcion -ne 6 ]
do
    echo "\nMenu de Opciones"
    echo "1. Comprobar el estado de la red"
    echo "2. Mostrar el espacio disponible en disco"
    echo "3. Buscar un archivo en un directorio"
    echo "4. Mostrar la fecha y hora actual"
    echo "5. Salir"
    echo "6. Contar solicitudes de conexión por IP"
    echo -n "Selecciona una opción: "
    read opcion

    case $opcion in
        1)
            echo "Estado de la red:"
            ;;  
        2)
            echo "Espacio disponible en disco:"
            df -h
            ;;
        3)
            echo -n "Introduce el nombre del archivo: "
            read archivo
            echo -n "Introduce el directorio: "
            read directorio
            find "$directorio" -name "$archivo"
            ;;
        4)
            echo "Fecha y hora actual:"
            date
            ;;
        5)
            echo "Saliendo..."
            exit 0
            ;;
        6)
            echo -n "Introduce la dirección IP: "
            read ip
            echo "Contando conexiones de la IP $ip..."
            netstat -ntu | awk -v ip="$ip" '$5 ~ ip {count++} END {print "Solicitudes de conexión: ", count+0}'
            ;;
        *)
            echo "Opción no válida, intenta de nuevo."
            ;;
    esac
done

