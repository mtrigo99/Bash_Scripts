#!/bin/bash

ROJO='\033[0;31m'
VERDE='\033[0;32m'
AMARILLO='\e[0;33m'
SIN_COLOR='\033[0m'

archivo_win="wrstdrvs_pruebas.win"
# Extraer los valores de STABLE_DEV_CODE y encontrar el máximo
max_stable_dev_code=$(grep "STABLE_DEV_CODE" "$archivo_win" | cut -d'=' -f2 | sort -n | tail -n 1)
max_stable_dev_code=$((max_stable_dev_code + 1))



#Variables TPVs
nombreTerminal #Nombre TPV
NumPosto=0 #Puesto
codigoComercio #Código de comercio
codigoTerminal #Código de la terminal
keyFirma #key_signature

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
            echo -e "${AMARILLO}¿Nombre de la Máster?${SIN_COLOR}"
            read nombreTerminal
            echo -e "${AMARILLO}¿Código de comercio?${SIN_COLOR}"
            read codigoComercio
            echo -e "${AMARILLO}¿Código de terminal?${SIN_COLOR}"
            read codigoTerminal
            echo -e "${AMARILLO}¿Key_Signature?${SIN_COLOR}"
            read keyFirma
            
echo "
[0B150001] 
DEV_ID=0X0B150001
STABLE_DEV_CODE=$max_stable_dev_code
NAME=Redsys $nombreTerminal 
POSTO=1
COMMERCE_CODE=$codigoComercio
TERMINAL_CODE=$codigoTerminal
KEY_SIGNATURE=$keyFirma
CONF_PINPAD=/dev/pinpad0,19200,N,8,1
VERSION=8.1
PRINT_CLIENT_RECEIPT_ON_INVOICE=1
AUTO_REFUND=1" >> wrstdrvs_pruebas.win

nano wrstdrvs_pruebas.win

read -p "Pulsa una tecla para continuar....." ;;

        3) read -p "Pulsa una tecla para continuar...." ;;
        4) ls -lah /dev/ttyACM*
           read -p "Pulsa una tecla para continuar...." ;;
        5) read -p "Pulsa una tecla para continuar...." ;;
        6) cat /tmp/logDllImplantado.txt
           read -p "Pulsa una tecla para continuar...." ;;
        7) clear; break ;;
        *) echo "Opción no válida";;
    esac
done