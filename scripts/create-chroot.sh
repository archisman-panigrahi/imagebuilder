#!/bin/bash

# do not ask anything
export DEBIAN_FRONTEND=noninteractive

export LANG=C

apt-get update
apt-get -yq upgrade
# slick greeter is required as the default one seems to have problems on 32bit systems
# see: https://bluesabre.org/2019/10/20/install-xubuntu-19-10-on-a-raspberry-pi-4/
if [ "$1" = "ubuntu" ]; then 
  apt-get -yq install locales vim openssh-server sudo net-tools ifupdown iputils-ping kmod less rsync u-boot-tools usbutils dosfstools mesa-utils mesa-utils-extra console-data xubuntu-desktop linux-firmware lvm2 cryptsetup-bin slick-greeter rsyslog
elif [ "$1" = "debian" ]; then 
  apt-get -yq install locales vim openssh-server sudo net-tools ifupdown iputils-ping kmod less rsync u-boot-tools usbutils dosfstools mesa-utils mesa-utils-extra console-data task-xfce-desktop xserver-xorg-input-synaptics blueman firmware-linux-free firmware-linux firmware-linux-nonfree firmware-brcm80211 firmware-samsung firmware-libertas pulseaudio pavucontrol lvm2 cryptsetup-bin slick-greeter
fi

systemctl enable ssh
systemctl disable fstrim.timer
# # in case you want to disable automatic updates, just uncomment the next three lines
# #systemctl disable apt-daily
# #systemctl disable apt-daily-upgrade
# #systemctl disable unattended-upgrades.service
# in case you want to enable automatic updates, just comment out the next three lines
systemctl disable apt-daily
systemctl disable apt-daily-upgrade
systemctl disable unattended-upgrades.service

useradd -c ${2} -d /home/${2} -m -p '$6$sEhhlter$njAiCsaYr7lveaAQCmsABlrGbrVip/lcBUlY2M9DUHfaUh0zSLfcJ4mN0BDqH7bg/2BITbp7BK3qPf8zR.3Ad0' -s /bin/bash ${2}
usermod -a -G sudo ${2}
usermod -a -G audio ${2}
usermod -a -G video ${2}
usermod -a -G render ${2}

# setup locale info for en-us
sed -i 's,# en_US ISO-8859-1,en_US ISO-8859-1,g;s,# en_US.UTF-8 UTF-8,en_US.UTF-8 UTF-8,g' /etc/locale.gen
locale-gen

# remove snapd and dmidecode (only on ubuntu) as it crashes on some arm devices on boot
apt-get -yq remove snapd dmidecode

apt-get -yq auto-remove
apt-get clean

# hack to detect m8x via /boot/uEnv.ini to disable lightdm for it
# as it does not yet have a working hdmi output and lighdm would fail
if [ -f /boot/uEnv.ini ]; then
  systemctl disable lightdm
fi
