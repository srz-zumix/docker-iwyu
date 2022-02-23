#!/bin/bash

set +o pipefail
apt-add-repository "$1" || :
