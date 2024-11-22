#!/bin/bash

# Iniciar Spring Boot con configuración explícita
java -Dserver.address=0.0.0.0 -Dserver.port=8080 -jar target/api-productos-1.0-SNAPSHOT.jar > spring.log 2>&1 &
SPRING_PID=$!

# Esperar a que Spring Boot inicie
echo "Esperando a que Spring Boot inicie..."
while ! grep "Started ApiApplication" spring.log > /dev/null; do
    if ! kill -0 $SPRING_PID 2>/dev/null; then
        echo "Spring Boot falló al iniciar. Revisando logs:"
        cat spring.log
        exit 1
    fi
    echo "Esperando..."
    sleep 2
done

echo "Spring Boot iniciado correctamente"

# Iniciar Node.js
exec node server.js 