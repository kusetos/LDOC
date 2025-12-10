# Ubuntu Journal Audit Ansible

This repository contains an Ansible playbook to configure journald auditing and helper tools on Ubuntu systems.

Structure

- `ansible.cfg` - Ansible configuration (inventory, user, etc.)
- `inventory.yml` - Example inventory for journal hosts
- `playbook.yml` - Main playbook that applies the roles
- `roles/` - Roles applied by the playbook
  - `journal_config` - Configures `journald` (persistent storage, limits)
  - `journal_tools` - Installs helper tools and deploys scripts
  - `audit_rules` - Deploys `auditd` rules via a Jinja2 template
- `files/` - Helper scripts shipped to managed hosts
- `templates/` - Jinja2 templates for audit rules

Usage

1. Update `inventory.yml` with your hosts.
2. Run the playbook:

```bash
ansible-playbook -i inventory.yml playbook.yml
```

Customization

- Adjust `templates/99-security-audit.rules.j2` to change audit rules.
- Edit scripts in `files/` to modify monitoring behaviour.
