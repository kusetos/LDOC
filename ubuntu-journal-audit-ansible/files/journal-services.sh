#!/bin/bash
# Show unit status and recent logs for a service
if [ -z "$1" ]; then
  echo "Usage: $0 <service-name>"
  exit 1
fi
systemctl status "$1" --no-pager
journalctl -u "$1" -n 200 --no-pager
