#!/bin/bash
echo "--- Updating system ---"
sudo apt update && sudo apt upgrade -y

echo "--- Installing base tools ---"
sudo apt install -y curl git wget htop build-essential ufw fail2ban openssh-server net-tools iftop postgresql postgresql-client redis-server python3 python3-pip
echo "--- Installing Rust ---"
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env

echo "--- Installing Python libs ---"
pip install requests psycopg2 redis pytest

