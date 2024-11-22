#!/bin/bash
# Descargar e instalar Java
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 17.0.2-open
export JAVA_HOME="$HOME/.sdkman/candidates/java/current"
export PATH="$JAVA_HOME/bin:$PATH"

# Instalar Maven
sdk install maven

# Compilar el proyecto
mvn clean package 