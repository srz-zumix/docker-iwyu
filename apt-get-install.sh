#!/bin/bash

set -eu

source /etc/os-release

UBUNTU_MAJOR="${VERSION_ID%%.*}"

if [ "${UBUNTU_MAJOR}" -ge 18 ]; then
  apt-get install -y --no-install-recommends \
    gpg-agent
fi

if [ "${UBUNTU_MAJOR}" -lt 18 ]; then
  apt-get install -y --no-install-recommends \
    apt-transport-https
fi
