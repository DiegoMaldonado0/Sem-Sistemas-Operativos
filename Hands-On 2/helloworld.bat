@echo off
REM Este comando evita que se muestren los demás comandos en pantalla

echo Hello World
REM Se imprime Hello World en pantalla

dir
REM Se enlista el contenido del directorio actual

REM Verifica si el directorio Test ya existe
if exist Test (
    echo El directorio Test ya existe.
) else (
    mkdir Test
    echo Directorio Test creado.
)

cd Test
REM Se mueve al directorio Test

echo Estas en el directorio: %cd%

dir
REM Se enlista el contenido de Test

pause