#!/bin/bash

# Get subnet
echo "[*] Determining subnet..."
subnet=$(ip route | grep -m 1 'src' | awk '{print $1}')
echo "[*] Subnet identified: $subnet"

# Scan for live hosts
echo "[*] Scanning subnet for live hosts..."
nmap -sn $subnet -oG live_hosts.txt > /dev/null
echo "\nDiscovered live hosts:"
grep Up live_hosts.txt | awk '{print NR-1, $2}' > hosts_list.txt
cat hosts_list.txt

# Select target
echo "\nEnter the index of the target to scan: "
read index
target_ip=$(awk -v idx="$index" '$1 == idx {print $2}' hosts_list.txt)
echo "[*] Selected target IP: $target_ip"

# Select scan type
echo "\nSelect scan type:"
echo "1) Quick (top 1000 ports)"
echo "2) Full (all TCP ports)"
echo "3) Service/version detection"
echo "4) Vulnerability scan (safe scripts)"
read -p "Enter choice [1-4]: " scan_choice

DATE=$(date +%Y%m%d-%H%M%S)
OUTPUT="nmap_${target_ip}_${DATE}.txt"

case $scan_choice in
  1)
    echo "[*] Running quick scan on $target_ip..."
    nmap -T4 -F $target_ip -oN $OUTPUT
    ;;
  2)
    echo "[*] Running full TCP port scan on $target_ip..."
    nmap -T4 -p- $target_ip -oN $OUTPUT
    ;;
  3)
    echo "[*] Running service/version detection on $target_ip..."
    nmap -sV $target_ip -oN $OUTPUT
    ;;
  4)
    echo "[*] Running vulnerability scan (safe scripts) on $target_ip..."
    nmap --script vuln $target_ip -oN $OUTPUT
    ;;
  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
esac

echo "\n[*] Scan complete. Results saved to $OUTPUT"