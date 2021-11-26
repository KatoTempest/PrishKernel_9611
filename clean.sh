echo "Setting Up Environment"
echo ""
export ARCH=arm64
export SUBARCH=arm64
export ANDROID_MAJOR_VERSION=r
export PLATFORM_VERSION=11.0.0
# TC LOCAL PATH
export CROSS_COMPILE=/home/licht/toolchain/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CLANG_TRIPLE=/usr/bin/aarch64-linux-gnu-
export CC=/home/licht/toolchain/clang-4639204/bin/clang
make clean
make mrproper
rm -rf A51
