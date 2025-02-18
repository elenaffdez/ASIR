#!/bin/bash
opcion=0

while [ $opcion -ne 5 ]
do
  clear
  echo "Menu Principal"
  echo "1. Mostrar conexiones de red y guardar en salida-netstat.txt"
  echo "2. Filtrar conexiones ESTABLECIDAS y guardar en salida-netstat-establecido.txt"
  echo "3. Contar conexiones ESTABLECIDO y TIME_WAIT"
  echo "4. Mostrar IPs de conexiones web no seguras"
  echo "5. Salir"
  echo -n "Elige una opción: "
  read opcion

  case $opcion in
    1)
      echo "Guardando conexiones de red en salida-netstat.txt..."
      while ! netstat -an > salida-netstat.txt
      do
        echo "Error al guardar las conexiones. Reintentando..."
      done
      echo "Conexiones guardadas en salida-netstat.txt. Pulsa una tecla para continuar."
      read ;;

    2)
      while [ ! -f salida-netstat.txt ]
      do
        echo "El archivo salida-netstat.txt no existe. Por favor, ejecuta la opción 1 primero."
        read -p "Pulsa una tecla para reintentar." opcion
      done
      echo "Filtrando conexiones ESTABLECIDAS..."
      grep ESTABLISHED salida-netstat.txt > salida-netstat-establecido.txt
      echo "Conexiones ESTABLECIDAS guardadas en salida-netstat-establecido.txt. Pulsa una tecla para continuar."
      read ;;

    3)
      while [ ! -f salida-netstat.txt ]
      do
        echo "El archivo salida-netstat.txt no existe. Por favor, ejecuta la opción 1 primero."
        read -p "Pulsa una tecla para reintentar." opcion
      done
      echo "Contando conexiones ESTABLECIDO y TIME_WAIT..."
      establecidas=$(grep -c ESTABLISHED salida-netstat.txt)
      time_wait=$(grep -c TIME_WAIT salida-netstat.txt)
      echo "Conexiones ESTABLECIDO: $establecidas"
      echo "Conexiones TIME_WAIT: $time_wait"
      echo "Pulsa una tecla para continuar."
      read ;;

    4)
      while [ ! -f salida-netstat.txt ]
      do
        echo "El archivo salida-netstat.txt no existe. Por favor, ejecuta la opción 1 primero."
        read -p "Pulsa una tecla para reintentar." opcion
      done
      echo "Mostrando IPs de conexiones web no seguras..."
      grep "tcp.*:80" salida-netstat.txt | awk '{print $5}' | cut -d":" -f1
      echo "Pulsa una tecla para continuar."
      read ;;

    5)
      echo "Saliendo..."
      ;;

    *)
      echo "Opción no válida. Pulsa una tecla para continuar."
      read ;;
  esac
done
