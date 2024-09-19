#!/bin/bash
# Set the project root directory
TAMBUR_ROOT=${TAMBUR_ROOT:-$(dirname "$(realpath "$0")")}
echo $TAMBUR_ROOT

# Install system dependencies
sudo apt-get update -y && sudo apt-get install -y \
    build-essential \
    autoconf \
    automake \
    libtool \
    g++ \
    pkg-config \
    googletest \
    libgtest-dev \
    libz-dev \
    jq \
    libjerasure2 \
    protobuf-compiler \
    libprotobuf-dev \
    autotools-dev \
    dh-autoreconf \
    iptables \
    dnsmasq-base \
    apache2-bin \
    debhelper \
    libssl-dev \
    ssl-cert \
    libxcb-present-dev \
    libcairo2-dev \
    libpango1.0-dev \
    apache2-dev \
    python3-pip \
    libvpx-dev \
    libsdl2-dev \
    unzip

# Install Python packages
pip3 install torch torchvision torchaudio pandas matplotlib


# Build dependencies
cd "$TAMBUR_ROOT/third_party/gf-complete-master"
./autogen.sh
./configure
make -j
sudo make install

cd "$TAMBUR_ROOT/third_party/Jerasure-master/"
autoreconf --force --install
./configure
make -j
sudo make install

cd "$TAMBUR_ROOT/third_party/mahimahi-master/"
./autogen.sh
./configure
make -j
sudo make install

cd "$TAMBUR_ROOT/third_party"
wget https://download.pytorch.org/libtorch/lts/1.8/cpu/libtorch-cxx11-abi-shared-with-deps-1.8.2%2Bcpu.zip
unzip libtorch-cxx11-abi-shared-with-deps-1.8.2+cpu.zip
rm libtorch-cxx11-abi-shared-with-deps-1.8.2+cpu.zip

cd "$TAMBUR_ROOT/third_party/ringmaster"
./autogen.sh
./configure
make -j

# Build Tambur
cd $TAMBUR_ROOT
./autogen.sh
./configure
make -j
