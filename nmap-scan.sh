#!/bin/bash

# nmap-scan.sh
# Simple script to automate Nmap port scanning

if [ $# -lt 1 ]; then
  echo "Usage: $0 <target_ip> [scan_type]"
  echo "Scan types:"
  echo "  quick   - Fast scan of top 1000 ports (default)"
  echo "  full    - Full TCP port scan (1-65535)"
  echo "  service - Service/version detection on open ports"
  echo "  vuln    - Vulnerability scan (safe scripts)"
  exit 1
fi

TARGET=$1
SCAN_TYPE=${2:-quick}
DATE=$(date +%Y%m%d-%H%M%S)
OUTPUT="nmap_${TARGET}_${SCAN_TYPE}_${DATE}.txt"

case $SCAN_TYPE in
  quick)
    echo "[+] Running quick scan on $TARGET..."
    nmap -T4 -F $TARGET -oN $OUTPUT
    ;;
  full)
    echo "[+] Running full TCP port scan on $TARGET..."
    nmap -T4 -p- $TARGET -oN $OUTPUT
    ;;
  service)
    echo "[+] Running service/version detection on $TARGET..."
    nmap -sV $TARGET -oN $OUTPUT
    ;;
  vuln)
    echo "[+] Running vulnerability scan (safe scripts) on $TARGET..."
    nmap --script vuln $TARGET -oN $OUTPUT
    ;;
  *)
    echo "Unknown scan type: $SCAN_TYPE"
    exit 2
    ;;
esac

echo "[+] Scan complete. Results saved to $OUTPUT" 