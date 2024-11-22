#!/bin/bash

echo "Iniciando Spring Boot..."
java -Dserver.address=0.0.0.0 -Dserver.port=8080 -jar target/api-productos-1.0-SNAPSHOT.jar &
SPRING_PID=$!

echo "Esperando a que Spring Boot inicie..."
COUNTER=0
MAX_TRIES=60  # 2 minutos de espera máxima

until curl -s http://localhost:8080/actuator/health > /dev/null || [ $COUNTER -eq $MAX_TRIES ]
do
    echo "Esperando que Spring Boot esté listo... ($COUNTER/$MAX_TRIES)"
    COUNTER=$((COUNTER+1))
    sleep 2
done

if [ $COUNTER -eq $MAX_TRIES ]; then
    echo "Spring Boot no pudo iniciar. Revisando logs..."
    kill $SPRING_PID
    exit 1
fi

echo "Spring Boot está listo. Iniciando Node.js..."
exec node server.js 