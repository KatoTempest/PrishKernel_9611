#! bin/bash


echo "Setting Up Environment"
echo ""
export ARCH=arm64
export SUBARCH=arm64
export ANDROID_MAJOR_VERSION=r
export PLATFORM_VERSION=11.0.0


# Export KBUILD flags
#export KBUILD_BUILD_USER=licht
#export KBUILD_BUILD_HOST=hell

# CCACHE
export CCACHE="$(which ccache)"
export USE_CCACHE=1
export CCACHE_EXEC="/home/neel/Desktop/ccache"
ccache -M 50G
export CCACHE_COMPRESS=1

# TC LOCAL PATH
export CROSS_COMPILE=/home/licht/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CLANG_TRIPLE=/usr/bin/aarch64-linux-gnu-
export CC=/home/licht/clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04/bin/clang


echo "===="
echo "A51"
echo "===="
make clean
make mrproper
rm -rf A51
make prisma_a51_defconfig 
make -j$(nproc --all)  | tee A51_Compile.log
echo "Kernel Compiled"
echo ""
rm ./PRISMA/AK/Image
rm ./output/*.zip
cp -r ./arch/arm64/boot/Image ./PRISMA/AK/Image
cd PRISMA/AK
. zip.sh
cd ../..
cp -r ./PRISMA/AK/1*.zip ./output/PrismaKernel-A51.zip
rm ./PRISMA/AK/*.zip
rm ./PRISMA/AK/Image

#changelog=`cat PRISH/changelog.txt`
#for i in output/*.zip
#do
#curl -F "document=@$i" --form-string "caption=$changelog" "https://api.telegram.org/bot${BOT_ID}/sendDocument?chat_id=${M21CHAT_ID}&parse_mode=HTML"
#done