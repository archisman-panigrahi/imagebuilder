if [ "$1" = "chromebook_nyan" ]; then
  rm -f ${DOWNLOAD_DIR}/kernel-chromebook_nyan-armv7l.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-tegra-k1-kernel/releases/download/${chromebook_nyan_release_version}/${chromebook_nyan_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_nyan-armv7l.tar.gz
  rm -f ${DOWNLOAD_DIR}/boot-chromebook_nyan-armv7l.dd
  # we assemble the bootblocks from a prepared chromebook partition table and the proper u-boot kpart image
  cp files/chromebook-boot/cb.dd-single-part ${DOWNLOAD_DIR}/boot-chromebook_nyan-armv7l.dd
  wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_nyan_uboot_version}/uboot.kpart.cbt.gz -O - | gunzip -c >> ${DOWNLOAD_DIR}/boot-chromebook_nyan-armv7l.dd
fi