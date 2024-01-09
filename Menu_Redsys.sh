#!/bin/bash

ROJO='\033[0;31m'
VERDE='\033[0;32m'
AMARILLO='\e[0;33m'
SIN_COLOR='\033[0m'

while true
do
    clear
    echo " "
    echo -e "${ROJO}Configuración de Redsys"
    echo -e "-----------------------${SIN_COLOR}"
    echo " "
    echo -e "${AMARILLO}1.${SIN_COLOR} Copiar archivos"
    echo -e "${AMARILLO}2.${SIN_COLOR} Configurar la Máster"
    echo -e "${AMARILLO}3.${SIN_COLOR} Configurar resto de TPVs"
    echo -e "${AMARILLO}4.${SIN_COLOR} Comprobar ttyACM"
    echo -e "${AMARILLO}5.${SIN_COLOR} Comprobar pinpad"
    echo -e "${AMARILLO}6.${SIN_COLOR} Revisar log logDllImplantado.txt"
    echo -e "${AMARILLO}7.${SIN_COLOR} Salir del menú"
    echo " "
    echo "Por favor, selecciona una opción: "
    read opcion

    case $opcion in
        
        1) 
            sudo chmod 777 Ficheros_Redsys/*
            sudo cp -p Ficheros_Redsys/before_winrest /sbin
            sudo cp -p Ficheros_Redsys/caTpvpcImplantado.pem /home/winrest
            sudo cp -p Ficheros_Redsys/libImplantadoLinux.so /home/winrest
            sudo cp -p Ficheros_Redsys/99-pinpad.rules /root/etc/udev/rules.d/ 
            echo -e "${AMARILLO}Los archivos han sido copiados${SIN_COLOR}"
            echo " "
            read -p "Pulsa una tecla para continuar....." ;;
        2) 
            while :
            do
                clear
                echo "Submenú opción 1"
                echo "1. SubOpción 1"cp
                echo "2. SubOpción 2"
                echo "3. Regresar al menú principal"
                read subopcion

                case $subopcion in
                    1) echo "Subopción 1 pulsada";;
                    2) echo "Subopción 2 pulsada";;
                    3) break ;;

                esac
            done ;;

        3) read -p "Pulsa una tecla para continuar...." ;;
        4) ls -lah /dev/ttyACM*
           read -p "Pulsa una tecla para continuar...." ;;
        5) ls -lah /dev/pinp*
           read -p "Pulsa una tecla para continuar...." ;;
        6) cat /tmp/logDllImplantado.txt
           read -p "Pulsa una tecla para continuar...." ;;
        7) clear; break ;;
        *) echo "Opción no válida";;
    esac
done