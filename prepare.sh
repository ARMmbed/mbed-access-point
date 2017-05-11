#!/bin/sh
echo "***** Updating feeds *****"
./scripts/feeds update -a
echo "***** Installing feeds *****"
./scripts/feeds install -a
echo "***** Applying custom kernel configuration *****"
cp diffconfig .config
echo "***** Expanding kernel configuration *****"
make defconfig
echo "You can now run 'make' to build the image"


