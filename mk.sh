#!/bin/bash

echo Parsing LinuxUpl ...
TOKEN=$(cat ~/.netrc | grep -m 1 password | cut -d " " -f 4)

echo Checkout LinuxUpl ...
if [ ! -d "LinuxUpl" ]; then
  git clone https://github.com/intel-innersource/firmware.boot.upl.linux-upl LinuxUpl
else
  echo "  LinuxUpl exist!"
fi

echo Checkout Linux Boot Image ...
if [ ! -f "linuxboot_bzImage" ]; then
  wget --header 'Authorization: token '$TOKEN https://raw.githubusercontent.com/intel-innersource/firmware.boot.coreboot-xeon.site-local/main/payload/LinuxBoot/linuxboot_bzImage
else
  echo "  Linux Boot Image exist!"
fi

echo Compiling LinuxUpl ...
cd LinuxUpl
rm -rf Build
bash LinuxUplBuild.sh -K ../linuxboot_bzImage
cd ..

cp -f ./LinuxUpl/Build/LinuxUniversalPayload.elf ./
