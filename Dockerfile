FROM ubuntu:bionic

LABEL maintainer "srz_zumix <https://github.com/srz-zumix>"
ENV IWYU_VERSION=clang_9.0
ENV CLANG_VERSION=9

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
    apt-add-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-${CLANG_VERSION} main" && \
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

VOLUME [ "/target" ]
WORKDIR /target

ENTRYPOINT [ "include-what-you-use" ]
CMD [ "--version" ]
