#!/bin/bash

echo " Iniciando simulación de CI/CD (Orquestador)..."

# Manejo de errores: Validar que exista el archivo de configuración
if [ ! -f "config/config.env" ]; then
    echo " Error Crítico: No se encontró config/config.env"
    exit 1
fi

# Cargar las variables (como si las inyectáramos al script)
source config/config.env

# Generación de logs
ARCHIVO_LOG="logs/deploy.log"
echo "=====================================" >> "$ARCHIVO_LOG"
echo "[$(date)] Iniciando nuevo despliegue" >> "$ARCHIVO_LOG"

# Integración con EC2 (Usando la variable de config.env)
echo "Paso 1: Verificando instancia EC2..."
python3 ec2/gestionar_ec2.py iniciar "$INSTANCE_ID" >> "$ARCHIVO_LOG" 2>&1

# Integración con S3 (Usando las variables de config.env)
echo "Paso 2: Ejecutando respaldo en S3..."
bash s3/backup_s3.sh "$DIRECTORY" "$BUCKET_NAME" >> "$ARCHIVO_LOG" 2>&1

echo " Despliegue finalizado. Revisa el archivo $ARCHIVO_LOG para detalles."
