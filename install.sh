#!/bin/bash

# Cores e estilo
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
CYAN="\033[1;36m"
PURPLE="\033[1;33m"
RESET="\033[0m"
BOLD="\033[1m"

# Funções de mensagem
function success_msg() { echo -e "${GREEN}✅ $1${RESET}"; }
function error_msg() { echo -e "${RED}❌ $1${RESET}"; }
function info_msg() { echo -e "${BLUE}ℹ️ $1${RESET}"; }
function warning_msg() { echo -e "${YELLOW}⚠️ $1${RESET}"; }

# Banner de início
echo -e "${PURPLE}${BOLD}"
echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⢰⡀⢠⣆⢀⣶⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⠀⢀⠀⢠⣦⠀⡟⢆⡞⠳⡾⠈⠟⢹⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo "⠀⠀⢀⠀⢰⣧⣸⠳⣼⠈⢳⠇⠈⠃⠀⠀⠀⠀⠀⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo "⢀⡀⢸⡗⢼⠈⠋⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo "⠈⢏⠛⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡀⠀⠀⠀⠀⠀⠀⠀⠀"
echo "⠀⠈⢆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⠀⠀⠀⠀⠀⠀⠀⠀"
echo "⠀⠀⠈⢧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢈⣱⣆⡀⠀⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⢧⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠴⠒⠒⠒⠶⢞⠁⠀⠀⠉⠳⡀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⢣⠀⠀⠀⠀⠀⠀⠀⣼⠁⠀⠀⠀⠀⠀⠀⣧⠶⠆⠀⠀⡇⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⠀⢣⠀⠀⠀⠀⠀⠀⣧⠀⣾⡆⠀⠀⠀⠀⡼⠶⠒⠒⠓⢳⡄⠀⠀"
echo "⠀⠀⠀⠀⠀⠀⠀⢣⠀⠀⠀⠀⠀⠘⠦⣀⣀⣀⣀⡤⠞⠁⠀⠀⠀⢀⣸⠃⠀⠀"
echo "⠀⠀⠀⠀⠀⠀⠀⢀⡷⠒⢤⡀⠀⠀⠀⠀⠉⠉⠁⠀⠀⠀⠀⠈⠉⢻⡀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⠀⠀⢸⠼⡏⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⡀⠀⠀"
echo "⠀⠀⠀⠀⠀⠀⠀⠀⠓⠿⡴⠂⠀⠀⢀⣀⣀⣀⣀⣀⣀⡀⠀⢀⣀⣠⡼⠃⠀⠀"
echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⠀⠀⣾⣿⣷⣾⣿⣶⣿⡛⠻⠛⠉⠉⠀⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡟⠀⠀⠙⢿⣿⣿⣿⣿⠇⣹⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⡾⠙⠦⣄⣀⣀⣀⣀⣀⣠⡎⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⠀⢠⠴⠚⠃⠀⠀⠀⠀⠉⠉⠉⠁⠀⠉⠉⠉⠓⢦⡀⠀⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⢠⠏⠀⠀⠀⠀⠀⣀⣤⣀⠀⠀⠀⠀⠀⠀⣀⡤⠶⢿⡀⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠸⣇⡤⠞⣷⠦⣤⠞⠋⠉⠉⣳⠀⠀⠙⢦⡀⠀⠀"
echo "⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⣀⣼⡁⣼⠁⢀⡇⠀⠀⠀⡼⠁⠀⠀⠀⠀⣷⠀⠀"
echo "⠀⠀⠀⠀⠀⡸⠃⠀⣠⡴⠛⠁⠀⠉⠙⠒⠋⠀⠀⠀⡼⠁⠀⠀⠀⢀⡴⠃⠀⠀"
echo "⠀⠀⠀⠀⣼⠃⠀⠀⠘⠷⣄⠀⠀⠀⠀⠀⠀⠀⣠⠞⠓⠒⠒⠒⠻⡏⠀⠀⠀⠀"
echo "⠀⠀⠀⢰⡇⠀⠀⠀⠀⠀⠈⠛⠲⠦⠴⠶⠖⠋⠁⠀⠀⠀⠀⠀⠀⢿⠀⠀⠀⠀"
echo "⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⢻⡦⢤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣠⡤⠖⣶⠛⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⢳⡄⠀⠉⠉⠙⠛⠛⠋⠉⠉⠉⠉⠉⠉⠁⠀⠀⠀⡇⠀⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⠀⠀⠀⣀⡽⠀⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⠸⣄⣀⠀⠀⠀⠀⠀⠀⠀⣠⠟⠶⠤⡤⠖⠒⠋⢫⠀⠀⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⢀⡏⠈⠉⠉⣹⠋⠉⠉⠉⠀⠀⠀⠀⢹⡄⠀⠀⠸⡆⠀⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⢸⠁⠀⠀⠠⡇⠀⠀⠀⠀⠀⠀⠀⠀⢀⡇⠀⠀⠀⣷⣄⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⢠⠾⣄⡀⠀⣠⠟⡆⠀⠀⠀⠀⠀⠀⠀⣟⠙⠦⠴⠚⢁⣼⡀⠀⠀⠀"
echo "⠀⠀⠀⢀⠿⣄⣀⣉⣉⣁⣴⣇⠀⠀⠀⠀⠀⠀⠀⣿⡷⢶⠶⠒⠋⠁⠉⢷⡀⠀"
echo "⠀⠀⡴⠋⠀⠀⠀⠀⠀⡏⣠⣿⠀⠀⠀⠀⠀⠀⠀⣿⣧⠼⠀⠀⠀⠀⠀⠀⠹⡄"
echo "⠀⣼⠁⠀⠀⠀⠀⠀⠀⣩⣿⠋⠀⠀⠀⠀⠀⠀⠀⠈⢮⡓⠦⣄⡀⠀⠀⠀⠀⣷"
echo "⠀⣏⠀⠀⠀⢀⣠⢴⡻⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠦⢭⣙⣒⣒⣲⠟"
echo "⠀⠻⢭⣿⡭⠽⠚⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo -e "${RESET}"

echo -e "${CYAN}${BOLD}"
echo " ██╗    ██╗ ██████╗ ██╗     ███████╗"
echo " ██║    ██║██╔═══██╗██║     ██╔════╝"
echo " ██║ █╗ ██║██║   ██║██║     █████╗  "
echo " ██║███╗██║██║   ██║██║     ██╔══╝  "
echo " ╚███╔███╔╝╚██████╔╝███████╗██║     "
echo "  ╚══╝╚══╝  ╚═════╝ ╚══════╝╚═╝     "
echo -e "${RESET}"

echo -e "${BLUE}${BOLD}🐺 WOLF GERADOR PREMIUM - INSTALADOR AUTOMÁTICO${RESET}"
echo -e "${YELLOW}✨ Preparando tudo para você...${RESET}"
echo ""

# Verifica se está no Termux
if [ -d "/data/data/com.termux/files/usr" ]; then
    info_msg "📱 Ambiente Termux detectado!"
    echo ""

    # Atualizando pacotes
    warning_msg "🔄 Atualizando lista de pacotes..."
    pkg update -y && pkg upgrade -y

    # Instalando Python
    info_msg "🐍 Instalando Python..."
    pkg install -y python || {
        error_msg "Falha ao instalar Python!"
        exit 1
    }

    # Instalando colorama (sem atualizar pip no Termux)
    info_msg "🎨 Instalando Colorama..."
    pip install colorama --user || {
        error_msg "Falha ao instalar Colorama!"
        exit 1
    }

else
    # Para outros sistemas Linux
    info_msg "🖥️  Sistema Linux comum detectado!"
    echo ""

    # Verifica se é root
    if [ "$EUID" -ne 0 ]; then
        warning_msg "🔒 Você precisará de privilégios de superusuário"
    fi

    # Atualizando pacotes
    warning_msg "🔄 Atualizando lista de pacotes..."
    sudo apt update -y && sudo apt upgrade -y

    # Instalando Python
    info_msg "🐍 Instalando Python 3 e pip..."
    sudo apt install -y python3 python3-pip || {
        error_msg "Falha ao instalar Python!"
        exit 1
    }

    # Atualizando pip
    warning_msg "🔄 Atualizando pip..."
    pip3 install --upgrade pip || {
        error_msg "Falha ao atualizar pip!"
        exit 1
    }

    # Instalando colorama
    info_msg "🎨 Instalando Colorama..."
    pip3 install colorama || {
        error_msg "Falha ao instalar Colorama!"
        exit 1
    }
fi

# Mensagem final
echo ""
success_msg "🎉 TUDO PRONTO! Todas as dependências foram instaladas com sucesso!"
echo ""
info_msg "🐺 Agora você pode executar o Wolf Gerador Premium com:"
echo -e "${CYAN}${BOLD}   python3 wolf_gerador.py${RESET}"
echo ""
info_msg "📌 Dica: Para uma melhor experiência, execute em um terminal maximizado!"
echo -e "${YELLOW}🌟 Obrigado por usar o Wolf Gerador Premium!${RESET}"
