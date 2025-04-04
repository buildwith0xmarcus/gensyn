#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}==========================================${NC}"
echo -e "${BLUE}        Gensyn Kurulum Başlatılıyor        ${NC}"
echo -e "${BLUE}==========================================${NC}"

echo -e "${YELLOW}[1/8] net-tools kurulumu yapılıyor...${NC}"
sudo apt-get update && sudo apt-get upgrade -y
sudo apt install net-tools -y

echo -e "${YELLOW}[2/8] Temel paketler kuruluyor...${NC}"
sudo apt install screen curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip -y

echo -e "${YELLOW}[3/8] Python ve gerekli paketler kuruluyor...${NC}"
sudo apt install python3 python3-pip python3.10-venv -y

echo -e "${YELLOW}[4/8] Node.js kurulumu yapılıyor...${NC}"
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g yarn

echo -e "${YELLOW}[5/8] rl-swarm projesi klonlanıyor...${NC}"
git clone https://github.com/gensyn-ai/rl-swarm/
cd rl-swarm

echo -e "${YELLOW}[6/8] Python sanal ortamı oluşturuluyor...${NC}"
python3 -m venv .venv
source .venv/bin/activate

echo -e "${YELLOW}[7/8] rl-swarm başlatılıyor...${NC}"
echo "Y" | ./run_rl_swarm.sh

IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
echo -e "${GREEN}==========================================${NC}"
echo -e "${GREEN}        Kurulum Başarıyla Tamamlandı!     ${NC}"
echo -e "${GREEN}==========================================${NC}"
echo -e "${YELLOW}Tarayıcınızda aşağıdaki adresi açın:${NC}"
echo -e "${BLUE}http://${IP}:3000${NC}"
echo -e "${GREEN}==========================================${NC}"