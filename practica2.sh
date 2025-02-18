#!/bin/bash

# Variable para controlar el ciclo
opcion=0

# Bucle para mostrar el menú y ejecutar las opciones
while [ $opcion -ne 5 ]
do
    echo "\nMenu de Opciones"
    echo "1. Comprobar el estado de la red"
    echo "2. Mostrar el espacio disponible en disco"
    echo "3. Buscar un archivo en un directorio"
    echo "4. Mostrar la fecha y hora actual"
    echo "5. Salir"
    echo -n "Selecciona una opción: "
    read opcion

    case $opcion in
        1)
            echo "Estado de la red:"
            ifconfig || ip a
            ;;
        2)
            echo "Espacio disponible en disco:"
            df -h
            ;;
        3)
            echo -n "Introduce el nombre del archivo a buscar: "
            read archivo
            echo -n "Introduce el directorio donde buscar: "
            read directorio
            if [ -d "$directorio" ]; then
                find "$directorio" -name "$archivo"
            else
                echo "El directorio $directorio no existe."
            fi
            ;;
        4)
            echo "Fecha y hora actual:"
            date
            ;;
        5)
            echo "Saliendo del programa."
            ;;
        *)
            echo "Opción no válida. Por favor, selecciona una opción del menú."
            ;;
    esac

    echo "\nPresiona Enter para continuar..."
    read
    clear

done
