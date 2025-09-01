#!/bin/bash

# Directorio donde están los archivos combinados
MERGED_DIR="merged_barcodes"

# Directorio de salida para los archivos filtrados
FILTERED_DIR="filtered_barcodes_fastplong"
mkdir -p "$FILTERED_DIR"

# Procesar cada archivo .fastq.gz en el directorio de barcodes combinados
for file in "$MERGED_DIR"/*.fastq.gz; do
    # Obtener el nombre base del archivo (sin ruta ni extensión)
    base_name=$(basename "$file" .fastq.gz)

    # Archivo de salida filtrado
    output_file="$FILTERED_DIR/${base_name}_filt.fastq.gz"

    # Archivo de salida -h html
    output_file_html="$FILTERED_DIR/${base_name}.html"

    #Archivo de salida -j json
    output_file_json="$FILTERED_DIR/${base_name}.json"

    # Ejecutar fastplong / Modificar parámetros según sea necesario
    fastplong -i "$file" -o "$output_file" -q 9 -l 1000 --length_limit 1600  --thread 5 -h "$output_file_html" -j "$output_file_json" --verbose

    echo "Procesado $file -> $output_file"
done
