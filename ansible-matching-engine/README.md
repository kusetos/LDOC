# Automated Deployment of Matching Engine Using Ansible

## Includes:
- Docker installation
- Systemd service setup for kusetos/matching-engine
- Cron scripts (health check + log backup)
- User and group creation
- Fully automated playbook

## Usage

Create inventory:

inventory.ini

Run playbook:

ansible-playbook -i inventory.ini playbook.yml --ask-become-pass
