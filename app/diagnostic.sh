#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: diagnostic <command> [args]"
  echo "Commands:"
  echo " system Display system information"
  echo " network <host> Check network connectivity to host"
  echo " disk Display disk information"
  echo " help Show this help"
  exit 2
}

cmd="${1:-}"

case "$cmd" in
  system)
    echo "=== System Info ==="
    echo "Hostname: $(hostname)"
    echo "User: $(whoami)"
    echo "Date: $(date)"
    echo "OS: $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '\"')"
    echo "Kernel: $(uname -r)"
    echo "Uptime: $(uptime -p)"
    echo "CPU: $(lscpu | grep 'Model name' | cut -d: -f2 | xargs)"
    echo "Memory: $(free -h | grep Mem | awk '{print $3"/"$2}')"
    echo "CWD: $(pwd)"
    exit 0
    ;;
  network)
    host="${2:-}"
    if [[ -z "$host" ]]; then
      echo "Error: host required"
      exit 2
    fi
    echo "=== Network Check: $host ==="
    getent hosts "$host" && echo "Resolved" || { echo "Failed to resolve"; exit 1; }
    ping -c 2 "$host" >/dev/null && echo "Host is reachable" || { echo "Host unreachable"; exit 1; }
    exit 0
    ;;
  disk)
    echo "=== Disk Usage ==="
    df -h /
    exit 0
    ;;
  help|--help|-h)
    usage
    ;;
  *)
    echo "Error: Invalid command '$cmd'"
    usage
    ;;
esac
