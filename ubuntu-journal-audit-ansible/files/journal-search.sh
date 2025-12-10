#!/bin/bash
# Simple wrapper to search journal logs with time range and unit
# Usage: journal-search.sh --unit sshd --since "1 hour ago"
args=("$@")
/usr/bin/journalctl "${args[@]}"
