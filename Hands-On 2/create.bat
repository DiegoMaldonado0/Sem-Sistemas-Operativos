@echo off
REM Script: create.bat
REM Descripción: Crea un archivo de texto, lo copia a un subdirectorio backup, y luego limpia los archivos temporales.

REM 1. Crear archivo mytext.txt con el texto "Hola Mundo"
echo Hola Mundo > mytext.txt
REM El operador ">" redirige el texto al archivo.

REM 2. Mostrar el contenido del archivo en la terminal
echo Contenido de mytext.txt:
type mytext.txt
REM "type" despliega el contenido de un archivo.

REM 3. Crear subdirectorio llamado backup
mkdir backup
echo Se acaba de crear el directorio backup...
REM "mkdir" crea un directorio nuevo.

REM 4. Copiar mytext.txt al subdirectorio backup
copy mytext.txt backup\
REM "copy" copia el archivo a la ruta especificada.

REM 5. Listar contenido del subdirectorio backup
dir backup\
REM "dir" lista archivos y subdirectorios.

REM 6. Eliminar el archivo mytext.txt del subdirectorio backup
del backup\mytext.txt
echo mytext.txt fue eliminado de backup...
REM "del" borra archivos.

REM 7. Eliminar el subdirectorio backup (debe estar vacío)
rmdir backup
echo backup ha sido eliminado...
REM "rmdir" elimina directorios vacíos.

REM Mensaje final
echo Operaciones completadas con exito.
pause
REM "pause" evita que la ventana se cierre automáticamente.