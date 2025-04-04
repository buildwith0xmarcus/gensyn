#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}==========================================${NC}"
echo -e "${BLUE}        Ngrok Kurulum Başlatılıyor         ${NC}"
echo -e "${BLUE}==========================================${NC}"

echo -e "${YELLOW}[1/3] Ngrok indiriliyor...${NC}"
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
tar xvzf ngrok-v3-stable-linux-amd64.tgz
sudo mv ngrok /usr/local/bin/
rm ngrok-v3-stable-linux-amd64.tgz

echo -e "${YELLOW}[2/3] Ngrok token ayarı yapılıyor...${NC}"
read -p "Lütfen Ngrok tokeninizi girin: " NGROK_TOKEN
ngrok config add-authtoken $NGROK_TOKEN

echo -e "${GREEN}==========================================${NC}"
echo -e "${GREEN}        Ngrok Kurulumu Tamamlandı!        ${NC}"
echo -e "${GREEN}==========================================${NC}" 

echo -e "${BLUE}==========================================${NC}"
echo -e "${BLUE}        Ngrok Başlatılıyor                 ${NC}"
echo -e "${BLUE}==========================================${NC}"

echo -e "${YELLOW}Ngrok http 3000 başlatılıyor...${NC}"
ngrok http 3000 