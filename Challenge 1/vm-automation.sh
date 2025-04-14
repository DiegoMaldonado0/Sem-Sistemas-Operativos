#!/bin/bash
# Script: vm-automation.sh
# Descripción: Automatiza la creación y configuración de una MV en VirtualBox
# Uso: ./vm-automation.sh <nombre_mv> <tipo_os> <num_cpus> <memoria_GB> <vram_MB> <disco_GB> <nombre_sata> <nombre_ide>

# Verificar que se hayan proporcionado todos los argumentos
if [ "$#" -ne 8 ]; then
    echo "Error: Número incorrecto de argumentos."
    echo "Uso: $0 <nombre_mv> <tipo_os> <num_cpus> <memoria_GB> <vram_MB> <disco_GB> <nombre_sata> <nombre_ide>"
    exit 1
fi

# Asignar argumentos a variables
nombre_mv="$1"
tipo_os="$2"
num_cpus="$3"
memoria_GB="$4"
vram_MB="$5"
disco_GB="$6"
nombre_sata="$7"
nombre_ide="$8"

# 1. Crear la máquina virtual
echo "Creando máquina virtual '$nombre_mv' con sistema operativo '$tipo_os'..."
VBoxManage createvm --name "$nombre_mv" --ostype "$tipo_os" --register

# 2. Configurar recursos hardware
echo "Configurando recursos hardware:"
echo " - CPUs: $num_cpus"
echo " - Memoria RAM: ${memoria_GB}GB"
echo " - VRAM: ${vram_MB}MB"

VBoxManage modifyvm "$nombre_mv" \
    --cpus "$num_cpus" \
    --memory $((memoria_GB * 1024)) \
    --vram "$vram_MB" \
    --acpi on \
    --boot1 dvd \
    --nic1 nat

# 3. Crear disco duro virtual
disco_vmdk="${nombre_mv}.vmdk"
echo "Creando disco duro virtual '$disco_vmdk' de ${disco_GB}GB..."
VBoxManage createmedium disk --filename "$disco_vmdk" --size $((disco_GB * 1024)) --format VMDK

# 4. Crear y asociar controlador SATA
echo "Creando y asociando controlador SATA '$nombre_sata'..."
VBoxManage storagectl "$nombre_mv" \
    --name "$nombre_sata" \
    --add sata \
    --controller IntelAhci \
    --portcount 1

VBoxManage storageattach "$nombre_mv" \
    --storagectl "$nombre_sata" \
    --port 0 \
    --device 0 \
    --type hdd \
    --medium "$disco_vmdk"

# 5. Crear y asociar controlador IDE (para CD/DVD)
echo "Creando y asociando controlador IDE '$nombre_ide'..."
VBoxManage storagectl "$nombre_mv" \
    --name "$nombre_ide" \
    --add ide \
    --controller PIIX4

# 6. Mostrar resumen de configuración
echo -e "\n----------------------------------------"
echo " RESUMEN DE CONFIGURACIÓN DE LA MÁQUINA VIRTUAL"
echo "----------------------------------------"
echo "Nombre MV: $nombre_mv"
echo "Sistema Operativo: $tipo_os"
echo "CPUs: $num_cpus"
echo "Memoria RAM: ${memoria_GB}GB"
echo "VRAM: ${vram_MB}MB"
echo "Disco Duro: ${disco_GB}GB (${disco_vmdk})"
echo "Controlador SATA: $nombre_sata"
echo "Controlador IDE: $nombre_ide"
echo "----------------------------------------"

# Verificar creación
echo -e "\nVerificando creación de la máquina virtual..."
VBoxManage showvminfo "$nombre_mv" | grep -E "Name|OSType|Memory|CPUs|VRAM|Storage"

echo -e "\n¡Máquina virtual '$nombre_mv' configurada exitosamente!"
