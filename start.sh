#!/bin/bash

# Iniciar Spring Boot con configuración explícita
java -Dserver.address=0.0.0.0 -Dserver.port=8080 -jar target/api-productos-1.0-SNAPSHOT.jar > spring.log 2>&1 &
SPRING_PID=$!

# Esperar a que Spring Boot inicie (aumentado a 60 segundos máximo)
echo "Esperando a que Spring Boot inicie..."
COUNTER=0
while [ $COUNTER -lt 30 ]; do
    if grep "Started ApiApplication" spring.log > /dev/null; then
        echo "Spring Boot iniciado correctamente"
        break
    fi
    
    if ! kill -0 $SPRING_PID 2>/dev/null; then
        echo "Spring Boot falló al iniciar. Revisando logs:"
        cat spring.log
        exit 1
    fi
    
    echo "Esperando... ($COUNTER/30)"
    COUNTER=$((COUNTER+1))
    sleep 2
done

if [ $COUNTER -eq 30 ]; then
    echo "Tiempo de espera agotado. Últimas líneas del log:"
    tail -n 50 spring.log
    exit 1
fi

# Iniciar Node.js
exec node server.js 