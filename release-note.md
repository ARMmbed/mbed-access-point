# Release Notes

## mbedap-v3.0.0 - xx July 2017

This release merges the previous releases to support the Thread and the 6LoWPAN networks. In addition, this release adds mDNS and DNS-SD support to Nanostack to enable the Thread commissioning using the Thread mobile commissioner. Also, this release introduces the Neighbor Discovery Proxy (NDP) support for SLIP interface. This enables the creation of the Thread network even when only the `/64` prefix is available on the WAN side.

1. Syslog support to remotely record and monitor the debug logs.
1. Forwarding multicast traffic between Thread and backbone networks.
1. Neighbor discovery proxy support for SLIP interface.
1. Support for Thread mobile commissioner application to commission a Thread network.

## mbedap-v2.0.0 - 4 Nov 2016

This release introduces the support for the Thread network. In addition, this release adds the firewall rules to rate-limit the traffic toward the Thread network. It also adds support for hot-plugging of the mbed 6LoWPAN Border Router HAT.

## mbedap-v1.0.0 - 27 July 2016

This is the first release of the mbed access point designed for 6LoWPAN networks. It supports Raspberry Pi 2B and mbed 6LoWPAN Border Router HAT hardware.
