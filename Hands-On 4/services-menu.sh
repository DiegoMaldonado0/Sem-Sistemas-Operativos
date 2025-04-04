#!/bin/bash
# Script: services-menu.sh
# Descripción: Menú interactivo para operaciones con archivos y comandos avanzados

# Función para mostrar el menú
mostrar_menu() {
    clear
    echo "-------------------------------------"
    echo " MENÚ PRINCIPAL - SERVICIOS DE ARCHIVOS"
    echo "-------------------------------------"
    echo "1. Listar contenido de un directorio"
    echo "2. Crear archivo de texto"
    echo "3. Comparar dos archivos de texto"
    echo "4. Ejemplo de uso de AWK"
    echo "5. Ejemplo de uso de GREP"
    echo "6. Salir"
    echo "-------------------------------------"
}

# Función para listar directorio
listar_contenido() {
    read -p "Ingrese la ruta absoluta del directorio: " ruta
    if [ -d "$ruta" ]; then
        echo -e "\nContenido de $ruta:"
        ls -l "$ruta"
    else
        echo "Error: El directorio $ruta no existe."
    fi
    read -p "Presione Enter para continuar..."
}

# Función para crear archivo
crear_archivo() {
    read -p "Ingrese el texto para el archivo: " texto
    read -p "Ingrese el nombre del archivo a crear: " archivo
    echo "$texto" > "$archivo"
    echo "Archivo $archivo creado con éxito."
    read -p "Presione Enter para continuar..."
}

# Función para comparar archivos
comparar_archivos() {
    read -p "Ingrese el primer archivo: " archivo1
    read -p "Ingrese el segundo archivo: " archivo2

    if [ ! -f "$archivo1" ] || [ ! -f "$archivo2" ]; then
        echo "Error: Uno o ambos archivos no existen."
    else
        echo -e "\nDiferencias entre los archivos:"
        diff "$archivo1" "$archivo2"

        if cmp -s "$archivo1" "$archivo2"; then
            echo "Los archivos son idénticos."
        else
            echo "Los archivos son diferentes."
        fi
    fi
    read -p "Presione Enter para continuar..."
}

# Función para demostrar AWK
ejemplo_awk() {
    echo -e "\nEjemplo de AWK:"
    echo "Mostrando la primera columna de /etc/passwd:"
    awk -F: '{print $1}' /etc/passwd | head -n 10
    echo -e "\n(Mostrando solo los primeros 10 resultados)"
    read -p "Presione Enter para continuar..."
}

# Función para demostrar GREP
ejemplo_grep() {
    echo -e "\nEjemplo de GREP:"
    echo "Buscando líneas que contengan 'bash' en /etc/passwd:"
    grep bash /etc/passwd
    read -p "Presione Enter para continuar..."
}

# Bucle principal del menú
while true; do
    mostrar_menu
    read -p "Seleccione una opción [1-6]: " opcion

    case $opcion in
        1) listar_contenido ;;
        2) crear_archivo ;;
        3) comparar_archivos ;;
        4) ejemplo_awk ;;
        5) ejemplo_grep ;;
        6)
            echo "Saliendo del programa..."
            exit 0
            ;;
        *)
            echo "Opción no válida. Intente nuevamente."
            sleep 2
            ;;
    esac
done
