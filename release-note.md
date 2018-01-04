# Release Notes

## mbedap-v4.0.1 - 04 Jan 2018

With this patch release, we are swithcing to public version of OpenWrt LuCI instead of private version of LuCI.

## mbedap-v4.0.0 - 06 Sept 2017

This release adds support for two new hardware platforms. Also, the random routing issue has been fixed.
Following hardwares are supported:

* Raspberry Pi 2B
* Raspberry Pi 3
* GL-AR150

## mbedap-v3.0.0 - 26 July 2017

This release merges the previous releases to support the Thread and the 6LoWPAN networks. In addition, this release adds mDNS and DNS-SD support to Nanostack to enable the Thread commissioning using the Thread mobile commissioner. Also, this release introduces the Neighbor Discovery Proxy (NDP) support for SLIP interface. This enables the creation of the Thread network even when only the `/64` prefix is available on the WAN side.

This release also includes the following improvements:
* Syslog support to remotely record and monitor the debug logs.
* Forwarding multicast traffic between Thread and backbone networks.

**Known Issues:**  
The kernel routing table of the mbed access point gets corrupted, if the up-link of the upstream router is lost/disconnected. This will result in traffic towards the Ethernet interface to be forwarded to the SLIP interface.  
**Possible Solution:**  
At this point, the only possible solution is to **reboot** the mbed access point which will fix this.  

## mbedap-v2.0.0 - 4 Nov 2016

This release introduces the support for the Thread network. In addition, this release adds the firewall rules to rate-limit the traffic toward the Thread network. It also adds support for hot-plugging of the mbed 6LoWPAN Border Router HAT.

## mbedap-v1.0.0 - 27 July 2016

This is the first release of the mbed access point designed for 6LoWPAN networks. It supports Raspberry Pi 2B and mbed 6LoWPAN Border Router HAT hardware.
