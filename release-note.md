# Release Notes

## mbedap-v3.0.0 - xx July 2017

This release merges the previous releases to support either the Thread or the 6LoWPAN network. In addition, mDNS and DNS-SD support is added to Nanostack to enable the Thread commissioning using the Thread mobile commissioner.  Also, the Neighbor Discovery Proxy (NDP) support for SLIP interface has been introduced which enables the creation of the Thread network even when only /64 prefix is available on the WAN side.

1. Syslog support to remotely record and monitor the debug logs.
1. Forwarding multicast traffic between Thread and backbone networks.
1. Neighbor discovery proxy support for SLIP interface.
1. Support for Thread mobile commissioner application to commission a Thread network.

## mbedap-v2.0.0 - 4 Nov 2016
The support for the Thread network is introduced with this release. In addition, the firewall rules to rate-limit the traffic towards the Thread network has been added. Also, support for hot-plugging of the mbed 6LoWPAN Border Router HAT is added.

## mbedap-v1.0.0 - 27 July 2016
The first release of mbed access point designed for 6LoWPAN networks. It supports Raspberry Pi 2B and mbed 6LoWPAN Border Router HAT hardware.
