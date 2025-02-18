#!/bin/bash

crear_usuario() {
  read -p "Introduce el nombre de usuario: " usuario
  read -s -p "Introduce la contraseña: " contrasena
  echo
  sudo useradd -m "$usuario" -s /bin/bash
  echo "$usuario:$contrasena" | sudo chpasswd
  echo "Usuario $usuario creado con éxito."
}

modificar_contrasena() {
  read -p "Introduce el nombre del usuario: " usuario
  if id "$usuario" &>/dev/null; then
    read -s -p "Introduce la nueva contraseña: " contrasena
    echo
    echo "$usuario:$contrasena" | sudo chpasswd
    echo "Contraseña de $usuario modificada con éxito."
  else
    echo "El usuario $usuario no existe."
  fi
}

borrar_usuario() {
  read -p "Introduce el nombre del usuario a borrar: " usuario
  if id "$usuario" &>/dev/null; then
    sudo userdel -r "$usuario"
    echo "Usuario $usuario borrado con éxito."
  else
    echo "El usuario $usuario no existe."
  fi
}

mostrar_informacion_usuario() {
  read -p "Introduce el nombre del usuario: " usuario
  if id "$usuario" &>/dev/null; then
    finger "$usuario"
  else
    echo "El usuario $usuario no existe."
  fi
}

anadir_usuario_grupo() {
  read -p "Introduce el nombre del usuario: " usuario
  read -p "Introduce el nombre del grupo: " grupo
  if id "$usuario" &>/dev/null; then
    if getent group "$grupo" &>/dev/null; then
      sudo usermod -aG "$grupo" "$usuario"
      echo "Usuario $usuario añadido al grupo $grupo con éxito."
    else
      echo "El grupo $grupo no existe."
    fi
  else
    echo "El usuario $usuario no existe."
  fi
}

while true; do
  echo "\n=== Gestión de Usuarios ==="
  echo "1. Crear usuario"
  echo "2. Modificar contraseña de usuario"
  echo "3. Borrar usuario"
  echo "4. Mostrar información de usuario"
  echo "5. Añadir usuario a grupo"
  echo "6. Salir"
  read -p "Selecciona una opción: " opc

  case $opc in
    1) crear_usuario ;;
    2) modificar_contrasena ;;
    3) borrar_usuario ;;
    4) mostrar_informacion_usuario ;;
    5) anadir_usuario_grupo ;;
    6) echo "Saliendo...";
	 break ;;
    *) echo "Opción no válida." ;;
  esac
done
