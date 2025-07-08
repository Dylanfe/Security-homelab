# Incident Management Process in the Cybersecurity Homelab

This guide explains how to handle security incidents in your homelab, following a professional incident response lifecycle. It includes practical steps and examples using your lab tools (pfSense, Suricata, Wazuh, Windows Server, Kali Linux).

---

## Table of Contents
- [1. Preparation](#1-preparation)
- [2. Detection & Identification](#2-detection--identification)
- [3. Investigation](#3-investigation)
- [4. Containment](#4-containment)
- [5. Eradication](#5-eradication)
- [6. Recovery](#6-recovery)
- [7. Lessons Learned](#7-lessons-learned)
- [Example Scenario](#example-scenario)

---

## 1. Preparation
- Ensure all logging and alerting is enabled (Suricata, Wazuh, Windows Event Viewer).
- Know your network layout and assets (see your network diagram).
- Have a plan for responding to common attacks (port scans, brute force, malware).

## 2. Detection & Identification
- Monitor Suricata and Wazuh dashboards for alerts.
- Example: Suricata triggers an alert for a port scan from Kali Linux.
- Identify the source (attacker IP) and target (victim IP/service).

## 3. Investigation
- Gather evidence:
  - Review Suricata/Wazuh alert details.
  - Check Windows Event Viewer for related logs.
  - Use `nmap` or other tools to verify open ports/services.
- Determine the scope: Is it a single event or ongoing?

## 4. Containment
- Limit the attacker's access:
  - Use pfSense to block the attacker's IP or port.
  - Disable affected user accounts or services on Windows Server.
- Example: Add a firewall rule in pfSense to block further scans from Kali.

## 5. Eradication
- Remove the root cause:
  - Patch vulnerable services (e.g., update vsftpd, Samba).
  - Remove malware or unauthorized accounts.
- Example: Update or disable the vulnerable service on Metasploitable2.

## 6. Recovery
- Restore normal operations:
  - Re-enable services/users after confirming the threat is gone.
  - Monitor for signs of reinfection or further attacks.
- Example: Remove the firewall block after confirming the attacker is gone and the service is patched.

## 7. Lessons Learned
- Document what happened, how you responded, and what could be improved.
- Update your incident response plan and security controls.
- Example: Add new Suricata rules or improve logging based on the incident.

---

## Example Scenario: Detecting and Responding to a Port Scan

1. **Detection:** Suricata dashboard shows a port scan alert from Kali (192.168.1.20) targeting Windows Server (192.168.1.10).
2. **Investigation:** Review alert details, check Windows Event Viewer for unusual logon attempts.
3. **Containment:** In pfSense, add a firewall rule to block all traffic from 192.168.1.20 to 192.168.1.10.
4. **Eradication:** Patch any vulnerable services found open during the scan.
5. **Recovery:** Remove the block after patching and monitor for further activity.
6. **Lessons Learned:** Document the incident, update detection rules, and consider stronger segmentation or alerting.

---

**For educational use only. This process models real-world incident response and is a valuable skill for IT and security roles.**