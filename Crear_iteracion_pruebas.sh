#!/bin/bash

#buscador dev_code
archivo_win="wrstdrvs_sin_modificar.win"
# Extraer los valores de STABLE_DEV_CODE y encontrar el máximo
max_stable_dev_code=$(grep "STABLE_DEV_CODE" "$archivo_win" | cut -d'=' -f2 | sort -n | tail -n 1)
max_stable_dev_code=$((max_stable_dev_code + 1))

# Pedir al usuario que ingrese un número
read -p "¿Cuántas TPVs hay que configurar?: " num
read -p "¿En qué puesto debe comenzar la TPV Máster?: " num2

# Texto a repetir
#[0B150001] Para saber la estructura (Este itera)
#DEV_ID=0x0B150001"
#STABLE_DEV_CODE=84 Para saber la estructura. El número lo coge de función
#"NAME=Redsys TPV1"
#"POSTO=" Lo dejo para saber la estructura (Este itera)
#COMMERCE_CODE=numero 
#KEY_SIGNATURE=cf3203c284cb5e7f3382
texto="CONF_PINPAD=/dev/ttyACM0,19200,N,8,1
VERSION=8.1
PRINT_CLIENT_RECEIPT_ON_INVOICE=1
AUTO_REFUND=1"

# Bucle para repetir el texto el número de veces ingresado
for ((i=1; i<=$num; i++))
do
    echo -e "[0B15000$i]"
    echo -e "DEV_ID=0x0B150001"
    echo -e "STABLE_DEV_CODE=$max_stable_dev_code"
    echo -e "NAME=Redsys TPV$i"
    echo -e "POSTO=$i"
    echo -e "COMMERCE_CODE="

    # Imprimir "POSTO=" una vez y luego incrementar su valor
    echo -e "TERMINAL_CODE=$num2"
    ((num2++))

    echo -e "KEY_SIGNATURE="
    echo -e "$texto"
    echo ""
    ((max_stable_dev_code++))
done