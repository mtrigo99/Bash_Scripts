#!/bin/bash
 
carpeta="/sbin"
archivo="before_winrest.ini"
ruta_completa="$carpeta/$archivo"
linea_a_descomentar=3

# Verificar si el archivo existe
if [ ! -e "$ruta_completa" ]; then
  echo "El archivo $ruta_completa no existe."
  exit 1
fi

# Crear una copia de seguridad del archivo original
cp "$ruta_completa" "$ruta_completa.bak"

# Comentar todas las líneas que no estén comentadas
sed -i "s/^[^#]/#&/" "$ruta_completa"

# Descomenta la línea especificada
sed -i "${linea_a_descomentar}s/^#//" "$ruta_completa"

echo "Se han comentado todas las líneas y descomentado la $linea_a_comentar en $ruta_completa."
