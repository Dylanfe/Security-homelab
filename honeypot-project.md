# Honeypot Project (In Development)

This document outlines the design and goals for a honeypot project being developed as part of the Cybersecurity Homelab. The honeypot will be used to attract, detect, and analyze unauthorized or malicious activity within the lab environment.

---

## Overview
A honeypot is a decoy system or service designed to lure attackers and study their behavior. By deploying a honeypot in the homelab, you can safely observe attack techniques, collect threat intelligence, and practice incident response in a controlled setting.

---

## Goals
- Simulate vulnerable services to attract attackers (e.g., SSH, HTTP, SMB)
- Log and analyze attack attempts and techniques
- Integrate with existing monitoring tools (e.g., Wazuh, Suricata)
- Provide hands-on experience with threat detection and response

---

## Planned Features
- Deploy an open-source honeypot platform (e.g., Cowrie for SSH, Dionaea for malware collection, or Honeyd for network emulation)
- Centralized logging of all honeypot activity
- Alerting and integration with SIEM/SOC tools in the lab
- Automated analysis of captured payloads and attack patterns
- Documentation of real attack scenarios and lessons learned

---

## Current Status
- Researching and evaluating honeypot platforms (Cowrie, Dionaea, Honeyd, etc.)
- Planning network placement and integration with pfSense and monitoring tools
- Initial test deployment in a dedicated VM is in progress

---

## Next Steps
- Finalize choice of honeypot software and deploy on a new VM
- Configure logging and alerting to Wazuh/Suricata
- Simulate attacks from Kali Linux to test detection and response
- Document setup process, findings, and lessons learned

---

**Note:** This project is a work in progress. Updates and detailed documentation will be added as development continues. 