#!/bin/bash

# Script: helloworld.sh
# Descripción: Imprime "Hello World", crea un directorio Test y lista su contenido.

echo "Hello World"  # Imprime el mensaje en pantalla

echo "Contenido de helloworld.sh:"

ls -l  # Lista el contenido del directorio actual con detalles

mkdir Test  # Crea el directorio Test

echo "Directorio Test creado!"

cd Test  # Cambia al directorio Test

echo "Contenido de Test:"

ls -l  # Lista el contenido de Test (vacío)

# Mensaje final
echo "Script ejecutado correctamente."
