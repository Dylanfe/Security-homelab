# Network Diagram

Below is a sample network diagram for your Cybersecurity Homelab, written in Mermaid syntax. You can customize this diagram to match your actual IP addresses and VM names.

```mermaid
graph TD
    Internet["Internet"]
    NAT["NAT Adapter"]
    pfSense["pfSense VM\nWAN: em0\nLAN: em1\n192.168.1.1"]
    WinServer["Windows Server 2025\n192.168.1.10"]
    Kali["Kali Linux\n192.168.1.20"]
    Meta2["Metasploitable2\n192.168.1.30"]

    Internet --> NAT --> pfSense
    pfSense --> WinServer
    pfSense --> Kali
    pfSense --> Meta2
```

## How to Customize
- Change the IP addresses to match your actual VM assignments.
- Add or remove nodes for any additional VMs (e.g., osTicket, Security Onion).
- Use diagrams.net or the Mermaid Live Editor to visualize and export your diagram.

## How to Use
- Copy the Mermaid code block above into your README or documentation.
- On GitHub, use a Mermaid plugin or screenshot for static display.
- On your website, use a Mermaid renderer for interactive diagrams. 