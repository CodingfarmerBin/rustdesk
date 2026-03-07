FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV VCPKG_FORCE_SYSTEM_BINARIES=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    clang \
    cmake \
    curl \
    git \
    gcc-multilib \
    g++ \
    g++-multilib \
    libayatana-appindicator3-dev \
    libasound2-dev \
    libc6-dev \
    libclang-dev \
    libunwind-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    libgtk-3-dev \
    libpam0g-dev \
    libpulse-dev \
    libva-dev \
    libvdpau-dev \
    libxcb-randr0-dev \
    libxcb-shape0-dev \
    libxcb-xfixes0-dev \
    libxdo-dev \
    libxfixes-dev \
    llvm-dev \
    nasm \
    ninja-build \
    openjdk-17-jdk-headless \
    pkg-config \
    python3 \
    tree \
    wget \
    zip && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN git clone https://github.com/microsoft/vcpkg.git && \
    cd vcpkg && \
    ./bootstrap-vcpkg.sh -disableMetrics

ENV VCPKG_ROOT=/opt/vcpkg

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"
ENV ANDROID_NDK_ROOT=/opt/android-ndk

RUN wget -q https://dl.google.com/android/repository/android-ndk-r27c-linux.zip -O ndk.zip && \
    unzip -q ndk.zip -d /opt && \
    rm ndk.zip && \
    mv /opt/android-ndk-r27c /opt/android-ndk

ENV PATH="${ANDROID_NDK_ROOT}:${PATH}"

WORKDIR /workspace
