ARG UBUNTU_VERSION=latest
FROM ubuntu:$UBUNTU_VERSION
ARG UBUNTU_VERSION

LABEL maintainer "srz_zumix <https://github.com/srz-zumix>"
ARG IWYU_VERSION=clang_9.0
ARG CLANG_VERSION=9

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update -q -y && \
    apt-get install -y --no-install-recommends software-properties-common && \
    apt-get update -q -y && \
    apt-get install -y --no-install-recommends wget curl git make cmake gcc g++ \
        libncurses-dev zlib1g-dev \
        python gpg-agent && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# clang
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    source /etc/os-release && \
    apt-add-repository "deb http://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-${CLANG_VERSION} main" && \
    apt-get update && \
    apt-get install -y --no-install-recommends llvm-${CLANG_VERSION}-dev libclang-${CLANG_VERSION}-dev clang-${CLANG_VERSION} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Include-what-you-use
RUN mkdir /target && \
    mkdir iwyu && mkdir iwyu/build && \
    git clone -b ${IWYU_VERSION} https://github.com/include-what-you-use/include-what-you-use.git iwyu/include-what-you-use
WORKDIR /iwyu/build
RUN cmake -G "Unix Makefiles" -DCMAKE_PREFIX_PATH=/usr/lib/llvm-${CLANG_VERSION} ../include-what-you-use && \
    make && make install && \
    ln -s "$(command -v include-what-you-use)" /usr/local/bin/iwyu

# Make the compiler built-in includes accessible to iwyu
RUN mkdir /usr/local/lib/clang && \
    ln -s /usr/lib/clang/* /usr/local/lib/clang/


VOLUME [ "/target" ]
WORKDIR /target

ENTRYPOINT [ "include-what-you-use" ]
CMD [ "--version" ]
