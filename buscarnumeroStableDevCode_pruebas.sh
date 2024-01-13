#!/bin/bash

archivo_texto="wrstdrvs_sin_modificacion.win"  # Reemplaza "tu_archivo.txt" con el nombre real de tu archivo

# Buscar y extraer los valores de STABLE_DEV_CODE
max_stable_dev_code=$(grep "STABLE_DEV_CODE" "$archivo_texto" | cut -d'=' -f2 | sort -n | tail -n 1)

# Imprimir el resultado
if [[ -n $max_stable_dev_code ]]; then
    echo "El número más alto en STABLE_DEV_CODE es: $max_stable_dev_code"
else
    echo "No se encontró la cadena STABLE_DEV_CODE en el archivo."
fi
