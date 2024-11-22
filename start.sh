#!/bin/bash
# Iniciar Spring Boot
java -jar target/api-productos-1.0-SNAPSHOT.jar &

# Esperar a que Spring Boot inicie completamente
echo "Esperando a que Spring Boot inicie..."
while ! nc -z 127.0.0.1 8080; do
  sleep 1
done
echo "Spring Boot está listo!"

# Iniciar Node.js
node server.js 