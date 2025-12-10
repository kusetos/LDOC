sudo apt install -y ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH (port 22)
sudo ufw allow 22/tcp

# Allow PostgreSQL (optional, local or remote)
sudo ufw allow 5432/tcp

# Allow Redis (optional)
sudo ufw allow 6379/tcp

# Allow your API server or matching engine port
sudo ufw allow 8080/tcp

# Enable firewall
sudo ufw enable

# Check status
sudo ufw status verbose
