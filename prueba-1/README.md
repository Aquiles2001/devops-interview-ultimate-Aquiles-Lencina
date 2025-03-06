# Prueba 1 Diagrama de Red 

Produzca un diagrama de red (puede utilizar lucidchart) de una aplicación web en GCP o AWS y escriba una descripción de texto de 1/2 a 1 página de sus elecciones y arquitectura.
El diseño debe soportar:

    • Cargas variables
    • Contar con HA (alta disponibilidad)
    • Frontend en Js
    • Backend con una base de datos relacional y una no relacional
    • La aplicación backend consume 2 microservicios externos

El diagrama debe hacer un mejor uso de las soluciones distribuidas.

## Diagrama

![Diagrama de Red](Arquitectura%20de%20Aplicación%20Web%20en%20AWS.jpeg)

## Descripción del diagrama

Para la realización de este diagrama se ha optado por utilizar la herramienta de Lucidchart. En este caso, se ha optado por realizar un diagrama de red de una aplicación web en AWS.

### Cargas variables

Para soportar cargas variables se ha optado por utilizar amazon EC2, autoscaling y elastic load balancing. De esta forma, se puede escalar horizontalmente la aplicación web en función de la demanda de los usuarios.

### Contar con HA (alta disponibilidad)

Para contar con alta disponibilidad se ha optado por utilizar un balanceador de carga de AWS, que distribuirá el tráfico entre las instancias EC2. Además, se ha optado por utilizar una base de datos relacional y una no relacional en modo multi-AZ, de forma que si una zona de disponibilidad falla, la otra pueda seguir funcionando.

### Frontend en Js

Para el frontend se ha optado por utilizar S3, que es un servicio de almacenamiento de objetos de Amazon. En este caso, se ha optado por utilizar S3 para almacenar los archivos estáticos de la aplicación web.

### Backend con una base de datos relacional y una no relacional

En el caso del backend este se despliega en EC2, y se ha optado por utilizar RDS para la base de datos relacional y DynamoDB para la base de datos no relacional. Ademas se ha optado por utilizar Elasticache para mantener las sesiones de los usuarios.

### La aplicación backend consume 2 microservicios externos

Para consumir los microservicios externos se ha optado por utilizar API Gateway, que permite exponer las APIs de los microservicios de forma segura y escalable.

### Otras consideraciones

Además de las consideraciones anteriores, se ha optado por utilizar CloudFront para la distribución de contenido estático, Route 53 para la gestión de DNS y Security Groups para comunicacion de las instancias EC2 y el Load Balancer.
