#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}==========================================${NC}"
echo -e "${BLUE}        Gensyn Kurulum Başlatılıyor        ${NC}"
echo -e "${BLUE}==========================================${NC}"

echo -e "${YELLOW}[1/10] net-tools kurulumu yapılıyor...${NC}"
sudo apt-get update && sudo apt-get upgrade -y
sudo apt install net-tools -y

echo -e "${YELLOW}[2/10] Temel paketler kuruluyor...${NC}"
sudo apt install screen curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip -y

echo -e "${YELLOW}[3/10] Python ve gerekli paketler kuruluyor...${NC}"
sudo apt install python3 python3-pip python3.10-venv -y

echo -e "${YELLOW}[4/10] Node.js kurulumu yapılıyor...${NC}"
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g yarn


echo -e "${YELLOW}[6/10] rl-swarm projesi hazırlanıyor...${NC}"
if [ -d "rl-swarm" ]; then
    echo "rl-swarm klasörü siliniyor..."
    rm -rf rl-swarm
fi
git clone https://github.com/gensyn-ai/rl-swarm/
cd rl-swarm

echo -e "${YELLOW}[7/10] Python sanal ortamı oluşturuluyor...${NC}"
python3 -m venv .venv
source .venv/bin/activate

echo -e "${YELLOW}[8/10] NPM paketleri güncelleniyor...${NC}"
cd web/ui
rm -f package-lock.json
npm install --legacy-peer-deps
cd ../../modal-login
rm -f package-lock.json yarn.lock
npm install viem@2.22.6 wagmi@2.12.7 @account-kit/core@4.20.0 @account-kit/infra@4.20.0 @account-kit/react@4.20.0 @account-kit/smart-contracts@4.20.0 --force
npm install --force

echo -e "${YELLOW}[9/10] rl-swarm başlatılıyor...${NC}"
cd rl-swarm
echo "Y" | ./run_rl_swarm.sh


IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
echo -e "${GREEN}==========================================${NC}"
echo -e "${GREEN}        Kurulum Başarıyla Tamamlandı!     ${NC}"
echo -e "${GREEN}==========================================${NC}"
echo -e "${YELLOW}Yerel adres:${NC}"
echo -e "${BLUE}http://${IP}:3000${NC}"
echo -e "${YELLOW}Ngrok adresi terminalde görüntülenecektir.${NC}"
echo -e "${GREEN}==========================================${NC}"
