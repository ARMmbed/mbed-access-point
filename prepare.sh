#!/bin/bash
if [ "$#" -ne 1 ] ; then
        echo "prepare.sh: one argument expected"
        echo "Usage: prepare.sh rpi2|rpi3|ar150"
        echo "       rpi2  - build an image for Raspberry Pi 2B"
        echo "       rpi3  - build an image for Raspberry Pi 3"
        echo "       ar150 - build an image for GL-AR150"
        exit -1
elif [ $1 == "rpi2" ] || [ $1 == "rpi3" ] || [ $1 == "ar150" ] ; then
        :
else
        echo "Unrecognised option: " $1
        echo "Usage: prepare.sh rpi2|rpi3|ar150"
        echo "       rpi2  - build an image for Raspberry Pi 2B"
        echo "       rpi3  - build an image for Raspberry Pi 3"
        echo "       ar150 - build an image for GL-AR150"
        exit -1
fi

echo "***** Updating feeds *****"
./scripts/feeds update -a
echo "***** Installing feeds *****"
./scripts/feeds install -a
echo "***** Applying custom kernel configuration *****"
if [ $1 == "rpi2" ] ; then
        cp target/linux/brcm2708/bcm2709/openwrt_config .config
        cp target/linux/brcm2708/bcm2709/mcproxy feeds/routing/mcproxy/files/mcproxy.config
elif [ $1 == "rpi3" ] ; then
        echo "dtoverlay=pi3-miniuart-bt" >> ./target/linux/brcm2708/image/config.txt
        cp target/linux/brcm2708/bcm2710/openwrt_config .config
        cp target/linux/brcm2708/bcm2710/mcproxy feeds/routing/mcproxy/files/mcproxy.config
elif [ $1 == "ar150" ] ; then
        cp target/linux/ar71xx/gl-ar150/openwrt_config .config
        cp target/linux/ar71xx/gl-ar150/mcproxy feeds/routing/mcproxy/files/mcproxy.config
fi
echo "***** Expanding kernel configuration *****"
make defconfig
echo "You can now run 'make' to build the image"


