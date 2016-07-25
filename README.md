[//]: # (           Copyright (c) 2016 ARM Limited. All rights reserved.)

# mbed Access Point

mbed Access Point is a wireless access point that manages 6LoWPAN networks. It is a combination of mbed 6LoWPAN Border Router and the Linux Router. It provides necessary features to integrate a 6LoWPAN network into an IT environment and to cope with existing backhaul networks.   

The architecture described in this document consists of two embedded boards, a mbed 6LoWPAN Border Router and a Linux Router. The motivation behind this two-board design is to achieve mesh agnostic mbed Access Point. With this approach it is possible to build mbed Access Point either based on a [Thread](https://www.threadgroup.org/) or a 6LoWPAN Border Router with no/minimal changes to Linux Router.

The Border (or Edge) Router is an IPv6 router which routes between regular and 6LoWPAN network segments. 6LoWPAN is
designed for highly constrained IP networking, where bandwidth or energy is in short supply. Consequently the Border
Router has some additional functionality to translate between the two domains.

The Linux Router is a Resource-rich device capable of running Linux or Linux-like operating system. It provides features
like VLAN support, Authentication and Authorization Services, Network Management and Logging, Tunneling support,
Firewall and Wireless Mesh Network Management typically expected by IT administrators.

This document provides instructions on how to build a mbed Access Point based on Raspberry Pi 2B and
[mbed 6LoWPAN Border Router](https://github.com/ARMmbed/k64f-border-router).

This repository contains a pre-built mbed Access Point image based on OpenWrt for Raspberry Pi 2B.
Continue reading further if you would like to use pre-built image. However, this is also the build system for the mbed Access Point
based on OpenWrt which allows you to generate image from source with different configurations. The steps to generate an image are
described [here](#generate-mbed-access-point-image-from-source).

## Hardware components
The figure below provides an overview of hardware components of mbed Access Point:

![](images/mbedap-block-diagram-raspberry-pi.jpg)

## Required hardware
1. Raspberry Pi 2B (Linux Router).
1. [mbed 6LoWPAN Border Router HAT](https://developer.mbed.org/components/mbed-6LoWPAN-Border-Router-HAT/).
1. SD card.
1. Serial-to-USB converter – to monitor/communicate with mbed 6LoWPAN Border Router.
1. HDMI cable.
1. Ethernet capable.

![](images/mbedap-raspberry-pi-mbed-border-router.jpg)

## Software components
The software components of mbed Access Point are outlined in the picture below.

![](images/mbedap-software-components.jpg)

We've all the hardware components needed. Let's start building our mbed Access Point.

### Raspberry Pi and OpenWrt
The pre-built image for Raspberry Pi 2B contains the necessary modules and packages to convert Raspberry Pi into an OpenWrt based Linux Router.
A default LAN network prefix is pre-configured in this image which will be used if your backbone network only supports IPv4. This configuration
will create a isolated LAN network based on [ULA](https://tools.ietf.org/html/rfc4193) prefix `fd00:db80::/64` and enables setting up 6LoWPAN
network  without IPv6 support in backbone network. However, packets from mesh network cannot be routed out of mbed Access Point.

1. The link to download the mbed Access Point image is available in the file [mbed-access-point-rpi2-openwrt-image.txt](https://github.com/ARMmbed/mbed-access-point/blob/master/mbed-access-point-rpi2-openwrt-image.txt). You can either use wget or
copy and paste the link in the address bar of a web browser to download it (openwrt-r49388-brcm2708-bcm2709-rpi-2-ext4-sdcard.img).
1. Once download is completed, install the image onto SD card. The [link](https://www.raspberrypi.org/documentation/installation/installing-images/) provides step by step instructions.
1. Insert the SD card into Raspbery Pi SD card slot.
1. Attach the Raspberry Pi HAT onto Raspberry Pi such that it fits firmly on top of GPIO headers.

### Generate mbed Access Point image from source
This repository contains the build system for mbed Access Point which is based on OpenWrt build system. This allows you to build the image from source.

1. Install the build system [prerequisites](https://wiki.openwrt.org/doc/howto/buildroot.exigence).
1. Clone the repository onto a local machine.
1. Run `./scripts/feeds update -a` to get all the latest package definitions defined in `feeds.conf.default` respectively and `./scripts/feeds install -a` to install symlinks of all of them into package/feeds/.
1. Run `make menuconfig` to change the configuration for your image.
1. Run make to build the mbed Access Point image.
```
make or make V=s
```
1. The generated image (openwrt-r49388-brcm2708-bcm2709-rpi-2-ext4-sdcard.img) will be located in the directory ./bin/brcm2708/
1. Install the image onto SD card. The [link](https://www.raspberrypi.org/documentation/installation/installing-images/mac.md) provides step by step instructions.
1. Insert the SD card into Raspbery Pi SD card slot.
1. Attach the Raspberry Pi HAT onto Raspberry Pi such that it fits firmly on top of GPIO headers.

### mbed 6LoWPAN Border Router and mbed OS
1. [mbed 6LoWPAN Border Router HAT](https://developer.mbed.org/components/mbed-6LoWPAN-Border-Router-HAT/) contains a DAPLINK interface which connects to host computer through USB
and provides following interfaces.
	1. HID interface: The driver-less HID interface provides a channel over which the CMSIS-DAP debug protocol runs.
	This enables all the leading industry standard toolchains to program and debug the target system.
	1. USB Disk drag and drop programming: DAPLink debug probes also appear on the host computer as a USB disk. Program
	files in binary (.bin) and hex (.hex) formats can be copied onto the USB disk which then programs them into the
	memory of the target system.
	1. USB Serial Port: The DAPLink debug probe also provides a USB serial port which can be bridged through to a TTL
	UART on the target system. The USB Serial port will appear on a Windows machine as a COM port, or on a Linux machine
	as a /dev/tty interface.
	More information can be found at [DAPLINK](https://developer.mbed.org/handbook/DAPLink).
1. The binary for mbed 6LoWPAN Border Router with default configuration is available [here](https://s3-eu-west-1.amazonaws.com/mbed-6lowpan-border-router-image/k64f-border-router.bin).
1. Instructions to build the binary for mbed 6LoWPAN Border Router is available at
[k64f-border-router](https://github.com/ARMmbed/k64f-border-router).
1. The configuration for mbed 6LoWPAN Border Router is located in the file mbed_app.json in root directory. Use the following configuration:
```javascript
"backhaul-driver": "SLIP"
"slip_hw_flow_control": "true"
```
1. Before building the binary change `#define PIN_SPI_RST D5` to `#define PIN_SPI_RST PTD4` in the file `.\atmel-rf-driver/source/driverAtmelRFInterface.h`.
1. mbed 6LoWPAN Border Router is powered by 3.3v rail available on GPIO headers. Therefore we need to power-up Raspberry Pi to power-up mbed 6LoWPAN Border Router.
1. Power-up Raspberry Pi and program mbed 6LoWPAN Border Router using drag and drop feature provided by DAPLINK.
1. After programming mbed 6LoWPAN Border Router switch-off Raspberry Pi.

### Accessing mbed Access Point through SSH or Web GUI.
1. Connect Ethernet cable, HDMI cable and switch-on Raspberry Pi. The IPv4 address of mbed Access Point will be displayed on screen.  Alternatively, you can start monitoring LLDP traffic on your network using Wireshark. mbed Access Point will send LLDP advertisements which will contain the IP address.
1. Terminal utilities like minicom or putty can be used to monitor the logs from mbed 6LoWPAN Border Router. The default settings for terminal utility are 115200, 8N1.
1. mbed 6LoWPAN Border Router will be held in reset either until LAN interface on RPi is up and have global IPv6 addresses or
for a maximum of 20 seconds.
1. Secure shell `ssh` can be used to access your mbed Access Point remotely.
```
ssh root@<mbed ap ip address>
```
Note: SSH access is enabled on WAN interface. We recommended you to set a strong password for root account or use SSH Public Key authentication. Detailed instructions for latter are available at [Public-Key-Authentication](https://wiki.openwrt.org/oldwiki/dropbearpublickeyauthenticationhowto).

1. LuCI instance running on mbed Access Point can be accessed using url `https://<mbed ap ip address>`.
1. Use root user credentials to login and access mbed Access Point using LuCI interface.

If you have followed all the instructions correctly then you should have a mbed Access Point capable of managing a 6LoWPAN network. Next step is to perform basic test to ensure network connectivity between Linux Router and mbed 6LoWPAN Border Router.

### Backbone network with only IPv4 support
If your backbone network only supports IPv4 then the scope of 6LoWPAN traffic is limited to mbed Access Point as ULA
addresses are not routable in the Internet. However, the mbed 6LoWPAN Border Router and end nodes in network are reachable from mbed Access Point. Let us try to ping the mbed 6LoWPAN Border Router from the Linux Router.

1. Power cycle Raspberry Pi and wait till both Raspberry Pi and mbed 6LoWPAN Border Router are up.
1. Login to Raspberry Pi (Linux Router) using SSH.
```
ssh root@<mbed access point ip address>
```
1. Run `ifconfig` command and ensure that link-local and unique local address are set on LAN (sl0) interface.
```
sl0       Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  
          inet addr:192.168.1.1  P-t-P:192.168.1.1  Mask:255.255.255.0
          inet6 addr: fe80::7077:7805:29b8:6903/64 Scope:Link
          inet6 addr: fd00:db80::1/64 Scope:Global
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:14 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10
          RX bytes:0 (0.0 B)  TX bytes:1888 (1.8 KiB)
```
1. Run `ip -6 route show` and ensure that routing table has an entry to route packets through LAN (sl0) interface.
```
fd00:db80::/64 dev sl0  proto static  metric 1024  pref medium
fe80::/64 dev sl0  proto kernel  metric 256  pref medium
```
1. Connect mbed 6LoWPAN Border Router to your laptop using a USB cable.
1. Start terminal application like putty or minicom to monitor the logs from mbed 6LoWPAN Border Router.
1. mbed 6LoWPAN Border Router will use the Router Advertisements sent by Linux Router to generate IPv6 addresses for both backhaul interface and radio interface. The IPv6 addresses are printed into the logs which can be seen on the terminal application.
```
[DBG ][brro]: Backhaul bootstrap started
[DBG ][brro]: Backhaul bootstrap ready, IPv6 = fd00:db80::2042:adff:fea2:4db9
[DBG ][brro]: Backhaul interface addresses:
[DBG ][brro]:    [0] fe80::2042:adff:fea2:4db9
[DBG ][brro]:    [1] fd00:db80::2042:adff:fea2:4db9
[DBG ][brro]: Using 24GHZ radio, type = 2, channel = 12
[DBG ][brro]: RF bootstrap ready, IPv6 = fd00:db80::ff:fe00:face
[DBG ][brro]: RF interface addresses:
[DBG ][brro]:    [0] fe80::ff:fe00:face
[DBG ][brro]:    [1] fe80::fec2:3d00:3:29f4
[DBG ][brro]:    [2] fd00:db80::ff:fe00:face
```
1. Switch to terminal with SSH connection to Linux Router. Try pinging mbed 6LoWPAN Border Router using ULA address.
```
ping6 fd00:db80::2042:adff:fea2:4db9    // Pinging backhaul interface
ping6 fd00:db80::ff:fe00:face           // Piniging radio interface
```
### Backbone network with IPv6 and DHCP-PD support
If your backbone supports IPv6 and DHCP-PD, then mbed Access Point will request the global prefix from backbone router
and configure the 6LoWPAN network according the prefix received.

### Creating a 6LoWPAN Network
Congratulations!! You have just created a mbed Access Point. It's time to explore the world of 6LoWPAN network. Follow the instructions described in [mbed-os-example-client](https://github.com/ARMmbed/mbed-os-example-client) to setup 6LoWPAN end nodes. The end nodes will send LWM2M registration messages to [mbed device connector](https://connector.mbed.com/). However, if you backbone network doesn't support IPv6 then these messages will not be sent out of mbed Access Point. Although, you should be able to ping all the end nodes from mbed Access Point.
**Note** Please ignore the instructions regarding Border Router as it is part of mbed Access Point.

If you have any questions or would like to start a discussion then please create an issue on [mbed Access Point GitHub repository](https://github.com/ARMmbed/mbed-access-point).

This work is partially supported by the [Horizon 2020 programme](http://ec.europa.eu/programmes/horizon2020/) of the European Union under grant agreement number 644332
