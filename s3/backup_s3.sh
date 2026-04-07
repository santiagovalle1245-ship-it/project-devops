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
