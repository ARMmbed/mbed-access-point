ARCH:=x86_64
BOARDNAME:=x86_64
DEFAULT_PACKAGES += kmod-button-hotplug kmod-e1000e kmod-e1000 kmod-r8169 kmod-igb
ARCH_PACKAGES:=x86_64
MAINTAINER:=Imre Kaloz <kaloz@openwrt.org>

define Target/Description
        Build images for 64 bit systems including virtualized guests.
endef
