#!/bin/bash
echo "--- Checking Rust ---"
cargo --version || { echo "Rust missing!"; exit 1; }

echo "--- Checking PostgreSQL ---"
pg_isready || { echo  "Postgres not responding!"; exit 1; }

echo "--- Checking Redis ---"
redis-cli ping || { echo "Redis not responding!"; exit 1; }

echo "--- Checking Python ---"
python3 --version || { echo "Python missing!"; exit 1; }
pip show requests || { echo "Python packages missing!"; exit 1; }

echo "--- Checking firewall ---"
sudo ufw status verbose
