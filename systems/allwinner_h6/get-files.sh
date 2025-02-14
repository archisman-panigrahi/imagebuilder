# this file is supposed to be sourced by the get-files shell script  


allwinner_h6_release_version="6.12.12-stb-ah6%2B"
allwinner_h6_uboot_version="211229-01"
allwinner_h6_uboot_noname_version="200718-01"

rm -f ${DOWNLOAD_DIR}/kernel-allwinner_h6-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-allwinner-h6-kernel/releases/download/${allwinner_h6_release_version}/${allwinner_h6_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-allwinner_h6-${2}.tar.gz

# get different u-boot versions for different allwinner h6 systems to have them around
rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
for system in eachlink_h6_mini orange_pi_3 pine-h64 orangepi_one_plus tanix_tx6; do
  wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_h6_uboot_version}/boot-${system}-aarch64.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-${system}.dd
done
# it looks like the newer nonmame u-boot does not work as expected, so use the older one until fresh ones get rebuilt one day ...
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${allwinner_h6_uboot_noname_version}/boot-allwinner_h6-aarch64-noname-tv-box.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-noname_h6_tv_box.dd

# use the eachlink h6 mini u-boot as default
cp ${DOWNLOAD_DIR}/boot-extra-${1}/boot-eachlink_h6_mini.dd ${DOWNLOAD_DIR}/boot-allwinner_h6-${2}.dd
