#!/bin/bash

source /etc/os-release

if [ ${CLANG_VERSION} -gt 8 ]; then
    apt-add-repository "deb http://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-${CLANG_VERSION} main" 
fi

