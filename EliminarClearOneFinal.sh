#!/bin/bash

# Archivo de entrada
input_file="wrstdrvs_pruebas.win"

# Archivo temporal
temp_file=$(mktemp)

# Patrón de inicio y fin de bloque
start_pattern="\["
end_pattern="\]"

# Patrones para las cadenas a eliminar
remove_patterns=("127.0.0.1" "0x0B170001")

# Función para comprobar si una línea contiene alguno de los patrones
contains_pattern() {
    local line="$1"
    for pattern in "${remove_patterns[@]}"; do
        if [[ $line == *"$pattern"* ]]; then
            return 0
        fi
    done
    return 1
}

# Bandera para controlar si estamos dentro de un bloque
inside_block=false

# Iterar sobre el archivo línea por línea
while IFS= read -r line; do
    # Comprobar si la línea contiene alguno de los patrones a eliminar
    if contains_pattern "$line"; then
        inside_block=true
    fi

    # Si estamos dentro de un bloque y la línea contiene el patrón de fin de bloque, ignoramos este bloque
    if [ "$inside_block" = true ] && [[ $line =~ $end_pattern ]]; then
        inside_block=false
    fi

    # Si no estamos dentro de un bloque, escribimos la línea en el archivo temporal
    if [ "$inside_block" = false ]; then
        echo "$line" >> "$temp_file"
    fi
done < "$input_file"

# Sobrescribir el archivo original con el contenido del archivo temporal
mv "$temp_file" "$input_file"

echo "Bloques con las líneas especificadas eliminados correctamente."

