sudo apt-get update && sudo apt-get upgrade -y
sudo apt install screen curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip -y
sudo apt install python3 python3-pip python3.10-venv -y
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g yarn
git clone https://github.com/gensyn-ai/rl-swarm/
cd rl-swarm
python3 -m venv .venv
source .venv/bin/activate
./run_rl_swarm.sh