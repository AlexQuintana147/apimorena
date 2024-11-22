#!/bin/bash

# Iniciar Spring Boot con host específico
java -Dserver.address=0.0.0.0 -jar target/api-productos-1.0-SNAPSHOT.jar &

# Esperar a que Spring Boot inicie completamente
echo "Esperando a que Spring Boot inicie..."
for i in {1..30}; do
    if nc -z 127.0.0.1 8080; then
        echo "Spring Boot está listo!"
        break
    fi
    echo "Intento $i de 30..."
    sleep 2
done

# Iniciar Node.js con variables de entorno
export SPRING_BOOT_HOST=127.0.0.1
export SPRING_BOOT_PORT=8080
node server.js 