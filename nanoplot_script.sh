#!/bin/bash

# Directorio donde están los archivos combinados
MERGED_DIR="merged_barcodes"

# Directorio de salida para los reportes de NanoPlot
QC_DIR="nano_qc"
mkdir -p "$QC_DIR"

# Procesar cada archivo .fastq.gz en el directorio de barcodes combinados
for file in "$MERGED_DIR"/*.fastq.gz; do
    # Obtener el nombre base del archivo (sin ruta ni extensión)
    base_name=$(basename "$file" .fastq.gz)

    # Crear un subdirectorio para este archivo en el directorio de salida
    output_subdir="$QC_DIR/$base_name"
    mkdir -p "$output_subdir"

    # Ejecutar NanoPlot
    NanoPlot --fastq "$file" --outdir "$output_subdir" --threads 5 --loglength

    echo "QC completado para $file. Resultados en $output_subdir"
done
