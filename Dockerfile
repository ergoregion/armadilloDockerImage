FROM ubuntu:22.04

RUN apt update && apt install -y \
    wget \
    gpg \
    python3-pip \
    git \
    libgtest-dev \
    cmake\
    build-essential \
    cppcheck \
    lcov \
    clang-tidy \
    clang-format \
    libhdf5-dev

#Install MKL
RUN wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearmor | tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null && \
    echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list && \
    apt update && \
    apt-get install -y  intel-oneapi-mkl-devel-2023.1.0 \
    cppcheck
#Install Armadillo and Boost
RUN apt-get install -y libboost-dev libarmadillo-dev
#Clean up
RUN    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
#Build GTEST
RUN   cd /usr/src/gtest && cmake . && make && cp /usr/src/gtest/lib/*.a /usr/lib


ENV MKL_LINK_DIRECTORY=/opt/intel/oneapi/mkl/2023.1.0/lib/intel64
ENV MKL_INCLUDE_DIRECTORY=/opt/intel/oneapi/mkl/2023.1.0/include