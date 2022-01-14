# pull base image
FROM ubuntu:focal

# install dependencies
RUN apt update && apt install -y \
    ca-certificates \
    make \
    gcc \
    libc6-dev \
    gcc-8-arm-linux-gnueabihf \
    git \
    libssl-dev \
    flex \
    bison \
    bc \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# set a symlink to arm-linux-gnueabihf-gcc
RUN update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-8 100

# set crosscompilation env variables
ENV ARCH=arm
ENV CROSS_COMPILE=arm-linux-gnueabihf-
