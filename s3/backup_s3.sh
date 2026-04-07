#!/bin/bash

# Variables recibidas por parámetros
DIRECTORIO=$1
BUCKET=$2
FECHA=$(date +%Y-%m-%d_%H-%M-%S)

# Validación 1: Revisar que se enviaron los parámetros
if [ -z "$DIRECTORIO" ] || [ -z "$BUCKET" ]; then
    echo " Error: Faltan parámetros."
    echo "Uso correcto: bash backup_s3.sh <directorio_a_respaldar> <nombre_del_bucket>"
    exit 1
fi

# Validación 2: Revisar que el directorio existe
if [ ! -d "$DIRECTORIO" ]; then
    echo "Error: El directorio '$DIRECTORIO' no existe."
    exit 1
fi

# Compresión de archivos
ARCHIVO_RESPALDO="backup_$FECHA.tar.gz"
echo "Comprimiendo el directorio $DIRECTORIO..."
tar -czf "$ARCHIVO_RESPALDO" "$DIRECTORIO"

# Generación de logs y subida a S3
ARCHIVO_LOG="logs/backup.log"

echo "[$(date)] Iniciando subida de $ARCHIVO_RESPALDO al bucket $BUCKET..." >> "$ARCHIVO_LOG"

aws s3 cp "$ARCHIVO_RESPALDO" "s3://$BUCKET/"

if [ $? -eq 0 ]; then
    echo "[$(date)]  Respaldo exitoso en s3://$BUCKET/" >> "$ARCHIVO_LOG"
    echo " Proceso completado con éxito."
    rm "$ARCHIVO_RESPALDO" # Borramos el archivo local para ahorrar espacio
else
    echo "[$(date)] Error al subir a S3" >> "$ARCHIVO_LOG"
    echo " Error crítico. Revisa el log."
fi
