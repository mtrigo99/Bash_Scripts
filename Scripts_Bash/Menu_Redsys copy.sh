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
    echo -e "${AMARILLO}2.${SIN_COLOR} Configurar resto de TPV"
    echo -e "${AMARILLO}3.${SIN_COLOR} Comprobar ttyACM"
    echo -e "${AMARILLO}4.${SIN_COLOR} Comprobar fallos log logDllImplantado.txt"
    echo " "
    echo "Por favor, selecciona una opción: "
    read opcion

    case $opcion in
        #1) echo "Has seleccionado la opción 1";;
        1) ./prueba_conexion.sh;;
        2) echo "Has seleccionado la opción 2";;
        3) echo "Has seleccionado la opción 3";;
        4) clear;;
        *) echo "Opción no válida";;
    esac
done