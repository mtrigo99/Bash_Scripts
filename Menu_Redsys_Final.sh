#!/bin/bash

#Version 1.0

ROJO='\033[0;31m'
VERDE='\033[0;32m'
AMARILLO='\e[0;33m'
SIN_COLOR='\033[0m'

archivo_win="/home/winrest/files/data/wrstdrvs.win"
# Extraer los valores de STABLE_DEV_CODE y encontrar el máximo
max_stable_dev_code=$(grep "STABLE_DEV_CODE" "$archivo_win" | cut -d'=' -f2 | sort -n | tail -n 1)
#max_stable_dev_code=$((max_stable_dev_code + 1))



#Variables TPVs
#devcode #Este valor es una copia de max_stable_dev_code hasta que podamos convertirlo a numérico
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
    echo -e "${AMARILLO}2.${SIN_COLOR} Configurar TPVs"
    echo -e "${AMARILLO}3.${SIN_COLOR} Otras configuraciones"
    echo -e "${AMARILLO}4.${SIN_COLOR} Comprobar ttyACM"
    echo -e "${AMARILLO}5.${SIN_COLOR} Comprobar pinpad"
    echo -e "${AMARILLO}6.${SIN_COLOR} Revisar log logDllImplantado.txt"
    echo -e "${AMARILLO}7.${SIN_COLOR} Salir del menú"
    echo " "
    echo "Por favor, selecciona una opción: "
    read opcion

    case $opcion in
        
        1) 
           while :
            do
                clear
                echo -e "${VERDE}Copiar archivos"
                echo ""
                echo -e "${AMARILLO}1.${SIN_COLOR} Copiar archivos en la Máster"
                echo -e "${AMARILLO}2.${SIN_COLOR} Copiar 99-pinpad.rules resto TPVs (Por ssh)"
                echo ""
                #echo "2. SubOpción 2"
                echo -e "${AMARILLO}3.${SIN_COLOR} Regresar al menú principal"
                read subopcion

                case $subopcion in
                    1)  directorio="Backup"
                        chmod 777 Ficheros_Redsys/*

                        if [ -d "$directorio" ]; then
                            cp -p /home/winrest/files/data/wrstdrvs.win Backup/
                        else
                        # Crear el directorio si no existe
                        mkdir "$directorio"
                        cp -p /home/winrest/files/data/wrstdrvs.win Backup/
                        fi

                        cp -p /home/winrest/files/data/wrstdrvs.win Backup/
                        cp -p /home/winrest/files/data/wrstdrvs.win /home/winrest/files/data/wrstdrvs.win.old
                        cp -p Ficheros_Redsys/before_winrest /sbin
                        cp -p Ficheros_Redsys/caTpvpcImplantado.pem /home/winrest
                        cp -p Ficheros_Redsys/libImplantadoLinux.so /home/winrest
                        cp -p Ficheros_Redsys/99-pinpad.rules ~/etc/udev/rules.d/ 
                        echo -e "${AMARILLO}Los archivos han sido copiados${SIN_COLOR}"
                        read -p "Pulsa una tecla para continuar....." ;;
                    2) 
                        echo "Introduce la IP de la TPV: "
                        read iptpv
                        echo "La ip introducida es: $iptpv"
                        scp Ficheros_Redsys/99-pipad.rules root@$iptpv:/root/etc/udev/rules.d/ || echo "Hay errores"
                        ;;
                    3) break ;;

                esac
            done ;; 
        2)                       

# Pedir al usuario que ingrese un número
            #echo $max_stable_dev_code
            echo -e "Introduce el siguiente número ${AMARILLO}$max_stable_dev_code${SIN_COLOR}: "
            read devcode
            read -p "¿Cuántas TPVs hay que configurar?: " num
            read -p "¿En qué puesto debe comenzar la TPV Máster?: " num2
            read -p "¿Código de comercio?: " codigoComercio
            read -p "¿Key_Signature?: " keyFirma
            
# Texto a repetir
#[0B150001] Para saber la estructura (Este itera)
#DEV_ID=0x0B150001"
#STABLE_DEV_CODE=84 Para saber la estructura. El número lo coge de función
#"NAME=Redsys TPV1"
#"POSTO=" Lo dejo para saber la estructura (Este itera)
#COMMERCE_CODE=numero 
#KEY_SIGNATURE=cf3203c284cb5e7f3382
texto="CONF_PINPAD=/dev/pinpad0,19200,N,8,1
VERSION=8.1
PRINT_CLIENT_RECEIPT_ON_INVOICE=1
AUTO_REFUND=1"

# Bucle para repetir el texto el número de veces ingresado
for ((i=1; i<=$num; i++))
do
    echo -e "[0B15000$i]" >> $archivo_win
    echo -e "DEV_ID=0x0B150001" >> $archivo_win 
    echo -e "STABLE_DEV_CODE=$((devcode+1))" >> $archivo_win
    ((devcode++))
    echo -e "NAME=Redsys TPV$i" >> $archivo_win
    echo -e "POSTO=$i" >> $archivo_win
    echo -e "COMMERCE_CODE=$codigoComercio" >> $archivo_win

    # Imprimir "POSTO=" una vez y luego incrementar su valor
    echo -e "TERMINAL_CODE=$num2" >> $archivo_win
    ((num2++))

    echo -e "KEY_SIGNATURE=$keyFirma" >> $archivo_win
    echo -e "$texto" >> $archivo_win
    echo "" >> $archivo_win
    #((max_stable_dev_code++))
done

nano $archivo_win
echo ""
read -p "Pulsa ENTER para continuar....." ;;

        3) #read -p "Pulsa una tecla para continuar...." ;;
           while :
            do
                clear
                echo -e "${VERDE}Submenú Otras configuraciones${SIN_COLOR}"
                echo ""
                echo -e "${AMARILLO}1.${SIN_COLOR} Actualizar TPV"
                echo ""
                #echo "2. SubOpción 2"
                echo -e "${AMARILLO}2.${SIN_COLOR} Regresar al menú principal"
                read subopcion

                case $subopcion in
                    1) echo "Subopción 1 pulsada";;
                    2) echo "Subopción 2 pulsada";;
                    3) break ;;

                esac
            done ;;

        4) ls -lah /dev/ttyACM*
           read -p "Pulsa una tecla para continuar...." ;;
        5) ls -lah /dev/pinpa*
           read -p "Pulsa una tecla para continuar...." ;;
        6) cat /tmp/logDllImplantado.txt
           read -p "Pulsa una tecla para continuar...." ;;
        7) clear; break ;;
        *) echo "Opción no válida";;
    esac
done