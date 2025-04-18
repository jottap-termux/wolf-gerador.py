#!/data/data/com.termux/files/usr/bin/python3
# -*- coding: utf-8 -*-

# ==================== IMPORTS ====================
import re
import json
import time
import sys
import os
import random
import shutil
from datetime import datetime
from colorama import Fore, Style, init
import logging
import threading
import hashlib
import select
import termios
import tty

# ==================== CONFIGURAÇÃO INICIAL ====================
if 'com.termux' in os.environ.get('PREFIX', ''):
    os.system('termux-setup-storage')
    os.environ['TERM'] = 'xterm-256color'

init(autoreset=True)
LARGURA_MAXIMA = 80

# ==================== CONFIGURAÇÃO DE CORES ====================
COR_TITULO = Fore.CYAN
COR_MENU = Fore.LIGHTGREEN_EX
COR_DESTAQUE = Fore.LIGHTWHITE_EX
COR_ERRO = Fore.LIGHTRED_EX
COR_SUCESSO = Fore.LIGHTGREEN_EX
COR_DADOS = Fore.WHITE
COR_BANNER = Fore.LIGHTBLUE_EX
COR_NOME = Fore.LIGHTCYAN_EX
COR_OPCOES = Fore.LIGHTGREEN_EX
COR_NUMEROS = Fore.LIGHTCYAN_EX

# ==================== CLASSE RELÓGIO ====================
class ClockThread(threading.Thread):
    def __init__(self):
        super().__init__()
        self._stop_event = threading.Event()
        self.current_time = datetime.now().strftime('%d/%m/%Y %H:%M:%S')

    def run(self):
        while not self._stop_event.is_set():
            self.current_time = datetime.now().strftime('%d/%m/%Y %H:%M:%S')
            time.sleep(1)

    def stop(self):
        self._stop_event.set()

# ==================== FUNÇÕES DE INTERFACE ====================
def limpar_termux():
    os.system('clear')

def linha_horizontal(esq='╔', dir='╗', preenchimento='═'):
    return f"{COR_TITULO}{esq}{preenchimento * (LARGURA_MAXIMA - 2)}{dir}{Style.RESET_ALL}"

def linha_texto(texto, alinhamento='left'):
    texto_sem_cores = re.sub(r'\x1b\[[0-9;]*m', '', texto)
    espaço = LARGURA_MAXIMA - 2 - len(texto_sem_cores)

    if espaço < 0:
        texto = texto[:LARGURA_MAXIMA - 5] + '...'
        espaço = 0

    if alinhamento == 'center':
        left_space = espaço // 2
        right_space = espaço - left_space
        return f"{COR_TITULO}║{' ' * left_space}{texto}{' ' * right_space}║{Style.RESET_ALL}"
    else:
        return f"{COR_TITULO}║{texto}{' ' * espaço}║{Style.RESET_ALL}"

def mostrar_banner_termux(clock):
    COR_WOLF = Fore.LIGHTGREEN_EX
    COR_GERADOR = Fore.LIGHTCYAN_EX
    COR_AZUL_BEBE = Fore.LIGHTGREEN_EX
    COR_DETALHES = Fore.LIGHTWHITE_EX

    banner = f"""
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⣀⣴⡯⠖⣓⣶⣶⡶⠶⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⢀⣴⣯⡾⣻⠽⡾⠽⠛⠚⠷⠯⠥⠤⠤⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣢⣾⢿⣶⠿⣻⠿⠿⢋⣁⣠⠤⣶⢶⡆⠀⣀⣀⣀⣀⣀⣐⡻⢷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣴⠟⠛⠉⠪⠟⣩⠖⠋⢀⡴⢚⣭⠾⠟⠋⡹⣾⠀⠀⢀⣠⠤⠤⠬⠉⠛⠿⣷⡽⢷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⡾⣿⢝⣯⠆⣩⠖⢀⣤⢞⣁⣄⣴⣫⡴⠛⠁⠀⡀⣼⠀⣿⢠⡴⠚⠋⠉⠭⠿⣷⣦⡤⢬⣝⣲⣌⡙⠀⠀⠀⠀⠀⠀⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣾⣿⣿⣿⣿⣿⣷⣿⣿⣾⣿⣷⣿⣿⣿⣿⠋⠀⢀⢀⣶⣷⣿⠀⣿⠀⠀⠀⠀⠀⠀⠐⠚⠻⣿⣶⣮⣛⢯⡙⠂⠀⠀⠀⠀⠀⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⣸⣿⠋⠀⡆⣾⣾⣿⣿⠿⢂⣿⣄⠀⠀⠀⠀⠀⠀⠐⠢⢤⣉⢳⣍⠲⣮⣳⣄⠀⠀⠀⠀⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠿⣷⡀⢸⣿⣿⣿⠙⠏⠁⣸⣿⣿⣭⣉⡁⠀⠀⠀⠀⠀⠀⠘⣿⣿⡷⣌⣿⡟⢿⣦⠀⠀⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⡿⡏⢡⢟⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡹⣷⣼⣿⡟⠋⠀⠀⣴⣿⣿⣦⣍⣙⣓⡦⠄⠀⠈⠙⠲⢦⣻⣿⡅⠘⣾⣿⡄⠹⡳⡄⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⢹⠀⠀⠞⢭⣻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡈⠳⢼⣧⣄⣠⣾⣿⣿⣿⡻⢿⣭⡉⠁⠀⠀⠀⠀⠀⠀⠙⢿⢻⡄⠈⢻⣿⠀⠉⠹⡆⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣻⡇⡆⠀⢀⣶⣾⣳⠏⠉⢹⡿⣿⣿⣟⡿⠿⢿⣿⣿⣿⣿⣧⠘⠒⠮⣿⣿⣿⣿⣿⣿⣿⣦⡬⠉⠀⠀⠀⢦⠀⠰⡀⠀⠈⠃⠓⠀⠈⣿⡀⠀⠀⢹⡀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣿⣾⡧⣔⠾⡏⠙⠁⠀⣠⣿⢀⡎⠉⠈⠻⠭⠤⠤⣌⡻⣿⡿⡀⠈⠙⠻⠿⠿⣯⣅⠉⠉⣝⠛⢦⡘⣶⡀⠀⢣⠀⠙⢦⡀⠘⢇⣆⠀⣿⡇⠀⠀⠀⡇
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⣀⡠⠶⠿⠟⣃⣀⡀⠀⠀⠈⢓⣶⣾⣟⡡⠞⠀⠀⠀⠠⠴⠶⠿⠷⢿⡼⣿⣗⠀⠀⠀⠀⠀⠀⠈⠛⢆⠈⢧⡀⠁⠘⣿⡄⢢⠇⠀⠈⢧⠀⠸⣼⡄⣿⠇⠀⠀⢧⢸
{COR_AZUL_BEBE}⠀⣠⠴⠾⣿⡛⠛⠛⠁⠀⠀⠀⠙⠲⠈⠉⠀⠀⠀⠀⠤⠤⠤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠘⢿⠷⣄⠘⣷⣄⡀⡄⠀⢀⡀⠀⢳⡄⠀⠀⠳⠀⡏⠀⠀⠸⡄⠀⢿⣧⣿⠀⠀⠀⡀⣼
{COR_AZUL_BEBE}⣾⣿⢶⣦⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣀⣤⣶⣶⣒⠢⢤⠀⠀⠈⠁⠉⠛⠿⣎⡛⢦⣀⠈⣿⣴⣾⣿⡞⡄⠀⠀⢹⡀⠀⠀⣿⠀⣾⣿⠇⠀⠀⠀⡇⢸
{COR_AZUL_BEBE}⠘⣿⣿⡾⡇⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⡐⠲⢦⣦⢤⣤⣤⡶⠛⠉⠉⠀⠀⠀⠀⢀⣠⣤⣀⣤⠴⠂⠀⠀⠁⠀⢹⣧⣿⡿⢸⠇⢻⣿⣆⠀⠀⢷⣀⠀⣿⣷⠟⠉⠀⠀⠀⢸⡇⡄
{COR_AZUL_BEBE}⠀⠈⠳⢭⡗⠒⣛⣻⣽⠿⢿⣯⣷⣾⣿⣿⣿⣶⣬⡉⣉⠈⠑⠒⠉⠙⠻⠯⠉⣩⡟⢁⣾⠏⠀⣾⣷⣤⣄⣀⡀⢨⡿⣿⡇⣸⠀⠘⡿⢹⣆⠀⣸⣿⣷⡿⠁⠀⡀⠀⢸⡀⣾⣧⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠈⠻⠿⣿⢿⡷⣌⣣⡉⠛⢿⣿⣿⣿⣿⣿⣧⡓⢄⠀⠀⠀⠀⠀⢰⡿⠷⣟⠿⠋⠀⢹⣿⡇⠀⠁⠙⣾⢧⠙⠙⠁⠀⠐⠁⠘⠹⣄⣿⠃⠹⣿⡀⠀⡇⠀⡿⣇⡿⢹⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠈⠓⠻⠊⠙⠃⠀⠀⠹⣿⣿⡿⡏⠀⣿⣌⠳⡄⠀⢀⡴⠋⠈⠉⠉⡙⠲⣤⢸⡟⣿⠀⠀⠠⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠿⠃⠀⠀⠈⠃⣸⡇⣼⠇⣿⡇⢸⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⡄⢳⣿⣿⣿⡆⢳⠀⡎⠀⠀⠀⠀⢀⣉⠳⣬⣿⠇⠃⠀⠀⢠⠆⢰⢊⡇⠀⠀⠀⠀⠀⠀⢲⠀⢰⡆⠀⠀⣽⣿⡟⠀⢸⡇⡞⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⢸⡇⠈⣿⢟⣼⣇⡏⠀⠀⠔⣺⡭⠽⣿⡛⠛⠿⡏⠀⣆⠀⠀⣼⠀⣼⣼⣷⡆⠀⠀⣶⡆⢠⡿⣠⣿⡇⠀⢰⣿⠏⣴⢂⠋⡼⠃⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡆⢻⢿⡁⣼⢣⣿⡿⠀⢀⢀⡴⠋⠀⠀⠀⠀⠀⠀⠙⣶⣦⡅⠀⣿⡄⢠⣿⣾⢿⠿⣿⡇⠀⠘⣾⣇⣼⣷⠟⡼⠀⣰⡿⠋⢠⠏⢦⣾⠃⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡟⢾⢄⣹⣧⡿⡽⠁⠀⣿⠋⠀⠀⠀⠀⠀⠀⠀⠟⠉⣧⡾⡽⣠⣿⢛⠇⠏⠰⣻⠃⣼⣽⣿⡿⡿⠁⣴⣡⡾⠋⠀⢠⣞⣴⡿⠁⠀⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣼⣿⣿⡟⠁⣠⡾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠾⠋⠰⠟⣻⣿⢋⠀⠀⣴⣷⣾⠟⡿⠋⠀⣥⠾⠛⡋⠀⠀⢠⣾⣿⠟⠀⠀⠀⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠿⠽⠒⠚⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠋⢁⡌⠀⢰⣿⠟⠁⠀⠀⠀⠀⡀⠀⣰⠃⠀⣴⡿⣿⠏⠀⠀⠀⠀⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⠋⢀⣴⠏⠀⠀⢸⡋⠀⡀⠀⣀⠖⠋⣠⣾⢃⣠⡾⠟⢡⠇⠀⠀⠀⠀⠀⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠎⣀⣴⡿⠃⠀⠀⠀⠀⢁⡾⠁⢈⣁⣴⣾⣿⣿⠟⠉⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣾⣿⡿⠁⠀⢀⣀⣤⣼⢟⣡⣶⠿⠟⠋⣰⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣟⣿⣿⣃⣴⣶⣿⠿⣿⣿⡿⠋⠀⠀⠀⠊⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣾⣿⣿⣿⠛⠉⠀⠀⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⠟⠁⠀⠀⠀⠀⠙⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
{COR_AZUL_BEBE}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀


{Style.BRIGHT}{COR_WOLF}██╗    ██╗ ██████╗ ██╗     ███████╗
{Style.BRIGHT}{COR_WOLF}██║    ██║██╔═══██╗██║     ██╔════╝
{Style.BRIGHT}{COR_WOLF}██║ █╗ ██║██║   ██║██║     █████╗
{Style.BRIGHT}{COR_WOLF}██║███╗██║██║   ██║██║     ██╔══╝
{Style.BRIGHT}{COR_WOLF}╚███╔███╔╝╚██████╔╝███████╗██║
{Style.BRIGHT}{COR_WOLF} ╚══╝╚══╝  ╚═════╝ ╚══════╝╚═╝     {COR_NOME}by:jottap_62

{Style.BRIGHT}{COR_DETALHES} ██████╗ ███████╗██████╗  █████╗ ██████╗  ██████╗ ██████╗
{Style.BRIGHT}{COR_DETALHES}██╔════╝ ██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔═══██╗██╔══██╗
{Style.BRIGHT}{COR_DETALHES}██║  ███╗█████╗  ██████╔╝███████║██║  ██║██║   ██║██████╔╝
{Style.BRIGHT}{COR_DETALHES}██║   ██║██╔══╝  ██╔══██╗██╔══██║██║  ██║██║   ██║██╔══██╗
{Style.BRIGHT}{COR_DETALHES}╚██████╔╝███████╗██║  ██║██║  ██║██████╔╝╚██████╔╝██║  ██║
{Style.BRIGHT}{COR_DETALHES} ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝

{Style.BRIGHT}{COR_DETALHES}🐺 WOLF GERADOR PREMIUM v10.0.1
{Style.BRIGHT}{COR_DETALHES}⚠ DADOS FICTÍCIOS - USE COM RESPONSABILIDATE
{Style.BRIGHT}{COR_SUCESSO}⏰ {clock.current_time}{Style.RESET_ALL}
    """
    print(banner)

# ==================== CLASSE PRINCIPAL ====================
class WolfGeradorPremium:
    VERSION = "10.0.1-premium"
    SENHA_MASTER_HASH = "40c7209175a035b30db38ce61abbffd941a9607cb29c04a3e8bf3825a0b13e8d"

    def __init__(self):
        self.estados_brasil = [
            "AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO",
            "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI",
            "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO",
        ]
        self.bancos_brasil = {
            "001": "Banco do Brasil",
            "033": "Santander",
            "104": "Caixa Econômica Federal",
            "237": "Bradesco",
            "341": "Itaú",
            "745": "Citibank",
            "": "Aleatório"
        }
        self.bandeiras_cartao = {
            "1": "Visa",
            "2": "Mastercard",
            "3": "American Express",
            "4": "Diners Club",
            "5": "Elo",
            "6": "Aleatório"
        }
        self.master_mode = False
        self.nomes_masculinos = ["João", "Pedro", "Carlos", "Lucas", "Marcos", "Paulo", "Fernando", "Ricardo", "Eduardo", "Gustavo"]
        self.nomes_femininos = ["Maria", "Ana", "Juliana", "Patricia", "Camila", "Amanda", "Fernanda", "Beatriz", "Carolina", "Isabela"]
        self.sobrenomes = ["Silva", "Santos", "Oliveira", "Souza", "Rodrigues", "Ferreira", "Almeida", "Pereira", "Gomes", "Martins"]
        self.ruas = ["A", "B", "C", "Floriano", "São João", "Brasil", "Portugal", "Paulista", "Rio de Janeiro", "Amazonas"]
        self.cidades_por_estado = {
            "SP": ["São Paulo", "Campinas", "Santos", "Ribeirão Preto"],
            "RJ": ["Rio de Janeiro", "Niterói", "Petrópolis"],
            "MG": ["Belo Horizonte", "Uberlândia", "Juiz de Fora"],
            "RS": ["Porto Alegre", "Caxias do Sul", "Pelotas"]
        }
        self.marcas_veiculos = ["Fiat", "Volkswagen", "Chevrolet", "Ford", "Toyota", "Hyundai", "Renault", "Honda"]
        self.modelos_veiculos = {
            "Fiat": ["Uno", "Palio", "Strada", "Mobi"],
            "Volkswagen": ["Gol", "Polo", "Voyage", "Saveiro"],
            "Chevrolet": ["Onix", "Prisma", "S10", "Tracker"],
            "Ford": ["Ka", "Fiesta", "Ranger", "EcoSport"]
        }

    def _hash_password(self, password):
        return hashlib.sha256(password.encode()).hexdigest()

    def verificar_senha_master(self):
        limpar_termux()
        clock = ClockThread()
        clock.start()
        mostrar_banner_termux(clock)
        print(linha_horizontal('╔', '╗'))
        print(linha_texto(f"{COR_ERRO}🔒 MODO ADMINISTRADOR", 'center'))
        print(linha_horizontal('╚', '╝'))
        senha = input(f"{COR_MENU}🔑 Digite a senha master: {Style.RESET_ALL}")
        clock.stop()

        if self._hash_password(senha) == self.SENHA_MASTER_HASH:
            self.master_mode = True
            print(linha_horizontal('╔', '╗'))
            print(linha_texto(f"{COR_SUCESSO}✅ Modo administrador ativado! 🔓", 'center'))
            print(linha_horizontal('╚', '╝'))
            time.sleep(2)
            return True
        else:
            print(linha_horizontal('╔', '╗'))
            print(linha_texto(f"{COR_ERRO}❌ Senha incorreta! 🔒", 'center'))
            print(linha_horizontal('╚', '╝'))
            time.sleep(2)
            return False

    def gerar_cpf(self, pontuacao=True, primeiro_digito=None):
        def calcula_digito(cpf, peso):
            soma = 0
            for i in range(len(cpf)):
                soma += int(cpf[i]) * peso[i]
            resto = soma % 11
            return '0' if resto < 2 else str(11 - resto)

        if primeiro_digito is not None:
            numeros = [str(primeiro_digito)] + [str(random.randint(0, 9)) for _ in range(8)]
        else:
            numeros = [str(random.randint(0, 9)) for _ in range(9)]

        peso = [10, 9, 8, 7, 6, 5, 4, 3, 2]
        numeros.append(calcula_digito(numeros, peso))

        peso = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2]
        numeros.append(calcula_digito(numeros, peso))

        cpf = ''.join(numeros)
        if pontuacao:
            return f"{cpf[:3]}.{cpf[3:6]}.{cpf[6:9]}-{cpf[9:]}"
        return cpf

    def gerar_cnpj(self, pontuacao=True):
        def calcula_digito(cnpj, peso):
            soma = 0
            for i in range(len(cnpj)):
                soma += int(cnpj[i]) * peso[i]
            resto = soma % 11
            return '0' if resto < 2 else str(11 - resto)

        numeros = [str(random.randint(0, 9)) for _ in range(8)] + ['0', '0', '0', '1']

        peso = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        numeros.append(calcula_digito(numeros, peso))

        peso = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        numeros.append(calcula_digito(numeros, peso))

        cnpj = ''.join(numeros)
        if pontuacao:
            return f"{cnpj[:2]}.{cnpj[2:5]}.{cnpj[5:8]}/{cnpj[8:12]}-{cnpj[12:]}"
        return cnpj

    def gerar_rg(self, pontuacao=True):
        numeros = [str(random.randint(0, 9)) for _ in range(8)]
        rg = ''.join(numeros)
        if pontuacao:
            return f"{rg[:2]}.{rg[2:5]}.{rg[5:8]}-{random.choice('0123456789X')}"
        return rg

    def gerar_pessoa(self, sexo="I", idade="", estado=""):
        sexo = sexo.upper() if sexo.upper() in ["M", "F", "I"] else "I"

        if sexo == "M":
            nome = random.choice(self.nomes_masculinos)
        elif sexo == "F":
            nome = random.choice(self.nomes_femininos)
        else:
            nome = random.choice(self.nomes_masculinos + self.nomes_femininos)

        nome += " " + random.choice(self.sobrenomes)

        try:
            idade_int = int(idade) if idade and idade.isdigit() and 0 <= int(idade) <= 120 else random.randint(18, 70)
        except:
            idade_int = random.randint(18, 70)

        ano_nasc = datetime.now().year - idade_int
        mes_nasc = random.randint(1, 12)
        dia_nasc = random.randint(1, 28)

        estado = estado.upper() if estado.upper() in self.estados_brasil else random.choice(self.estados_brasil)
        cidade = random.choice(self.cidades_por_estado.get(estado, ["São Paulo"]))

        dados = {
            'nome': nome,
            'cpf': self.gerar_cpf(),
            'rg': self.gerar_rg(),
            'data_nasc': f"{dia_nasc:02d}/{mes_nasc:02d}/{ano_nasc}",
            'idade': str(idade_int),
            'endereco': f"Rua {random.choice(self.ruas)}, {random.randint(1, 9999)}, {cidade}/{estado}",
            'telefone': self.gerar_telefone(estado),
            'celular': self.gerar_telefone(estado, celular=True),
            'email': self.gerar_email(nome.split()[0]),
            'Hora_Geração': datetime.now().strftime("%H:%M:%S")
        }

        return dados

    def gerar_empresa(self, estado=""):
        estado = estado.upper() if estado.upper() in self.estados_brasil else random.choice(self.estados_brasil)
        cidade = random.choice(self.cidades_por_estado.get(estado, ["São Paulo"]))

        nome_fantasia = random.choice(["Mercado", "Padaria", "Auto Peças", "Tech", "Comércio"]) + " " + random.choice(self.sobrenomes)
        razao_social = nome_fantasia + " LTDA"

        dados = {
            'cnpj': self.gerar_cnpj(),
            'razao_social': razao_social,
            'nome_fantasia': nome_fantasia,
            'endereco': f"Av. {random.choice(self.ruas)}, {random.randint(10, 9999)}, {cidade}/{estado}",
            'telefone': self.gerar_telefone(estado),
            'email': self.gerar_email(nome_fantasia.split()[0].lower()),
            'Hora_Geração': datetime.now().strftime("%H:%M:%S")
        }

        return dados

    def gerar_telefone(self, estado="", celular=False):
        ddd_map = {
            "SP": ["11", "12", "13", "14", "15", "16", "17", "18", "19"],
            "RJ": ["21", "22", "24"],
            "MG": ["31", "32", "33", "34", "35", "37", "38"],
            "RS": ["51", "53", "54", "55"],
            "PR": ["41", "42", "43", "44", "45", "46"],
            "SC": ["47", "48", "49"],
            "BA": ["71", "73", "74", "75", "77"],
            "PE": ["81", "87"],
            "CE": ["85", "88"],
            "DF": ["61"],
            "GO": ["62", "64"],
            "ES": ["27", "28"]
        }

        estado = estado.upper() if estado.upper() in self.estados_brasil else random.choice(self.estados_brasil)
        ddd = random.choice(ddd_map.get(estado, ["11"]))

        prefixo = "9" if celular else random.choice(["2", "3", "4", "5"])
        numero = f"{prefixo}{random.randint(1000, 9999)}-{random.randint(1000, 9999)}"
        return f"({ddd}) {numero}"

    def gerar_celular(self, estado="", ddd=""):
        if not ddd:
            return self.gerar_telefone(estado, celular=True)

        prefixo = "9"
        numero = f"{prefixo}{random.randint(1000, 9999)}-{random.randint(1000, 9999)}"
        return f"({ddd}) {numero}"

    def gerar_cartao_credito(self, bandeira="random"):
        bandeiras = {
            "visa": "4",
            "mastercard": "5",
            "amex": "3",
            "diners": "3",
            "elo": "5"
        }

        if bandeira == "random":
            bandeira = random.choice(list(bandeiras.keys()))

        inicio = bandeiras.get(bandeira.lower(), "4")

        if bandeira.lower() == "visa":
            numero = "4" + "".join([str(random.randint(0, 9)) for _ in range(15)])
        elif bandeira.lower() == "mastercard":
            numero = "5" + str(random.randint(1, 5)) + "".join([str(random.randint(0, 9)) for _ in range(14)])
        elif bandeira.lower() == "amex":
            numero = "3" + str(random.choice([4, 7])) + "".join([str(random.randint(0, 9)) for _ in range(13)])
        else:
            numero = inicio + "".join([str(random.randint(0, 9)) for _ in range(15)])

        mes = random.randint(1, 12)
        ano = datetime.now().year + random.randint(1, 5)
        validade = f"{mes:02d}/{str(ano)[-2:]}"

        cvv = "".join([str(random.randint(0, 9)) for _ in range(3 if bandeira.lower() != "amex" else 4)])

        nome = random.choice(self.nomes_masculinos + self.nomes_femininos) + " " + random.choice(self.sobrenomes)

        return {
            'numero': numero[:4] + " " + numero[4:8] + " " + numero[8:12] + " " + numero[12:],
            'validade': validade,
            'cvv': cvv,
            'bandeira': bandeira.capitalize(),
            'nome': nome.upper(),
            'Hora_Geração': datetime.now().strftime("%H:%M:%S")
        }

    def gerar_conta_bancaria(self, banco=""):
        banco = banco if banco in self.bancos_brasil else random.choice(list(self.bancos_brasil.keys()))

        agencia = f"{random.randint(1000, 9999)}-{random.choice(['0','1','2','9'])}"
        conta = f"{random.randint(10000, 999999)}-{random.randint(0, 9)}"

        estado = random.choice(self.estados_brasil)
        cidade = random.choice(self.cidades_por_estado.get(estado, ["São Paulo"]))

        return {
            'banco': self.bancos_brasil[banco],
            'agencia': agencia,
            'conta': conta,
            'tipo': "Corrente",
            'cidade': cidade,
            'estado': estado,
            'Hora_Geração': datetime.now().strftime("%H:%M:%S")
        }

    def gerar_cep(self, estado=""):
        estado = estado.upper() if estado.upper() in self.estados_brasil else random.choice(self.estados_brasil)

        cep_prefixos = {
            "SP": ["01000", "09999", "10000", "19999"],
            "RJ": ["20000", "28999", "29000", "29999"],
            "MG": ["30000", "39999"],
            "RS": ["90000", "99999"],
            "PR": ["80000", "87999"],
            "SC": ["88000", "89999"],
            "BA": ["40000", "48999"],
            "PE": ["50000", "56999"],
            "CE": ["60000", "63999"],
            "DF": ["70000", "72799"]
        }

        prefixo = random.choice(cep_prefixos.get(estado, ["01000", "99999"]))
        cep = prefixo[:2] + str(random.randint(0, 9)) + str(random.randint(0, 9)) + str(random.randint(0, 9)) + "-" + str(random.randint(0, 9)) + str(random.randint(0, 9)) + str(random.randint(0, 9))

        return {
            'CEP': cep,
            'Hora': datetime.now().strftime("%H:%M:%S")
        }

    def gerar_veiculo(self, estado=""):
        estado = estado.upper() if estado.upper() in self.estados_brasil else random.choice(self.estados_brasil)
        marca = random.choice(self.marcas_veiculos)
        modelo = random.choice(self.modelos_veiculos.get(marca, ["Uno"]))
        ano = random.randint(2000, datetime.now().year)
        cor = random.choice(["Branco", "Preto", "Prata", "Vermelho", "Azul", "Cinza"])

        letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        numeros = "0123456789"
        placa = (random.choice(letras) + random.choice(letras) + random.choice(letras) +
               random.choice(numeros) +
               random.choice(letras) +
               random.choice(numeros) +
               random.choice(numeros))

        return {
            'placa': placa,
            'marca': marca,
            'modelo': modelo,
            'ano': str(ano),
            'cor': cor,
            'renavam': ''.join([str(random.randint(0, 9)) for _ in range(11)]),
            'Hora_Geração': datetime.now().strftime("%H:%M:%S")
        }

    def gerar_senha(self, tamanho=12, maiusculas=True, minusculas=True, numeros=True, simbolos=False):
        caracteres = ""
        if maiusculas: caracteres += "ABCDEFGHJKLMNPQRSTUVWXYZ"
        if minusculas: caracteres += "abcdefghjkmnpqrstuvwxyz"
        if numeros: caracteres += "23456789"
        if simbolos: caracteres += "!@#$%&*"

        if not caracteres:
            caracteres = "abcdefghjkmnpqrstuvwxyz23456789"

        tamanho = max(8, min(50, tamanho))
        senha = ''.join(random.choice(caracteres) for _ in range(tamanho))
        return {"SENHA": senha, "Hora": datetime.now().strftime("%H:%M:%S")}

    def gerar_email(self, nome="", dominio=""):
        nome = nome.lower() if nome else random.choice(["user", "anon", "temp"])
        nome = re.sub(r'[^a-z]', '', nome)

        dominios = ["gmail.com", "hotmail.com", "yahoo.com.br", "outlook.com", "icloud.com"]
        dominio = dominio if dominio and "." in dominio else random.choice(dominios)

        sufixos = ["", str(random.randint(1, 999)), "".join(random.choice("abcdefghijk") for _ in range(3))]

        email = f"{nome}{random.choice(sufixos)}@{dominio}"
        return {"EMAIL": email, "Hora": datetime.now().strftime("%H:%M:%S")}

    def gerar_numeros(self, quantidade=1, minimo=1, maximo=100):
        try:
            quantidade = max(1, min(100, int(quantidade)))
            minimo = int(minimo)
            maximo = int(maximo)
        except:
            quantidade, minimo, maximo = 1, 1, 100

        numeros = [str(random.randint(minimo, maximo)) for _ in range(quantidade)]
        return {"NUMEROS": ", ".join(numeros), "Hora": datetime.now().strftime("%H:%M:%S")}

# ==================== FUNÇÕES DE MENU ====================
def mostrar_resultado(titulo, dados):
    limpar_termux()
    clock = ClockThread()
    clock.start()
    mostrar_banner_termux(clock)
    print()
    print(linha_horizontal('╔', '╗'))
    print(linha_texto(f"{COR_DESTAQUE}📌 {titulo.upper()}", 'center'))
    print(linha_horizontal('╠', '╣', '═'))

    if isinstance(dados, dict):
        if 'error' in dados:
            print(linha_texto(f"{COR_ERRO} ERRO: {dados['error']}", 'center'))
        else:
            for chave, valor in dados.items():
                cor = COR_ERRO if chave in ['CPF', 'CNPJ', 'RG', 'Senha', 'Cartão'] else COR_MENU
                linha = f"{cor} {chave.ljust(15)}: {COR_DADOS}{str(valor)}"
                print(linha_texto(linha))
    else:
        print(linha_texto(f"{COR_DADOS} {str(dados)}"))

    print(linha_horizontal('╚', '╝'))
    clock.stop()
    input(f"{COR_SUCESSO}↵ Pressione Enter para continuar...{Style.RESET_ALL}")

def mostrar_opcoes_sexo():
    clock = ClockThread()
    clock.start()
    mostrar_banner_termux(clock)
    print()
    print(linha_horizontal('╔', '╗'))
    print(linha_texto(f"{COR_DESTAQUE}⚧ OPÇÕES DE SEXO", 'center'))
    print(linha_horizontal('╠', '╣', '═'))
    print(linha_texto(f"{COR_MENU} [M] Masculino"))
    print(linha_texto(f"{COR_MENU} [F] Feminino"))
    print(linha_texto(f"{COR_MENU} [I] Indiferente"))
    print(linha_horizontal('╚', '╝'))
    clock.stop()

def mostrar_opcoes_bancos(gerador):
    clock = ClockThread()
    clock.start()
    mostrar_banner_termux(clock)
    print()
    print(linha_horizontal('╔', '╗'))
    print(linha_texto(f"{COR_DESTAQUE}🏦 BANCOS DISPONÍVEIS", 'center'))
    print(linha_horizontal('╠', '╣', '═'))
    for codigo, nome in gerador.bancos_brasil.items():
        linha = f"{COR_MENU} {codigo if codigo else '[Enter]'.ljust(4)} - {nome}"
        print(linha_texto(linha))
    print(linha_horizontal('╚', '╝'))
    clock.stop()

def mostrar_opcoes_bandeiras():
    clock = ClockThread()
    clock.start()
    mostrar_banner_termux(clock)
    print()
    print(linha_horizontal('╔', '╗'))
    print(linha_texto(f"{COR_DESTAQUE}💳 BANDEIRAS DISPONÍVEIS", 'center'))
    print(linha_horizontal('╠', '╣', '═'))
    print(linha_texto(f"{COR_MENU} [1] Visa"))
    print(linha_texto(f"{COR_MENU} [2] Mastercard"))
    print(linha_texto(f"{COR_MENU} [3] American Express"))
    print(linha_texto(f"{COR_MENU} [4] Diners Club"))
    print(linha_texto(f"{COR_MENU} [5] Elo"))
    print(linha_texto(f"{COR_MENU} [6] Aleatório"))
    print(linha_horizontal('╚', '╝'))
    clock.stop()

def mostrar_menu_principal(gerador):
    opcoes = [
        ["1", "👤 Pessoa Física Completa"],
        ["2", "🔢 Gerar CPF"],
        ["3", "🆔 Gerar RG"],
        ["4", "🏢 Gerar Empresa/CNPJ"],
        ["5", "💳 Gerar Cartão de Crédito"],
        ["6", "🏦 Gerar Conta Bancária"],
        ["7", "📮 Gerar CEP"],
        ["8", "🚗 Gerar Veículo"],
        ["9", "🔐 Gerar Senha Segura"],
        ["10", "📧 Gerar E-mail"],
        ["11", "📱 Gerar Celular"],
        ["12", "🎲 Gerar Números Aleatórios"],
        ["99", "🔓 Modo Administrador"],
        ["0", "🚪 Sair"]
    ]

    try:
        clock = ClockThread()
        clock.start()
        limpar_termux()
        mostrar_banner_termux(clock)

        print()
        print(linha_horizontal('╔', '╗'))
        print(linha_texto(f"{COR_DESTAQUE}📱 MENU PRINCIPAL", 'center'))
        if gerador.master_mode:
            print(linha_texto(f"{COR_SUCESSO}🔓 ADMIN ATIVADO", 'center'))
        else:
            print(linha_texto(f"{COR_ERRO}🔒 ADMIN DESATIVADO", 'center'))
        print(linha_horizontal('╠', '╣', '═'))

        for opcao in opcoes:
            texto_opcao = f"{COR_NUMEROS}[{opcao[0].rjust(2)}]{COR_OPCOES} {opcao[1]}"
            print(linha_texto(texto_opcao))

        print(linha_horizontal('╚', '╝'))

        opcao = input(f"{COR_MENU}➤ Escolha uma opção: {Style.RESET_ALL}").strip()
        return opcao

    except KeyboardInterrupt:
        return "0"
    except Exception as e:
        print(f"{COR_ERRO}Erro no menu: {str(e)}")
        return None
    finally:
        if 'clock' in locals() and clock.is_alive():
            clock.stop()

# ==================== MAIN ====================
if __name__ == "__main__":
    try:
        gerador = WolfGeradorPremium()

        while True:
            try:
                opcao = mostrar_menu_principal(gerador)

                if opcao == "0":
                    limpar_termux()
                    clock = ClockThread()
                    clock.start()
                    mostrar_banner_termux(clock)
                    print()
                    print(linha_horizontal('╔', '╗'))
                    print(linha_texto(f"{COR_SUCESSO}🐺 Saindo... Até logo!", 'center'))
                    print(linha_horizontal('╚', '╝'))
                    clock.stop()
                    break

                elif opcao == "99":
                    gerador.verificar_senha_master()

                elif opcao == "1":
                    limpar_termux()
                    clock = ClockThread()
                    clock.start()
                    mostrar_banner_termux(clock)
                    print()
                    print(linha_horizontal('╔', '╗'))
                    print(linha_texto(f"{COR_DESTAQUE}👤 GERAR PESSOA FÍSICA", 'center'))
                    print(linha_horizontal('╚', '╝'))
                    clock.stop()

                    mostrar_opcoes_sexo()
                    sexo = input(f"{COR_MENU}⚧ Sexo [M/F/I]: ").upper() or "I"
                    idade = input(f"{COR_MENU}🎂 Idade [0-120]: ") or ""
                    estado = input(f"{COR_MENU}📍 UF (ex: SP): ").upper() or ""

                    dados = gerador.gerar_pessoa(sexo, idade, estado)
                    mostrar_resultado("DADOS PESSOAIS", dados)

                elif opcao == "2":
                    limpar_termux()
                    clock = ClockThread()
                    clock.start()
                    mostrar_banner_termux(clock)
                    print()
                    print(linha_horizontal('╔', '╗'))
                    print(linha_texto(f"{COR_DESTAQUE}🔢 GERAR CPF", 'center'))
                    print(linha_horizontal('╚', '╝'))
                    clock.stop()

                    pontuacao = input(f"{COR_MENU}🔣 Com pontuação? [S/N]: ").upper() or "S"

                    while True:
                        primeiro_digito = input(f"{COR_MENU}🔢 Primeiro dígito (0-9, deixe em branco para aleatório): ").strip()
                        if not primeiro_digito:
                            primeiro_digito = None
                            break
                        elif primeiro_digito.isdigit() and len(primeiro_digito) == 1:
                            primeiro_digito = int(primeiro_digito)
                            break
                        else:
                            limpar_termux()
                            clock = ClockThread()
                            clock.start()
                            mostrar_banner_termux(clock)
                            print()
                            print(linha_horizontal('╔', '╗'))
                            print(linha_texto(f"{COR_ERRO}❌ Digite apenas um número de 0 a 9 ou deixe em branco", 'center'))
                            print(linha_horizontal('╚', '╝'))
                            clock.stop()

                    dados = gerador.gerar_cpf(pontuacao == "S", primeiro_digito)
                    mostrar_resultado("CPF GERADO", dados)

                elif opcao == "3":
                    limpar_termux()
                    clock = ClockThread()
                    clock.start()
                    mostrar_banner_termux(clock)
                    print()
                    print(linha_horizontal('╔', '╗'))
                    print(linha_texto(f"{COR_DESTAQUE}🆔 GERAR RG", 'center'))
                    print(linha_horizontal('╚', '╝'))
                    clock.stop()

                    pontuacao = input(f"{COR_MENU}🔣 Com pontuação? [S/N]: ").upper() or "S"
                    dados = gerador.gerar_rg(pontuacao == "S")
                    mostrar_resultado("RG GERADO", dados)

                elif opcao == "4":
                    limpar_termux()
                    clock = ClockThread()
                    clock.start()
                    mostrar_banner_termux(clock)
                    print()
                    print(linha_horizontal('╔', '╗'))
                    print(linha_texto(f"{COR_DESTAQUE}🏢 GERAR EMPRESA", 'center'))
                    print(linha_horizontal('╚', '╝'))
                    clock.stop()

                    estado = input(f"{COR_MENU}📍 UF (ex: SP): ").upper() or ""
                    dados = gerador.gerar_empresa(estado)
                    mostrar_resultado("DADOS DA EMPRESA", dados)

                elif opcao == "5":
                    limpar_termux()
                    clock = ClockThread()
                    clock.start()
                    mostrar_banner_termux(clock)
                    print()
                    print(linha_horizontal('╔', '╗'))
                    print(linha_texto(f"{COR_DESTAQUE}💳 GERAR CARTÃO", 'center'))
                    print(linha_horizontal('╚', '╝'))
                    clock.stop()

                    mostrar_opcoes_bandeiras()
                    op = input(f"{COR_MENU}🎴 Escolha [1-6]: ") or "6"
                    bandeira = gerador.bandeiras_cartao.get(op, "random")
                    dados = gerador.gerar_cartao_credito(bandeira)
                    mostrar_resultado("CARTÃO GERADO", dados)

                elif opcao == "6":
                    limpar_termux()
                    clock = ClockThread()
                    clock.start()
                    mostrar_banner_termux(clock)
                    print()
                    print(linha_horizontal('╔', '╗'))
                    print(linha_texto(f"{COR_DESTAQUE}🏦 GERAR CONTA BANCÁRIA", 'center'))
                    print(linha_horizontal('╚', '╝'))
                    clock.stop()

                    mostrar_opcoes_bancos(gerador)
                    banco = input(f"{COR_MENU}🏛 Código do banco: ") or ""
                    dados = gerador.gerar_conta_bancaria(banco)
                    mostrar_resultado("CONTA BANCÁRIA", dados)

                elif opcao == "7":
                    limpar_termux()
                    clock = ClockThread()
                    clock.start()
                    mostrar_banner_termux(clock)
                    print()
                    print(linha_horizontal('╔', '╗'))
                    print(linha_texto(f"{COR_DESTAQUE}📮 GERAR CEP", 'center'))
                    print(linha_horizontal('╚', '╝'))
                    clock.stop()

                    estado = input(f"{COR_MENU}📍 UF (ex: SP): ").upper() or ""
                    dados = gerador.gerar_cep(estado)
                    mostrar_resultado("CEP GERADO", dados)

                elif opcao == "8":
                    limpar_termux()
                    clock = ClockThread()
                    clock.start()
                    mostrar_banner_termux(clock)
                    print()
                    print(linha_horizontal('╔', '╗'))
                    print(linha_texto(f"{COR_DESTAQUE}🚗 GERAR VEÍCULO", 'center'))
                    print(linha_horizontal('╚', '╝'))
                    clock.stop()

                    estado = input(f"{COR_MENU}📍 UF (ex: SP): ").upper() or ""
                    dados = gerador.gerar_veiculo(estado)
                    mostrar_resultado("DADOS DO VEÍCULO", dados)

                elif opcao == "9":
                    limpar_termux()
                    clock = ClockThread()
                    clock.start()
                    mostrar_banner_termux(clock)
                    print()
                    print(linha_horizontal('╔', '╗'))
                    print(linha_texto(f"{COR_DESTAQUE}🔐 GERAR SENHA", 'center'))
                    print(linha_horizontal('╚', '╝'))
                    clock.stop()

                    tamanho = input(f"{COR_MENU}📏 Tamanho [8-50]: ") or "12"
                    try:
                        tamanho = max(8, min(50, int(tamanho)))
                    except:
                        tamanho = 12

                    maiusculas = input(f"{COR_MENU}🔠 Maiúsculas? [S/N]: ").upper() or "S"
                    minusculas = input(f"{COR_MENU}🔡 Minúsculas? [S/N]: ").upper() or "S"
                    numeros = input(f"{COR_MENU}🔢 Números? [S/N]: ").upper() or "S"
                    simbolos = input(f"{COR_MENU}🔣 Símbolos? [S/N]: ").upper() or "N"

                    dados = gerador.gerar_senha(
                        tamanho=tamanho,
                        maiusculas=maiusculas == "S",
                        minusculas=minusculas == "S",
                        numeros=numeros == "S",
                        simbolos=simbolos == "S"
                    )
                    mostrar_resultado("SENHA GERADA", dados)

                elif opcao == "10":
                    limpar_termux()
                    clock = ClockThread()
                    clock.start()
                    mostrar_banner_termux(clock)
                    print()
                    print(linha_horizontal('╔', '╗'))
                    print(linha_texto(f"{COR_DESTAQUE}📧 GERAR E-MAIL", 'center'))
                    print(linha_horizontal('╚', '╝'))
                    clock.stop()

                    nome = input(f"{COR_MENU}👤 Nome base (opcional): ") or ""
                    dominio = input(f"{COR_MENU}🌐 Domínio (opcional): ") or ""

                    dados = gerador.gerar_email(nome, dominio)
                    mostrar_resultado("E-MAIL GERADO", dados)

                elif opcao == "11":
                    limpar_termux()
                    clock = ClockThread()
                    clock.start()
                    mostrar_banner_termux(clock)
                    print()
                    print(linha_horizontal('╔', '╗'))
                    print(linha_texto(f"{COR_DESTAQUE}📱 GERAR CELULAR", 'center'))
                    print(linha_horizontal('╚', '╝'))
                    clock.stop()

                    estado = input(f"{COR_MENU}📍 UF (opcional): ").upper() or ""
                    ddd = input(f"{COR_MENU}📞 DDD (opcional): ") or ""

                    dados = gerador.gerar_celular(estado, ddd)
                    mostrar_resultado("CELULAR GERADO", dados)

                elif opcao == "12":
                    limpar_termux()
                    clock = ClockThread()
                    clock.start()
                    mostrar_banner_termux(clock)
                    print()
                    print(linha_horizontal('╔', '╗'))
                    print(linha_texto(f"{COR_DESTAQUE}🎲 GERAR NÚMEROS ALEATÓRIOS", 'center'))
                    print(linha_horizontal('╚', '╝'))
                    clock.stop()

                    quantidade = input(f"{COR_MENU}🔢 Quantidade: ") or "1"
                    minimo = input(f"{COR_MENU}📉 Mínimo: ") or "1"
                    maximo = input(f"{COR_MENU}📈 Máximo: ") or "100"

                    try:
                        quantidade = max(1, min(100, int(quantidade)))
                        minimo = int(minimo)
                        maximo = int(maximo)
                    except:
                        quantidade, minimo, maximo = 1, 1, 100

                    dados = gerador.gerar_numeros(quantidade, minimo, maximo)
                    mostrar_resultado("NÚMEROS ALEATÓRIOS", dados)

                else:
                    limpar_termux()
                    clock = ClockThread()
                    clock.start()
                    mostrar_banner_termux(clock)
                    print()
                    print(linha_horizontal('╔', '╗'))
                    print(linha_texto(f"{COR_ERRO}❌ Opção inválida!", 'center'))
                    print(linha_horizontal('╚', '╝'))
                    clock.stop()
                    time.sleep(1)

            except KeyboardInterrupt:
                continue
            except Exception as e:
                logging.error(f"Erro no menu: {str(e)}")
                limpar_termux()
                clock = ClockThread()
                clock.start()
                mostrar_banner_termux(clock)
                print()
                print(linha_horizontal('╔', '╗'))
                print(linha_texto(f"{COR_ERRO}Erro: {str(e)}", 'center'))
                print(linha_horizontal('╚', '╝'))
                clock.stop()
                time.sleep(2)

    except Exception as e:
        print(f"\n{COR_ERRO}Erro fatal: {str(e)}")
