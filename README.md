#  Proyecto de Automatización DevOps - AWS

**Autor:** Santiago Valle Aguirre
**Descripción:** Este proyecto diseña e implementa una solución de automatización en AWS. Integra la gestión de instancias EC2 mediante Python (Boto3), el respaldo de información en S3 mediante Bash, y un script orquestador para simular un flujo CI/CD. Todo bajo buenas prácticas evitando el hardcoding.

---

## Estructura del Proyecto
- `ec2/gestionar_ec2.py`: Script en Python para listar, iniciar, detener y terminar instancias.
- `s3/backup_s3.sh`: Script en Bash para comprimir directorios y subirlos a un bucket S3.
- `config/config.env`: Archivo de variables de entorno (separación de configuración y lógica).
- `logs/`: Directorio donde se guardan los reportes de ejecución.
- `deploy.sh`: Script orquestador principal.

---

##  Flujo Git Utilizado
El desarrollo se realizó siguiendo una estrategia de ramas:
1. `main`: Versión estable y final del código.
2. `develop`: Rama de integración donde se unieron las funcionalidades.
3. `feature/*`: Ramas individuales (`feature/ec2-script`, `feature/s3-script`, `feature/deploy-script`) para desarrollar cada script con commits progresivos.

---

## Instrucciones de Uso y Ejemplos

### 1. Configuración previa
Antes de ejecutar nada, asegúrate de llenar el archivo `config/config.env` con tus datos reales:
INSTANCE_ID="tu-id-de-instancia"
BUCKET_NAME="tu-nombre-de-bucket"
DIRECTORY="ruta-a-respaldar"

### 2. Uso de Scripts Individuales
**Gestión de EC2 (Python):**
python3 ec2/gestionar_ec2.py listar
python3 ec2/gestionar_ec2.py iniciar i-1234567890abcdef0
python3 ec2/gestionar_ec2.py detener i-1234567890abcdef0

**Respaldo S3 (Bash):**
bash s3/backup_s3.sh /ruta/al/directorio nombre-de-tu-bucket

### 3. Uso del Orquestador (CI/CD)
Para ejecutar el flujo completo (EC2 + S3 + Logs):
./deploy.sh
