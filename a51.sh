#! bin/bash


echo "Setting Up Environment"
echo ""
export ARCH=arm64
export SUBARCH=arm64
export ANDROID_MAJOR_VERSION=r
export PLATFORM_VERSION=11.0.0


# Export KBUILD flags
export KBUILD_BUILD_USER=licht
export KBUILD_BUILD_HOST=arch


# CCACHE
export CCACHE="$(which ccache)"
export USE_CCACHE=1
export CCACHE_EXEC="/home/ccache"
ccache -M 50G
export CCACHE_COMPRESS=1

# TC LOCAL PATH
export CROSS_COMPILE=/home/licht/toolchain/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CLANG_TRIPLE=/usr/bin/aarch64-linux-gnu-
export CC=/home/licht/toolchain/clang-4639204/bin/clang


echo "===="
echo "A51"
echo "===="
mkdir output
make clean
make mrproper
rm -rf A51
make prisma_a51_defconfig 
make -j$(nproc --all)  | tee A51_Compile.log
echo "Kernel Compiled"
echo ""
rm ./PRISMA/AK/Image
rm ./output/*.zip
cp -R ./arch/arm64/boot/Image ./PRISMA/AK/Image
cd PRISMA/AK
. zip.sh
cd ../..
cp -R ./PRISMA/AK/1*.zip ./output/PrismaKernel-A51.zip
rm ./PRISMA/AK/*.zip
rm ./PRISMA/AK/Image

