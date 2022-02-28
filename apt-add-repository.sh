#!/bin/bash

set -eu

source /etc/os-release

CLANG_VERSION=$1
CLANG_MAJOR="${CLANG_VERSION%%.*}"

UBUNTU_MAJOR="${VERSION_ID%%.*}"

if [ "${CLANG_MAJOR}" -gt 8 ]; then
    apt-add-repository "deb http://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-${CLANG_VERSION} main" 
fi

if [ "${CLANG_MAJOR}" -le 3 ]; then
  if [ "${UBUNTU_MAJOR}" -lt 18 ]; then
    apt-add-repository "deb http://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-${CLANG_VERSION} main" 
  fi
fi
