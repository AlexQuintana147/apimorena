#!/bin/bash

# Iniciar Spring Boot con configuración explícita
java -Dserver.address=0.0.0.0 -Dserver.port=8080 -jar target/api-productos-1.0-SNAPSHOT.jar > spring.log 2>&1 &
SPRING_PID=$!

# Esperar a que Spring Boot inicie
echo "Esperando a que Spring Boot inicie..."
COUNTER=0
MAX_TRIES=45  # Aumentado a 90 segundos

while [ $COUNTER -lt $MAX_TRIES ]; do
    if grep "Started ApiApplication" spring.log > /dev/null; then
        echo "Spring Boot iniciado correctamente"
        # Verificar que el puerto esté realmente abierto
        if nc -z localhost 8080; then
            echo "Puerto 8080 está abierto y listo"
            break
        fi
    fi
    
    if ! kill -0 $SPRING_PID 2>/dev/null; then
        echo "Spring Boot falló al iniciar. Revisando logs:"
        cat spring.log
        exit 1
    fi
    
    echo "Esperando... ($COUNTER/$MAX_TRIES)"
    COUNTER=$((COUNTER+1))
    sleep 2
done

if [ $COUNTER -eq $MAX_TRIES ]; then
    echo "Tiempo de espera agotado. Últimas líneas del log:"
    tail -n 50 spring.log
    exit 1
fi

# Iniciar Node.js
exec node server.js 