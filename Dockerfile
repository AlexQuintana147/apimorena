FROM maven:3.8-openjdk-11-slim

# Instalar Node.js
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

WORKDIR /app

# Copiar archivos del proyecto
COPY . .

# Instalar dependencias de Node.js
RUN npm install

# Compilar el proyecto Maven
RUN mvn clean package

# Exponer puertos
EXPOSE 3000
EXPOSE 8080

# Copiar y configurar script de inicio
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Comando para iniciar
CMD ["/app/start.sh"]