#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: diagnostic.sh {system|disk|network|help}"
  exit 1
fi

case "$1" in
  system)
    echo "=== System Info ==="
    echo "Uptime: $(uptime)"
    echo "CPU cores: $(nproc)"
    echo "Memory:"
    free -h
    exit 0
    ;;
  disk)
    echo "=== Disk Usage ==="
    df -h
    exit 0
    ;;
  network)
    if [ -z "$2" ]; then
      echo "Error: network command requires a host"
      exit 2
    fi
    echo "=== Network Check: $2 ==="
    ping -c 2 "$2"
    nslookup "$2"
    exit 0
    ;;
  help)
    echo "Usage: diagnostic <command> [args]"
    echo "Commands:"
    echo " system Display system information"
    echo " disk Display disk information"
    echo " network <host> Check network connectivity to host"
    echo " help Show this help"
    exit 0
    ;;
  *)
    echo "Error: Unknown command '$1'"
    echo "Usage: diagnostic.sh {system|disk|network|help}"
    exit 1
    ;;
esac
