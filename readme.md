# Aplicacion con Flask

Este texto proporciona instrucciones sobre cómo instalar y usar Flask, un marco de trabajo para aplicaciones web en Python. Aquí hay un resumen en español, incluidos los comandos relevantes:

Versión de Python recomendada: Se recomienda utilizar la última versión de Python. Flask es compatible con Python 3.8 en adelante.

## Dependencias:

Al instalar Flask, se instalan automáticamente varias dependencias como Werkzeug, Jinja, MarkupSafe, ItsDangerous, Click y Blinker.
Hay dependencias opcionales que Flask utilizará si están instaladas, como python-dotenv, Watchdog y greenlet.

#### Ambientes Virtuales:

Se recomienda usar un ambiente virtual para manejar las dependencias de tu proyecto, tanto en desarrollo como en producción.
Esto soluciona el problema de tener que trabajar con diferentes versiones de bibliotecas o Python al manejar múltiples proyectos.
Python incluye el módulo venv para crear ambientes virtuales.
Creación de un ambiente:

Crea una carpeta para tu proyecto y una carpeta .venv dentro de ella:
En macOS/Linux:
```c#
mkdir myproject
cd myproject
python3 -m venv .venv
```
En Windows (el comando es el mismo, solo cambia cómo activas el ambiente).

### Clonar el repositorio:

Para descargar el repositorio es necesario utilizar la terminal de tu computador. Ubicado en la carpeta deseada, ejecutar el siguiente comando:

``` git clone https://github.com/Sirmauricio10000/sample_RestAPI_flask ```

#### Activación del ambiente:


Antes de trabajar en tu proyecto, activa el ambiente correspondiente:
En macOS/Linux:

```. venv/bin/activate ```

En Windows, el comando para activar el ambiente varía, pero el proceso es similar.

```. venv\Scripts\activate ```

Instalación de Flask:

Con el ambiente activado, usa el siguiente comando para instalar Flask:

``` pip install Flask ```

Una vez instalado Flask, puedes comenzar a trabajar en tu proyecto.


## Configuración de Flask-RESTX y Swagger UI

Después de instalar Flask y configurar tu ambiente virtual, hemos añadido Flask-RESTX a nuestro proyecto para aprovechar la generación automática de documentación de Swagger UI para nuestra API REST. Esto mejora significativamente la experiencia de desarrollo y permite a otros desarrolladores entender y probar tu API de manera más eficiente.

#### Instalación de Flask-RESTX
Para añadir Flask-RESTX a tu proyecto, asegúrate de que tu ambiente virtual esté activo y ejecuta el siguiente comando:

pip install flask-restx

#### Estructura de Archivos Actualizada
A continuación, hemos actualizado la estructura de archivos para acomodar Flask-RESTX y organizar nuestro proyecto de manera adecuada:

```c#
mi_api_flask/
│
├── app/
│   ├── __init__.py
│   └── routes.py
│
└── run.py
```

app/init.py: Este archivo ha sido modificado para inicializar nuestra aplicación Flask junto con Flask-RESTX, configurando así la interfaz de Swagger automáticamente.
app/routes.py: Aquí definimos los endpoints de nuestra API, utilizando las facilidades que Flask-RESTX ofrece para la creación de espacios de nombres (Namespace) y recursos (Resource).
run.py: Archivo que ejecuta la aplicación Flask, ahora aprovechando las capacidades de Flask-RESTX.

### Definición de Endpoints con Flask-RESTX
Los endpoints de tu API se definen en app/routes.py, utilizando el decorador @main.route para especificar las rutas. Flask-RESTX facilita la documentación de estos endpoints, permitiendo agregar descripciones y especificaciones de los métodos HTTP de manera sencilla.

### Ejecutar la Aplicación y Acceder a Swagger UI
Para iniciar tu aplicación Flask con Flask-RESTX, asegúrate de que el ambiente virtual esté activo y ejecuta:

``` python run.py ```

Una vez que la aplicación esté corriendo, puedes acceder a la interfaz de Swagger UI automáticamente generada por Flask-RESTX visitando:

``` http://127.0.0.1:5000 ```

En esta interfaz, encontrarás documentados todos los endpoints disponibles en tu API, con opciones para probarlos directamente desde el navegador.

Listar Dependencias con pip freeze
Es importante documentar las dependencias exactas que tu proyecto utiliza. Para hacerlo, puedes utilizar el comando pip freeze para generar una lista de las bibliotecas instaladas en tu ambiente virtual, junto con sus versiones. Ejecuta el siguiente comando para crear un archivo requirements.txt:


``` pip freeze > requirements.txt ```

Este archivo requirements.txt debería incluir entradas para Flask, Flask-RESTX, y cualquier otra dependencia que hayas instalado.



# Dockerización de la Aplicación Flask

### Creación del Dockerfile
El primer paso para dockerizar tu aplicación Flask es crear un Dockerfile. Este archivo de texto contiene todas las instrucciones necesarias para construir la imagen Docker de tu aplicación.


##### Establece la imagen base
``` FROM python:3.9-alpine ```

##### Define el directorio de trabajo en el contenedor
``` WORKDIR /app ```

##### Copia el archivo de dependencias primero, para aprovechar la caché de Docker
``` COPY requirements.txt . ```

##### Instala las dependencias de la aplicación
``` RUN pip install -r requirements.txt ```

##### Copia el resto del código fuente de la aplicación en el contenedor
``` COPY . . ```

##### Expone el puerto en el que la aplicación se ejecutará dentro del contenedor
```  EXPOSE 5000 ```

##### Define el comando para iniciar la aplicación
``` CMD ["flask", "run", "--host=0.0.0.0"] ```


## Construcción de la Imagen Docker
Una vez que tienes tu Dockerfile, el siguiente paso es construir la imagen Docker de tu aplicación. Este proceso lee el Dockerfile y ejecuta las instrucciones contenidas en él. Puedes construir la imagen con el siguiente comando:

``` docker build -t <nombre de la imagen> . ```

Este comando construye la imagen Docker, con la etiqueta (-t) <nombre de la imagen> .

#### Ejecución del Contenedor
Con la imagen Docker ya construida, el siguiente paso es ejecutar un contenedor basado en esa imagen. Esto se hace con el comando docker run, como se muestra a continuación:

```docker run -d -p 5000:5000 --name <nombre del contenedor> <nombre de la imagen> ```

Este comando inicia un contenedor en modo detenido (-d), mapea el puerto 8000 del host al puerto 8000 del contenedor (-p 8000:8000), y le da al contenedor el nombre cont_backend_notas.

###### Opcional:
En linux, ejecuta el script  ``` start.sh ``` y generará el contenedor corriendo a partir del dockerfile automaticamente.

#### Acceso a la Aplicación
Una vez que el contenedor está corriendo, puedes acceder a tu aplicación Flask navegando a http://localhost:5000 en tu navegador. Esto te llevará a la interfaz de usuario de Swagger donde podrás interactuar con tu API.

