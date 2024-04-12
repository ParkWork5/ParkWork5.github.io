---
layout: post
title:  "Guest Machine Networking with CAPEV2"
date:   2024-04-11 
categories: jekyll update
---

After some more experimenting and a few days of work I found a solution for capturing network traffic from the CAPE guest machine. It is essentially connecting the two computers together again and providing internet using the router. Below is also an updated network diagram.

1. Connect the guest machine again to the managed switch on port X with a new NIC.
3. Setup a VLAN for port X, Y, and Z to isolate the traffic.
4. Enable port mirroring on port X and have that traffic mirrored to port Z.
5. Connect port Z to the CAPE host with another NIC.
6. Edit the Auxiliary conf to have tcpdump point to the new NIC on the host machine.

![Home Lab]("/assets/images/HomeLabSetupV2.jpg")

|Color|VLAN|Description|
|-----|----|-----------|
|Blue  | 1  | CAPE data |
|Red   | 2  |Internet connection|

# Things to note

1. Ensure the dhcp service on your routers LAN is turned off. It confuses the Fog agent on the guest machine and does not allow it to PXE boot.

2. I used isc-dhcp as my DHCP server and it binds to all interfaces(based on the one form post I saw about it). The Fog agent is smart enough to use the correct interface and does not get confused.

[My dhcpd.conf]("/assets/configs/dhcpd.conf") 

[My isc-dhcp-server]("/assets/configs/isc-dhcp-server")

3. Below are an updated list of firewall rules that work and have been tested with a full analysis on CAPE. I used Gufw for creating the rules on Ubuntu with ufw. 

[uwf rules]("/assets/configs/WorkingFOGRules.profile")

Finally I can get started on analyzing malware and it only took ~30 hours of work and a few month break to get CAPE working correctly.

