CONTAINER_NAME="cont_flaskapp"
IMAGE_NAME="img_flaskapp"
IMAGE_TAG="latest"
PORT_MAP="5000:5000"

# Detener el contenedor si está corriendo
if [ $(docker ps -q -f name=^/${CONTAINER_NAME}$) ]; then
    echo "El contenedor ${CONTAINER_NAME} está corriendo. Deteniéndolo..."
    docker stop ${CONTAINER_NAME}
    echo "Contenedor detenido."
else
    echo "El contenedor ${CONTAINER_NAME} no está corriendo."
fi

# Eliminar el contenedor si existe
if [ $(docker ps -aq -f name=^/${CONTAINER_NAME}$) ]; then
    echo "El contenedor ${CONTAINER_NAME} existe. Eliminándolo..."
    docker rm ${CONTAINER_NAME}
    echo "Contenedor eliminado."
fi

# Eliminar la imagen si existe
if [ $(docker images -q ${IMAGE_NAME}:${IMAGE_TAG}) ]; then
    echo "La imagen ${IMAGE_NAME}:${IMAGE_TAG} existe. Eliminándola..."
    docker rmi ${IMAGE_NAME}:${IMAGE_TAG}
    echo "Imagen eliminada."
fi

# Construir Imagen
echo "Construyendo la imagen Docker ${IMAGE_NAME}:${IMAGE_TAG}..."
docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
echo "Imagen construida."

# Ejecutar contenedor
echo "Ejecutando el contenedor..."
docker run -d -p ${PORT_MAP} --restart unless-stopped --name ${CONTAINER_NAME} -e MONGO_URI="mongodb+srv://user:password@yourmongodb.net/?retryWrites=true&w=majority&appName=notasPrueba" ${IMAGE_NAME}:${IMAGE_TAG}
echo "Contenedor ${CONTAINER_NAME} ejecutándose en background."

echo "Validando el estado del contenedor ${CONTAINER_NAME}, ESPERE..."
sleep 5

# Verificar si el contenedor está corriendo
if [ $(docker ps -q -f name=^/${CONTAINER_NAME}$) ]; then
    echo "El contenedor ${CONTAINER_NAME} está corriendo normalmente. FIN SCRIPT."
else
    echo "El contenedor ${CONTAINER_NAME} NO está corriendo. Verificar el problema."
fi
