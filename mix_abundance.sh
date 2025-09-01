#!/bin/bash

# Directorio donde están las subcarpetas
SOURCE_DIR="abundance_emu"

# Directorio destino donde se combinarán todos los archivos
DEST_DIR="total_abundance_emu"
mkdir -p "$DEST_DIR"

# Iterar sobre cada subcarpeta en el directorio fuente
for dir in "$SOURCE_DIR"/*/; do
    # Comprobar que sea un directorio
    if [ -d "$dir" ]; then
        # Buscar el archivo en la subcarpeta (ajustar el patrón de ser necesario)
        file=$(find "$dir" -maxdepth 1 -type f -name "*.tsv" | head -n 1)

        # Verificar si se encontró un archivo
        if [ -n "$file" ]; then
            # Copiar el archivo al directorio destino
            cp "$file" "$DEST_DIR/"
            echo "Archivo $file copiado a $DEST_DIR."
        else
            echo "No se encontró un archivo en $dir."
        fi
    fi
done

echo "Todos los archivos han sido copiados a $DEST_DIR."
