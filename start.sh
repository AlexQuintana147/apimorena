#!/bin/bash
# Iniciar Spring Boot
java -jar target/api-productos-1.0-SNAPSHOT.jar &

# Esperar a que Spring Boot inicie
sleep 10

# Iniciar Node.js
node server.js 