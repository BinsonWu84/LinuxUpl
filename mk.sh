#!/bin/bash

echo Checkout out LinuxUpl ...
if [ ! -d "LinuxUpl" ]; then
  git clone https://github.com/intel-innersource/firmware.boot.upl.linux-upl LinuxUpl
fi

echo Checkout out site-local ...
if [ ! -d "site-local" ]; then
  git clone https://github.com/intel-innersource/firmware.boot.coreboot-xeon.site-local site-local
fi

echo Compiling LinuxUpl ...
cd LinuxUpl
rm -rf Build
bash LinuxUplBuild.sh -K ../site-local/payload/LinuxBoot/linuxboot_bzImage
cd ..

cp -f ./LinuxUpl/Build/LinuxUniversalPayload.elf ./
