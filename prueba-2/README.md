# Prueba 2 - Despliegue de una aplicación Django y React.js

Elaborar el deployment dockerizado de una aplicación en django (backend) con frontend en React.js contenida en el repositorio. Es necesario desplegar todos los servicios en un solo docker-compose.
Se deben entregar los Dockerfiles pertinentes para elaborar el despliegue y justificar la forma en la que elabora el deployment (supervisor, scripts, docker-compose, kubernetes, etc)
Subir todo lo elaborado a un repositorio (github, gitlab, bitbucket, etc). En el repositorio se debe incluir el código de la aplicación y un archivo README.md con instrucciones detalladas para compilar y desplegar la aplicación, tanto en una PC local como en la nube (AWS o GCP)

## Descripción de archivos utiizados

### Despleigue local

Para el despliegue local se utilizan los siguientes archivos:

- `Dockerfile`: Archivo que contiene las instrucciones para construir la imagen de Docker del backend.
- `Dockerfile_frontend`: Archivo que contiene las instrucciones para construir la imagen de Docker del frontend.
- `docker-compose.yml`: Archivo que contiene las instrucciones para desplegar los servicios de backend y frontend en un contenedor de Docker.

#### Modo de uso local

Para poder desplegar la aplicación en un entorno local, debe ejecutar el comando dentyro de la carpeta `prueba-2`:

```bash
docker-compose up
```

### Despliegue en la nube

Para el despliegue en la nube (AWS) se utilizo la herramienta terraform, para ello se utilizan los siguientes archivos:

- `ID.tf`: Archivo que se encarga de crear las credenciales necesarias para el acceso a la maquina virtual EC2.
- `providers.tf`: Archivo que define los privides necesarios para desplegar la maquina virtual.
- `main.tf`: Este archivo contiene la creacion de la maquina virtual EC2 donde se desplegara la aplicacion. y se encarga de descargar el software necesario y el repositorio de github, para luego ejecutar el docker-compose.

#### Modo de uso en la nube

Para poder desplegar la aplicación en un entorno en la nube, debe ejecutar los siguientes comandos dentro de la carpeta `prueba-2/deploy`:

```bash
terraform init
terraform plan -out plan.out
terraform apply plan.out
```

```bash
NOTA tener configurado previamente AWS-cli en tu local.
```
