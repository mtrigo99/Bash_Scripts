#!/bin/bash

#buscador dev_code
archivo_win="wrstdrvs_pruebas.win"
# Extraer los valores de STABLE_DEV_CODE y encontrar el máximo
max_stable_dev_code=$(grep "STABLE_DEV_CODE" "$archivo_win" | cut -d'=' -f2 | sort -n | tail -n 1)
max_stable_dev_code=$((max_stable_dev_code + 1))

# Pedir al usuario que ingrese un número
read -p "Ingrese un número: " num

# Texto a repetir
#[0B150001] Para saber la estructura (Este itera)
texto="DEV_ID=0x0B150001"
#STABLE_DEV_CODE=84 Para saber la estructura. El número lo coge de función
texto2="NAME=Redsys TPV1"
#"POSTO=" Lo dejo para saber la estructura (Este itera)
texto3="COMMERCE_CODE=49524846
TERMINAL_CODE=9
KEY_SIGNATURE=cf3203c284cb5e7f3382
CONF_PINPAD=/dev/ttyACM0,19200,N,8,1
VERSION=8.1
PRINT_CLIENT_RECEIPT_ON_INVOICE=1
AUTO_REFUND=1"

# Bucle para repetir el texto el número de veces ingresado
for ((i=1; i<=$num; i++))
do
    echo -e "[0B15000$i]"
    echo -e "$texto"
    echo -e "STABLE_DEV_CODE=$max_stable_dev_code"
    echo -e "POSTO=$i"
    echo -e "$texto2"
    echo -e "$texto3"
    
    echo ""

    ((max_stable_dev_code++))
done
