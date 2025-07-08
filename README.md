# Cybersecurity Homelab: Enterprise Security & SOC Practice Lab

## Overview

**Project Goal:**  
Design and deploy a virtual enterprise network environment to gain hands-on experience in Windows Server administration, Active Directory security, network defense, and incident response simulation. This lab is a practical sandbox for testing security controls and analyzing attack vectors in a controlled setting.

---

## Table of Contents

1. [Lab Architecture & Diagram](#lab-architecture--diagram)
2. [Technologies Used](#technologies-used)
3. [Setup Instructions](#setup-instructions)
    - [Host Machine Requirements](#host-machine-requirements)
    - [VirtualBox Installation](#virtualbox-installation)
    - [ISO/VM Image Downloads](#iso-vm-image-downloads)
4. [VM Configuration & Setup](#vm-configuration--setup)
    - [pfSense (Firewall/Router)](#pfsense-firewallrouter)
    - [Windows Server 2025 (Active Directory)](#windows-server-2025-active-directory)
    - [Kali Linux (Attacker/SOC Analyst)](#kali-linux-attackersoc-analyst)
    - [Metasploitable2 (Vulnerable Target)](#metasploitable2-vulnerable-target)
5. [Network Configuration](#network-configuration)
6. [Practical Scenarios & Exercises](#practical-scenarios--exercises)
7. [Advanced Additions](#advanced-additions)
8. [Troubleshooting & Lessons Learned](#troubleshooting--lessons-learned)
9. [Showcasing Your Lab](#showcasing-your-lab)
10. [References & Further Reading](#references--further-reading)

---

## Lab Architecture & Diagram

**Network Topology:**

- All VMs are connected via an "Internal Network" in VirtualBox, isolated from your real network.
- pfSense acts as the gateway/firewall, with two network adapters:
    - Adapter 1: NAT (WAN, connects to the internet via your host)
    - Adapter 2: Internal Network (LAN, connects to your lab VMs)
- Windows Server, Kali Linux, and Metasploitable2 connect to the Internal Network.

**Diagram:**

```
[Internet]
    |
[NAT Adapter]
    |
[pfSense VM]
  | (LAN: 192.168.1.1)
  +-------------------+-------------------+
  |                   |                   |
[Windows Server]   [Kali Linux]   [Metasploitable2]
(192.168.1.10)     (192.168.1.20) (192.168.1.30)
```

**Tip:**  
Include IP addresses, interface names (em0 = WAN, em1 = LAN), and VM names in your diagram.

---

## Technologies Used

- **Virtualization:** Oracle VirtualBox
- **Firewall/Router:** pfSense Community Edition
- **Directory Services:** Windows Server 2025 (Active Directory, DNS, Group Policy)
- **Attacker/SOC Analyst:** Kali Linux (with Nmap, Metasploit, Greenbone, etc.)
- **Vulnerable Target:** Metasploitable2
- **SIEM:** Wazuh (optional, for advanced monitoring)
- **IDS/IPS:** Suricata (on pfSense)
- **IT Support:** osTicket (optional, for ticketing practice)

---

## Setup Instructions

### Host Machine Requirements

- **CPU:** Modern multi-core (Intel i5/i7 or AMD Ryzen 5/7) with virtualization enabled (VT-x/AMD-V)
- **RAM:** 16GB minimum (32GB ideal)
- **Storage:** SSD with at least 200GB free
- **OS:** Windows, macOS, or Linux

### VirtualBox Installation

1. Download from [virtualbox.org](https://www.virtualbox.org/)
2. Install with default settings.

### ISO/VM Image Downloads

- **pfSense:** [pfSense Download](https://www.pfsense.org/download/)
    - Architecture: AMD64
    - Installer: DVD Image (ISO) Installer
    - Extract the `.iso` from the `.gz` file using 7-Zip.
- **Windows Server 2025 (GUI version not CLI):** [Microsoft Evaluation Center](https://www.microsoft.com/en-us/evalcenter/)
    - Download the 180-day evaluation ISO.
- **Kali Linux:** [Kali Linux Downloads](https://www.kali.org/get-kali/)
    - Use the pre-built `.ova` for VirtualBox for easiest setup.
- **Metasploitable2:** [Rapid7 Download](https://docs.rapid7.com/metasploit/metasploitable-2/)
    - Download and extract the `.vmdk` file.

---

## VM Configuration & Setup

### pfSense (Firewall/Router)

1. **Create VM:**
    - Name: pfSense
    - Type: BSD, Version: FreeBSD (64-bit)
    - RAM: 1GB
    - Disk: 8GB, VDI, dynamically allocated
2. **Network:**
    - Adapter 1: NAT (WAN)
    - Adapter 2: Internal Network (Name: homelab)
3. **Install:**
    - Boot from pfSense ISO
    - Follow installer prompts (accept defaults)
    - Set em0 as WAN, em1 as LAN
    - After install, remove ISO from virtual drive
    - Note LAN IP (e.g., 192.168.1.1)

### Windows Server 2025 (Active Directory)

1. **Create VM:**
    - Name: WinServer2025-DC
    - Type: Windows 2022 (64-bit)
    - RAM: 4-5GB
    - Cores: 2-4
    - Disk: 50GB, VDI, dynamically allocated
2. **Network:**
    - Adapter 1: Internal Network (homelab)
3. **Install:**
    - Boot from Windows Server ISO
    - Choose "Standard Evaluation (Desktop Experience)"
    - Set admin password (use Tab to move fields)
    - Install VirtualBox Guest Additions for full-screen/resolution
4. **Active Directory:**
    - Open Server Manager > Add Roles and Features
    - Add "Active Directory Domain Services"
    - Promote to Domain Controller (new forest: `cyberlab.local`)
    - Set DSRM password

### Kali Linux (Attacker/SOC Analyst)

1. **Import OVA:**
    - File > Import Appliance > Select Kali `.ova`
2. **Network:**
    - Adapter 1: Internal Network (homelab)
3. **First Boot:**
    - Set hostname: `kali`
    - Domain: `cyberlab.local`
    - Install VirtualBox Guest Additions for full-screen/resolution
    - Set RAM to 4GB, Cores to 2, Enable 3D Acceleration

### Metasploitable2 (Vulnerable Target)

1. **Create VM:**
    - Name: Metasploitable2
    - Type: Linux, Ubuntu (64-bit)
    - RAM: 1GB
    - Disk: Use existing `.vmdk` file
2. **Network:**
    - Adapter 1: Internal Network (homelab)
3. **First Boot:**
    - Login: `msfadmin` / `msfadmin`
    - Note IP address (`ifconfig`)

---

## Network Configuration

- All VMs (except pfSense) use Adapter 1: Internal Network (homelab)
- pfSense:
    - Adapter 1: NAT (WAN)
    - Adapter 2: Internal Network (homelab, LAN)
- pfSense provides DHCP and internet access to the internal network

---

## Practical Scenarios & Exercises

### 1. Active Directory Management

- Create OUs for departments (Sales, IT, etc.)
- Add users and groups with weak/strong passwords
- Set up Group Policy for password policies and mapped drives
- Share a folder and set permissions for different groups

### 2. Vulnerability Scanning

- On Kali, install Greenbone Vulnerability Manager:
    ```bash
    sudo apt update
    sudo apt install -y gvm
    sudo gvm-setup
    sudo gvm-start
    ```
- Scan Windows Server and Metasploitable2 for vulnerabilities

### 3. Penetration Testing

- Use Nmap to scan Windows Server and Metasploitable2
- Use Metasploit to exploit known vulnerabilities (e.g., vsftpd 2.3.4 on Metasploitable2)
- Use enum4linux-ng and crackmapexec for Active Directory enumeration and password spraying

### 4. Security Monitoring

- Install Wazuh agent on Windows Server, manager on Kali
- Install Suricata on pfSense, enable ET Open rules
- Generate alerts by scanning from Kali and review in Wazuh and Suricata dashboards

### 5. Firewall & IDS/IPS

- Create firewall rules in pfSense to block/allow traffic
- Review Suricata alerts for port scans and attacks

---

## Advanced Additions

- Add osTicket on a new Ubuntu VM for IT support ticketing
- Add Security Onion for advanced SOC monitoring
- Add more vulnerable VMs (e.g., OWASP Juice Shop, old Windows versions)
- Practice patching and hardening after finding vulnerabilities

---

## Troubleshooting & Lessons Learned

- **pfSense ISO extraction:** Use 7-Zip to avoid symlink errors
- **Windows Server black screen:** Increase video memory to 128MB, set graphics to VBoxSVGA
- **Kali performance:** Use 2 cores, 4GB RAM, enable 3D acceleration
- **No internet on Kali:** Restart pfSense, check network settings
- **Ctrl+Alt+Del in VM:** Use Right Ctrl+Delete or VirtualBox menu
- **Full-screen issues:** Install Guest Additions and set display settings

---

## References & Further Reading

- [VirtualBox Documentation](https://www.virtualbox.org/manual/)
- [pfSense Documentation](https://docs.netgate.com/pfsense/en/latest/)
- [Microsoft Windows Server Docs](https://learn.microsoft.com/en-us/windows-server/)
- [Kali Linux Documentation](https://www.kali.org/docs/)
- [Metasploitable2 Guide](https://docs.rapid7.com/metasploit/metasploitable-2/)
- [Wazuh Documentation](https://documentation.wazuh.com/)
- [Suricata Documentation](https://suricata.io/docs/)

---

## Screenshots & Diagram

*Add screenshots of your actual setup, dashboards, and scans here!* 