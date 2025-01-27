#!/bin/bash

# Fitxer amb les imatges
IMAGES_FILE="calico-versio.txt"

# Carpeta on es guardaran les imatges en format .tar
OUTPUT_DIR="containerd_images_backup"

# Crear la carpeta si no existeix
mkdir -p "$OUTPUT_DIR"

# Llegir cada línia del fitxer i processar les imatges
while read -r line; do
    # Extreure el nom de la imatge (tot després de "image:") i fer un trim per eliminar espais
    IMAGE=$(echo "$line" | awk -F'image: ' '{print $2}' | xargs)

    # Comprovar si la línia conté una imatge vàlida
    if [[ ! -z "$IMAGE" ]]; then
        echo "Processant imatge: $IMAGE"

        # Descarregar la imatge amb ctr
        ctr --namespace k8s.io images pull "$IMAGE"

        # Guardar la imatge en un fitxer .tar
        IMAGE_FILENAME=$(echo "$IMAGE" | sed 's|/|_|g' | sed 's|:|_|g')
        ctr --namespace k8s.io images export "$OUTPUT_DIR/${IMAGE_FILENAME}.tar" "$IMAGE"

        echo "Imatge $IMAGE guardada a $OUTPUT_DIR/${IMAGE_FILENAME}.tar"
    fi
done < "$IMAGES_FILE"

echo "Totes les imatges han estat processades i desades a $OUTPUT_DIR."

