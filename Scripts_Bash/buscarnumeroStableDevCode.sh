#!/bin/bash

archivo_win="wrstdrvs.win"

# Extraer los valores de STABLE_DEV_CODE y encontrar el máximo
max_stable_dev_code=$(grep "STABLE_DEV_CODE" "$archivo_win" | cut -d'=' -f2 | sort -n | tail -n 1)
max_stable_dev_code=$((max_stable_dev_code + 1))

echo "El número más alto en STABLE_DEV_CODE es: $max_stable_dev_code"
