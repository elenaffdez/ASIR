#!/bin/bash

# Variable para controlar el ciclo
opcion=0

# Bucle para mostrar el menú y ejecutar las opciones
while [ $opcion -ne 5 ]
do
    echo "\nMenu de Opciones"
    echo "1. Almacenar el historial en un fichero"
    echo "2. Mostrar el contenido del fichero del historial"
    echo "3. Ejecutar el script crear_usuario.sh"
    echo "4. Mostrar el contenido de tu carpeta personal"
    echo "5. Salir"
    echo -n "Selecciona una opción: "
    read opcion

    case $opcion in
        1)
            echo -n "Introduce el nombre del fichero para guardar el historial: "
            read nombre_fichero
            history > "$nombre_fichero"
            echo "Historial almacenado en el fichero $nombre_fichero."
            ;;
        2)
            echo -n "Introduce el nombre del fichero para mostrar su contenido: "
            read nombre_fichero
            if [ -f "$nombre_fichero" ]; then
                cat "$nombre_fichero"
            else
                echo "El fichero $nombre_fichero no existe."
            fi
            ;;
        3)
            if [ -f "crear_usuario.sh" ]; then
                chmod +x crear_usuario.sh
                ./crear_usuario.sh
            else
                echo "El script crear_usuario.sh no se encuentra en el directorio actual."
            fi
            ;;
        4)
            echo "Contenido de tu carpeta personal:"
            ls ~
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

