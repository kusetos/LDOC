set -e

GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}--- STEP 1: Installing dependencies ---${NC}"
sudo apt update -y
sudo apt install -y openssh-server sudo vim git

sudo systemctl enable ssh
sudo systemctl start ssh

echo -e "${GREEN}--- STEP 2: Creating groups ---${NC}"
for group in admin user developer automation_bot engine database_admin; do
    if ! getent group $group >/dev/null; then
        sudo groupadd $group
        echo "Group $group created."
    else
        echo "Group $group already exists."
    fi
done

echo -e "${GREEN}--- STEP 3: Creating users ---${NC}"

declare -A users=(
    ["admin_user"]="admin"
    ["regular_user"]="user"
    ["dev_user"]="developer"
    ["automation_bot"]="automation_bot"
    ["engine_user"]="engine"
    ["db_admin_user"]="database_admin"
)

for user in "${!users[@]}"; do
    group=${users[$user]}
    if id "$user" &>/dev/null; then
        echo "User $user already exists."
    else
        if [[ "$user" == "automation_bot" || "$user" == "engine_user" ]]; then
            sudo useradd -r -s /usr/sbin/nologin -g "$group" "$user"
            echo "System user $user created with group $group."
        else
            sudo useradd -m -s /bin/bash -g "$group" "$user"
            echo "$user:password" | sudo chpasswd
            echo "User $user created with group $group."
        fi
    fi
done


echo -e "${GREEN}--- STEP 4: Setting up sudo permissions ---${NC}"

echo "%admin ALL=(ALL) ALL" | sudo tee /etc/sudoers.d/admin > /dev/null

echo "%developer ALL=(ALL) NOPASSWD: /bin/systemctl restart myapp.service, /bin/systemctl restart engine.service" \
    | sudo tee /etc/sudoers.d/developer > /dev/null

sudo chmod 440 /etc/sudoers.d/*

echo -e "${GREEN}--- STEP 5: Setting up SSH keys for dev_user ---${NC}"

if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
    echo "Generating SSH key..."
    ssh-keygen -t rsa -b 4096 -N "" -f "$HOME/.ssh/id_rsa"
fi

sudo -u dev_user mkdir -p /home/dev_user/.ssh
cat "$HOME/.ssh/id_rsa.pub" | sudo tee -a /home/dev_user/.ssh/authorized_keys > /dev/null
sudo chmod 700 /home/dev_user/.ssh
sudo chmod 600 /home/dev_user/.ssh/authorized_keys
sudo chown -R dev_user:developer /home/dev_user/.ssh

echo "SSH key installed for dev_user."

echo -e "${GREEN}--- STEP 6: Verifying SSH service ---${NC}"
sudo systemctl status ssh --no-pager

echo -e "${GREEN}✅ Setup completed successfully!${NC}"
echo -e "You can now SSH into this system using:\n"
echo -e "   ssh dev_user@$(hostname -I | awk '{print $1}')"
