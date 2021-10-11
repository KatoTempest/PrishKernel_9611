#
#!/bin/bash

echo "Setting Up Environment"
echo ""
export ARCH=arm64
export SUBARCH=arm64
export ANDROID_MAJOR_VERSION=r
export PLATFORM_VERSION=11.0.0

# Export KBUILD flags
export KBUILD_BUILD_USER=licht
export KBUILD_BUILD_HOST=ubuntu

# CCACHE
export CCACHE="$(which ccache)"
export USE_CCACHE=1
export CCACHE_EXEC="/home/ccache"
ccache -M 50G
export CCACHE_COMPRESS=1

# TC LOCAL PATH
export CROSS_COMPILE=/home/licht/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CLANG_TRIPLE=/usr/bin/aarch64-linux-gnu-
export CC=/home/licht/clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04/bin/clang

# Export toolchain/cross flags
#export TOOLCHAIN="aarch64-linux-android-"
#export CLANG_TRIPLE="aarch64-linux-gnu-"
#export CROSS_COMPILE="$(pwd)/gcc/bin/${TOOLCHAIN}"
#export CROSS_COMPILE_ARM32="$(pwd)/gcc32/bin/arm-linux-androideabi-"
#export WITH_OUTDIR=true

# Export PATH flag
#export PATH="${PATH}:$(pwd)/clang/bin:$(pwd)/gcc/bin:$(pwd)/gcc32/bin"

# Check if have gcc/32 & clang folder
#if [ ! -d "$(pwd)/gcc/" ]; then
#   git clone --depth 1 git://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9 gcc
#fi

#if [ ! -d "$(pwd)/gcc32/" ]; then
#   git clone --depth 1 git://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9 gcc32
#fi

#if [ ! -d "$(pwd)/clang/" ]; then
#   git clone --depth 1 https://github.com/PrishKernel/toolchains.git -b proton-clang12 clang
#fi

clear
echo "                                                     "
echo "   ____  ____  ___ ____  __  __    _      ____   ____ ____  ___ ____ _____  "
echo "  |  _ \|  _ \|_ _/ ___||  \/  |  / \    / ___| / ___|  _ \|_ _|  _ \_   _| "
echo "  | |_) | |_) || |\___ \| |\/| | / _ \   \___ \| |   | |_) || || |_) || |   "
echo "  |  __/|  _ < | | ___) | |  | |/ ___ \   ___) | |___|  _ < | ||  __/ | |   "
echo "  |_|   |_| \_\___|____/|_|  |_/_/   \_\ |____/ \____|_| \_\___|_|    |_|   "
echo "                                                                            "
echo "            coded by Neel0210, DAvinash97, Durasame - Modified by licht     "
echo "                                                                            "
echo "Select"
echo "1 = Clear"
echo "2 = Kernel+zip A51"
echo "3 = AIK+ZIP"
echo "4 = Anykernel"
echo "5 = Exit"
read n

if [ $n -eq 1 ]; then
echo "========================"
echo "Clearing & making clear"
echo "========================"
make clean
make mrproper
rm ./Image
rm ./output/*.zip
rm ./PRISMA/AIK/image-new.img
rm ./PRISMA/AIK/ramdisk-new.cpio.empty
rm ./PRISMA/AIK/split_img/boot.img-zImage
rm ./PRISMA/AK/Image
rm ./PRISMA/ZIP/PRISMA/A51/boot.img
rm ./PRISMA/AK/1.zip
rm -rf M31
rm -rf M21
fi

if [ $n -eq 2 ]; then
echo "==============="
echo "Building Clean"
echo "==============="
make clean && make mrproper
rm ./arch/arm64/boot/Image
rm ./arch/arm64/boot/Image.gz
rm ./Image
rm ./output/*.zip
rm ./PRISMA/AIK/image-new.img
rm ./PRISMA/AIK/ramdisk-new.cpio.empty
rm ./PRISMA/AIK/split_img/boot.img-zImage
rm ./PRISMA/AK/Image
rm ./PRISMA/ZIP/PRISMA/A51/boot.img
rm ./PRISMA/AK/*.zip
rm -rf M31
rm -rf M21
clear
############################################
# If other device make change here
############################################
echo "==============="
echo "Building Clean"
echo "==============="
make prisma_a51_defconfig
make -j$(nproc --all) 
echo ""
echo "Kernel Compiled"
echo ""
cp -r ./A51/arch/arm64/boot/Image ./PRISMA/AIK/split_img/boot.img-zImage
cp -r ./A51/arch/arm64/boot/Image ./PRISMA/AK/Image
fi

if [ $n -eq 3 ]; then
echo "============"
echo "Dirty Build"
echo "============"
############################################
# If other device make change here
############################################
make prisma_a51_defconfig 
make -j$(nproc --all) 
echo ""
echo "Kernel Compiled"
echo ""
rm ./PRISMA/AIK/split_img/boot.img-zImage
cp -r ./A51/arch/arm64/boot/Image ./PRISMA/AIK/split_img/boot.img-zImage
rm ./PRISMA/AK/Image
cp -r ./A51/arch/arm64/boot/Image ./PRISMA/AK/Image
echo "====================="
echo "Dirty Build Finished"
echo "====================="
fi

if [ $n -eq 4 ]; then
echo "======================="
echo "Making kernel with ZIP"
echo "======================="
make clean && make mrproper
rm ./arch/arm64/boot/Image
rm ./arch/arm64/boot/Image.gz
rm ./Image
rm ./output/*.zip
rm ./PRISMA/AIK/image-new.img
rm ./PRISMA/AIK/ramdisk-new.cpio.empty
rm ./PRISMA/AIK/split_img/boot.img-zImage
rm ./PRISMA/AK/Image
rm ./PRISMA/ZIP/PRISMA/NXT/boot.img
rm ./PRISMA/ZIP/PRISMA/M30S/boot.img
rm ./PRISMA/ZIP/PRISMA/A50/boot.img
rm ./PRISMA/AK/*.zip
rm -rf A51
clear
############################################
# If other device make change here
############################################
echo "==="
echo "A51"
echo "==="
make A51_defconfig 
make -j$(nproc --all) 
echo "Kernel Compiled"
echo ""
rm ./PRISMA/AK/Image
cp -r ./A51/arch/arm64/boot/Image ./PRISMA/AK/Image
cd PRISMA/AK
. zip.sh
cd ../..
cp -r ./PRISMA/AK/1*.zip ./output/PrismaKernel-A51.zip
rm ./PRISMA/AK/*.zip
rm ./PRISMA/AK/Image
echo "==="
echo "Done"
echo "==="
fi

if [ $n -eq 5 ]; then
echo "====================="
echo "Transfering Files"
echo "====================="
rm ./PRISMA/AIK/split_img/boot.img-zImage
rm ./output/Pri*
cp -r ./A51/arch/arm64/boot/Image ./output/Zimage/Image
cp -r ./A51/arch/arm64/boot/Image ./AIK/split_img/boot.img-zImage
./PRISMA/AIK/repackimg.sh
cp -r ./PRISMA/AIK/image-new.img ./PRISMA/ZIP/PRISMA/A51/boot.img
cd PRISMA/ZIP
echo " "
echo "==========================="
echo "Packing into Flashable zip"
echo "==========================="
./zip.sh
cd ../..
cp -r ./PRISMA/ZIP/1.zip ./output/PrismaKernel-A51.zip
cd output
cd ..
echo " "
pwd
echo "======================================================"
echo "get PrismaKernel-A51.zip from upper given path"
echo "======================================================"
fi

if [ $n -eq 6 ]; then
echo "===================="
echo "ADDING IN ANYKERNEL"
echo "===================="
rm ./output/Any*
rm ./PRISMA/AK/Image
cp -r ./A51/arch/arm64/boot/Image ./PRISMA/AK/Image
cd PRISMA/AK
echo " "
echo "=========================="
echo "Packing into Anykernelzip"
echo "=========================="
./zip.sh
cd ../..
cp -r ./PRISMA/AK/1*.zip ./output/PrismaKernel-A51.zip
cd output
cd ..
echo " "
pwd
echo "============================================"
echo "get Anykernel.zip from upper given path"
echo "============================================"
fi

if [ $n -eq 7 ]; then
echo "========"
echo "Exiting"
echo "========"
exit
fi



