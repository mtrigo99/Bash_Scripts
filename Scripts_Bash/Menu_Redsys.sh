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
    echo -e "${AMARILLO}1.${SIN_COLOR} Configurar la Máster"
    echo -e "${AMARILLO}2.${SIN_COLOR} Configurar resto de TPVs"
    echo -e "${AMARILLO}3.${SIN_COLOR} Comprobar ttyACM"
    echo -e "${AMARILLO}4.${SIN_COLOR} Comprobar fallos log logDllImplantado.txt"
    echo -e "${AMARILLO}5.${SIN_COLOR} Salir del menú"
    echo " "
    echo "Por favor, selecciona una opción: "
    read opcion

    case $opcion in
        1) 
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

        2) echo "Has seleccionado la opción 2";;
        3) ls /dev/ttyACM*
           read -p "Pulsa una tecla para continuar...." ;;
        4) cat /tmp/logDllImplantado.txt
           read -p "Pulsa una tecla para continuar...." ;;
        5) break ;;
        *) echo "Opción no válida";;
    esac
done