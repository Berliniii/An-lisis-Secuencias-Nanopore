#!/bin/bash

# Directorio donde están los archivos filtrados
FILTERED_DIR="filtered_barcodes_fastplong"

# Directorio donde se guardarán los resultados de Emu
OUTPUT_DIR="abundance_emu"
mkdir -p "$OUTPUT_DIR"

# Ruta a la base de datos de EMU / Aqui se especifica la dirección de la base de datos a utilizar (podria ser SILVA por ejemplo)
EMU_DB="/home/teresa/emu_db"

# Iterar sobre cada archivo *_merge_filt.fastq.gz en el directorio filtrado
for file in "$FILTERED_DIR"/*_merge_filt.fastq.gz; do
    # Obtener el nombre base del archivo (sin ruta ni extensión) hasta el barcodeXX
    base_name=$(basename "$file" "_merge_filt.fastq.gz")

    # Subdirectorio para los resultados de este archivo
    sample_output_dir="$OUTPUT_DIR/$base_name"
    mkdir -p "$sample_output_dir"

    # Ejecutar Emu con --output-basename para personalizar el nombre de salida
    emu abundance "$file" --type map-ont --db "$EMU_DB" --keep-counts --output-dir "$sample_output_dir" --output-basename "$base_name" --threads 5

    echo "Asignación taxonómica completada para $file. Resultados en $sample_output_dir"
done
