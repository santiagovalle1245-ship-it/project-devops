import boto3
import sys

# Definimos el cliente de EC2 (nuestro traductor para hablar con AWS)
ec2 = boto3.client('ec2', region_name='us-east-1')

def gestionar_instancia():
    # sys.argv captura lo que escribes en la terminal
    # sys.argv[1] es la ACCION (listar, iniciar, etc)
    accion = sys.argv[1]

    if accion == "listar":
        print(" Listando instancias...")
        response = ec2.describe_instances()
        for reservation in response['Reservations']:
            for instance in reservation['Instances']:
                print(f"ID: {instance['InstanceId']} - Estado: {instance['State']['Name']}")

    elif accion == "iniciar":
        instance_id = sys.argv[2]
        print(f" Iniciando instancia {instance_id}...")
        ec2.start_instances(InstanceIds=[instance_id])

    elif accion == "detener":
        instance_id = sys.argv[2]
        print(f" Deteniendo instancia {instance_id}...")
        ec2.stop_instances(InstanceIds=[instance_id])

    else:
        print(" Acción no válida. Usa: listar, iniciar o detener.")

if __name__ == "__main__":
    gestionar_instancia()
