#!/bin/bash

# Variables para control del menú
opc=0

# Mostrar menú
while [ "$opc" -ne 3 ]; do
    clear
    echo "1. Gestión de Usuarios"
    echo "2. Gestión de la Red"
    echo "3. Salir"
    echo -n "Seleccione una opción: "
    read opc

    case "$opc" in
        1)
            echo "Gestión de Usuarios"
            echo "1. Dar de alta usuario manualmente"
            echo "2. Dar de alta usuarios automáticamente"
            echo "3. Borrar un usuario"
            echo -n "Seleccione una opción: "
            read subopc

            case "$subopc" in
                1)
                    echo -n "Ingrese el nombre del usuario a dar de alta: "
                    read username
                    echo -n "Ingrese la contraseña para el usuario: "
                    read -s password
                    echo
                    echo -n "Ingrese un comentario para el usuario: "
                    read comment
                    echo -n "Ingrese el correo del usuario: "
                    read email
                    sudo useradd -p "$(openssl passwd -crypt "$password")" -c "$comment" "$username" && echo "Usuario $username creado correctamente."
                    ;;
                2)
                    echo -n "Ingrese el nombre del fichero CSV con los usuarios: "
                    read file
                    if [ -f "$file" ]; then
                        while IFS=',' read -r username password comment email; do
                            sudo useradd -p "$(openssl passwd -crypt "$password")" -c "$comment" "$username" && echo "Usuario $username creado correctamente."
                        done < "$file"
                    else
                        echo "Fichero no encontrado."
                    fi
                    ;;
                3)
                    echo -n "Ingrese el nombre del usuario a borrar: "
                    read username
                    echo -n "Confirme su contraseña: "
                    read -s password
                    echo
                    if grep -q "$username" usuarios.txt; then
                        sudo userdel "$username" && echo "Usuario $username eliminado."
                    else
                        echo "Usuario no encontrado en el fichero usuarios.txt."
                    fi
                    ;;
                *)
                    echo "Opción no válida."
                    ;;
            esac
            ;;
        2)
            echo "Gestión de la Red"
            echo "1. Dirección IP de equipos en conexión no segura"
            echo "2. Mostrar conexiones seguras"
            echo "3. Almacenar conexiones UDP en fichero"
            echo -n "Seleccione una opción: "
            read subopc

            case "$subopc" in
                1)
                    echo "Direcciones IP en conexiones no seguras:"
                    netstat -nt | grep -v "ESTABLISHED" | awk '{print $5}'
                    ;;
                2)
                    echo "Conexiones seguras en el puerto (protocolo seguro):"
                    netstat -nt | grep ":443" | awk '{print $5}'
                    ;;
                3)
                    echo -n "Ingrese el nombre del fichero para almacenar conexiones UDP: "
                 read file
                    netstat -nu > "$file" && echo "Conexiones UDP almacenadas en $file."
                    ;;
                *)
                    echo "Opción no válida."
                    ;;
            esac
            ;;
        3)
            echo "Saliendo del script..."
            ;;
        *)
            echo "Opción no válida, intente nuevamente."
            ;;
    esac
    echo "Presione Enter para continuar..."
    read
done


