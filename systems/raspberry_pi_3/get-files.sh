if [ "$1" = "raspberry_pi_3" ]; then
  rm -f ${DOWNLOAD_DIR}/kernel-raspberry_pi-aarch64.tar.gz
  wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${raspberry_pi_3_release_version}/${raspberry_pi_3_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-raspberry_pi-aarch64.tar.gz
fi