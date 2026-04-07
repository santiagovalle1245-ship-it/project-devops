#!/bin/bash

echo " Iniciando simulación de CI/CD (Orquestador)..."

# Manejo de errores: Validar que exista el archivo de configuración
if [ ! -f "config/config.env" ]; then
    echo " Error Crítico: No se encontró config/config.env"
    exit 1
fi

# Cargar las variables (como si las inyectáramos al script)
source config/config.env
