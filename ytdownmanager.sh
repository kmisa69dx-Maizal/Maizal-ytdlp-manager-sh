#!/usr/bin/env bash

#Modo twrminal
if [ -n "$1" ]; then

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "\n${VERDE_FALLOUT}====================================================================${FIN}"
        echo -e "${VERDE_FALLOUT}       MANUAL DE Modo Consola - MAIZAL YT-DLP Decargador       ${FIN}"
        echo -e "${VERDE_FALLOUT}====================================================================${FIN}"
        echo -e " Uso rápido: (el comando que asigno) [formato] [enlace]\n"
        echo -e " Formatos disponibles:"
        echo -e "   ${CYAN}mp3${FIN}   - Descarga audio estándar en formato MP3."
        echo -e "   ${CYAN}vmp3${FIN}  - Convierte video a MP3 (Ojo deben de ser de yt las de music no funciona usar mp3)."
        echo -e "   ${CYAN}mp4${FIN}   - Descarga video en la máxima resolución MP4 disponible (solo de yt)."
        echo -e "\n Ejemplos:"
        echo -e "   maizal_es_mi_dios mp3 https://youtube.com"
        echo -e "   maizal vmp3 https://youtube.com"
        echo -e "${VERDE_FALLOUT}====================================================================${FIN}"
        exit 0
    fi


    Modo_Consola="$1"
    URL_Consola="$2"
    #rutas en consola :D
    if [ -n "$TERMUX_VERSION" ]; then
        dep="$HOME/storage/music/YTdownload"; yt_dp="yt-dlp"
    else
        dep="$HOME/YT-DLP/YTdownload"; yt_dp="$dep/.venv/bin/yt-dlp"
    fi

    echo "Iniciando descarga rápida por consola..."
    case "$Modo_Consola" in
        "mp3")  
        $yt_dp -P "$dep/mp3" -x --audio-format mp3 --audio-quality 0 "$URL_Consola" 
        ;;

        "vmp3") 
        $yt_dp -P "$dep/vmp3" -x --audio-format mp3 --audio-quality 0 --embed-metadata --embed-thumbnail --parse-metadata "title:%(title)s" --replace-in-metadata "title" "(?i)\s*[\(\]][^)]*(official|video|audio|lyrics|hd|4k|videoclip|remastered)[^)]*[\)\]]" "" --replace-in-metadata "artist" "(?i)\s*-\s*Topic" "$URL_Consola" 
        ;;

        "mp4")  
        $yt_dp -P "$dep/mp4" -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4] / bv*+ba/b" --embed-metadata --embed-thumbnail "$URL_Consola" 
        ;;

        *) 
        echo "Formato no válido. Usa: mp3, vmp3 o mp4" 
        ;;
    esac
    exit 0 # Terminamos el script de inmediato para que no abra el menú while
fi

#rutas
if [ -n "$TERMUX_VERSION" ]; then
    termux-setup-storage
    dep0="$HOME/storage/music"
    dep="$dep0/YTdownload"
    yt_dp="yt-dlp"
    ontamos="TERMUX"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
    dep0="$HOME/YT-DLP"
    dep="$dep0/YTdownload"
    yt_dp="$dep/.venv/bin/yt-dlp"
    ontamos="Tu ere pobrwe tu no tiene MACos"
    else
    dep0="$HOME/YT-DLP"
    dep="$dep0/YTdownload"
    yt_dp="$dep/.venv/bin/yt-dlp"
    ontamos="GNU/Linux"
    fi    

#colores :D
ROJO="\e[31m"
VERDE="\e[32m"
AMARILLO="\e[33m"
AZUL="\e[34m"
CYAN="\e[36m"
NEGRITA="\e[1m"
VERDE_FALLOUT="\e[1;32m"  # verde falo
ROJO_ALERTA="\e[1;31m"    # Rojo radiactivo
FIN="\e[0m" #modo chaplin

#Espera Usuario a donde vas?
salidas() {
    clear
 echo -e "\n\n ${ROJO_ALERTA}Descarga interrumpida o se quiso salir${FIN}"
 echo -e " Volviendo al menu en..."
    
    for i in {3..1}; do
        echo -e " Regresando al menú principal en... ${CYAN}$i${FIN}"
        sleep 1
    done
    
    se_quiso_pelar=true
}

#G.E.C.K (Kit de creacion del jardin del eden)
dirs=("$dep/mp3" "$dep/vmp3" "$dep/mp4" "$dep/flac")
void_dirs=false

for d in "${dirs[@]}"; do
    if [ ! -d "$d" ]; then
        void_dirs=true
        break
    fi
done

if [ "$void_dirs" = true ]; then
    echo "Configurando entorno o restaurando carpetas faltantes..."
    mkdir -p "${dirs[@]}"
    sleep 1
elif [ -d "$dep0" ]; then
    echo "Almacenamiento activo activando servicios..."
    sleep 1
fi

#dentro del programa:
while true; do

    if [ "$se_quiso_pelar" = true ]; then
       se_quiso_pelar=false
       continue
    fi
        
    if [ -n "$TERMUX_VERSION" ]; then
     echo ""
    elif [ -d "$dep/.venv" ]; then
        . "$dep/.venv/bin/activate" 2>/dev/null
    fi 
trap - SIGINT   
clear
echo -e "${VERDE_FALLOUT}====================================================================${FIN}"
echo -e "${VERDE_FALLOUT} $ontamos  YT Download Manager (Ejecutandose)    (Hecho por Maizal) ${FIN}"
echo -e "${VERDE_FALLOUT}====================================================================${FIN}"
echo -e "${VERDE_FALLOUT} 1) Instalar (primera vez necesario)                                  ${FIN}"
echo -e "${VERDE_FALLOUT} 2) Descargar audio                                                  ${FIN}"
echo -e "${VERDE_FALLOUT} 3) Descargar video                                                  ${FIN}"
echo -e "${VERDE_FALLOUT} 4) Actualizar yt-dlp                                                ${FIN}"
echo -e "${VERDE_FALLOUT} 5) ${ROJO_ALERTA}Salir del entorno (Cerrar terminal)${VERDE_FALLOUT}${FIN}"
echo -e "${VERDE_FALLOUT}====================================================================${FIN}"
    
read -p $'\e[36m>> seleccione una opcion \e[0m ' opcion

trap 'salidas' SIGINT

case $opcion in
   1)

   gestor_t() {
      	if command -v apt-get &> /dev/null; then
      	        echo "apt"
      	    elif command -v dnf &> /dev/null; then
      	        echo "dnf"
      	    elif command -v pacman &> /dev/null; then
      	        echo "pacman"
      	    elif command -v brew &> /dev/null; then
      	        echo "brew"
      	    elif command -v pkg &> /dev/null; then
      	        echo "pkg"
      	    else
      	        echo -e "${ROJO_ALERTA}desconocido${FIN}"
      	    fi
      }
    gestor=$(gestor_t)

case "$gestor" in 
   "apt")
     echo "Gestor apt detectado iniciando instalacion..."
           sudo apt update -y &&  sudo apt install ffmpeg python3 python3-venv -y
           python3 -m venv "$dep/.venv"
           . "$dep/.venv/bin/activate"
           echo "Actualizando gestor pip e instalando yt-dlp..."
            pip install --upgrade pip
            pip install yt-dlp
            read -p "Instalación completada con éxito. Presione Enter..."
   ;;

   "dnf")
      echo "Gestor dnf detectado, iniciando instalación..."
        sudo dnf check-update -y
        sudo dnf install ffmpeg python3 -y
        
        python3 -m venv "$dep/.venv"
        . "$dep/.venv/bin/activate"
        
        echo "Actualizando gestor pip e instalando yt-dlp..."
        pip install --upgrade pip
        pip install yt-dlp
        read -p "Instalación completada con éxito. Presione Enter..."
   ;;
   
   "pacman")
      echo "Gestor pacman detectado, iniciando instalación..."
            sudo pacman -Sy --noconfirm ffmpeg python
              
            python3 -m venv "$dep/.venv"
            . "$dep/.venv/bin/activate"
              
            echo "Actualizando gestor pip e instalando yt-dlp..."
            pip install --upgrade pip
            pip install yt-dlp
            read -p "Instalación completada con éxito. Presione Enter..."

   ;;

   "brew")
     echo "Gestor brew (macOS) detectado, iniciando instalación..."
           brew update
           brew install ffmpeg python
             
           python3 -m venv "$dep/.venv"
           . "$dep/.venv/bin/activate"
             
           echo "Actualizando gestor pip e instalando yt-dlp..."
           pip install --upgrade pip
           pip install yt-dlp
           read -p "Instalación completada con éxito. Presione Enter..."
   ;;

   "pkg")
     echo "Gestor pkg (Termux/FreeBSD) detectado iniciando instalacion..."
           pkg update -y && pkg install ffmpeg python -y
           echo "Actualizando gestor pip e instalando yt-dlp..."
           pip install --upgrade pip
           pip install yt-dlp
           read -p "Instalación completada con éxito. Presione Enter..."
   ;;

   *)
   echo "Lo sentimos :( No se ha dectectado un gestor compatible con esta util..."
   read -p ">>Precione alguna tecla para salir..."
   exit 1
   ;;
esac

echo -e "\n${VERDE_FALLOUT}Usted Desea poder usar esta erramienta en cualquier momento en su terminal? ${FIN}"
read -p "Si es asi... Introduce el comando corto que quieras usar (ej. maizal mi dios) o presiona Enter para saltar: " gugutata

if [ -n "$gugutata" ]; then
    if [ -n "$TERMUX_VERSION" ]; then
        # Termux
        ln -sf "$HOME/$(basename "$0")" "$PREFIX/bin/$gugutata"
        chmod +x "$PREFIX/bin/$gugutata"
        echo -e "${VERDE}Comando '$gugutata' configurado con éxito en Termux.${FIN}"
    else
        # Escritorios
        CONFIG_SHELL="$HOME/.bashrc"
        [[ "$OSTYPE" == "darwin"* ]] && CONFIG_SHELL="$HOME/.zshrc"
        
        echo "alias $gugutata='$HOME/$(basename "$0")'" >> "$CONFIG_SHELL"
        echo -e "${VERDE}Comando '$gugutata' configurado. Reinicia la terminal para usarlo.${FIN}"
    fi
fi
read -p "Instalación y configuración completadas. Presione Enter..."

   ;;

   2)
    read -p ">> Pegue su url: " url1
    echo "" #
    echo "Elija su extension o tipo de formato a descargar..."
    echo "Si su enlace es un videa elija vmp3 video to mp3"
    read -p "1>>mp3  2>>vmp3  3>>flac " audio
    if [ "$audio" = "1" ]; then
    
    $yt_dp -P "$dep/mp3" -x --audio-format mp3 --audio-quality 0 --embed-metadata --embed-thumbnail -o "%(title)s - %(artist,uploader)s%(genre& [{}]|)s.%(ext)s" "$url1"
       
    elif [ "$audio" = "2" ]; then
     
     $yt_dp -P "$dep/vmp3" -x --audio-format mp3 --audio-quality 0 --embed-metadata --embed-thumbnail --parse-metadata "title:%(title)s" --replace-in-metadata "title" "(?i)\s*[\(\[][^)]*(official|video|audio|lyrics|hd|4k|videoclip|remastered)[^)]*[\)\]]" "" --replace-in-metadata "artist" "(?i)\s*-\s*Topic" "$url1"
         
    elif [ "$audio" = "3" ]; then
    
     $yt_dp -P "$dep/flac" -x --audio-format flac --audio-quality 0 "$url1"
    
    else
    echo "opcion incorrecta..."
    
    fi

   ;;

   3)
    read -p ">> Pegue su url: " url2
    echo "" #
    $yt_dp -P "$dep/mp4" -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4] / bv*+ba/b" --embed-metadata --embed-thumbnail "$url2"
   ;;

    4)
   if [ -n "$TERMUX_VERSION" ]; then
      echo "Conectando con servidores PyPI para actualizar yt-dlp en Termux..."
      pip install --upgrade yt-dlp
   elif [ -d "$dep/.venv" ]; then
      echo "Conectando con servidores PyPI para actualizar yt-dlp en el entorno virtual..."
      "$dep/.venv/bin/pip" install --upgrade pip
      "$dep/.venv/bin/pip" install --upgrade yt-dlp
   else
      echo "No existe un entorno virtual creado todavía."
   fi
      read -p "Actualización finalizada. Presione Enter para continuar..."
   ;;


   5)
    echo -e "${AMARILLO}Saliendo Gracias por usar esta herramienta...${FIN}"
    sleep 1
    command -v deactivate &> /dev/null && deactivate
    break
   ;;

   *)
    echo -e "${ROJO_ALERTA}Error opcion no valida...${FIN}"
    read -p ">> Precione enter para continuar..."
   ;;

   esac

done
