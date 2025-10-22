#!/bin/bash
echo "--- Checking Rust ---"
cargo --version || echo "Rust missing!"

echo "--- Checking PostgreSQL ---"
pg_isready || echo "Postgres not responding!"

echo "--- Checking Redis ---"
redis-cli ping || echo "Redis not responding!"

echo "--- Checking Python ---"
python3 --version || echo "Python missing!"
pip show requests || echo "Python packages missing!"

echo "--- Checking firewall ---"
sudo ufw status verbose
