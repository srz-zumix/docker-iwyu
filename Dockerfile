FROM ubuntu:xenial

LABEL maintainer "srz_zumix <https://github.com/srz-zumix>"
ENV CLANG_VERSION=6.0

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update -q -y && \
    apt-get install -y --no-install-recommends software-properties-common && \
    apt-get update -q -y && \
    apt-get install -y --no-install-recommends wget curl git make cmake gcc g++ \
        libncurses-dev zlib1g-dev \
        python && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
# RUN apt-get install -y iwyu


# clang
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-${CLANG_VERSION} main" && \
    apt-get update && \
    apt-get install -y --no-install-recommends llvm-${CLANG_VERSION}-dev libclang-${CLANG_VERSION}-dev clang-${CLANG_VERSION} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
# RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${CLANG_VERSION} 1000 && \
#     update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${CLANG_VERSION} 1000 && \ 
#     update-alternatives --config clang && \
#     update-alternatives --config clang++

RUN mkdir /target && \
    mkdir iwyu && \
    git clone -b clang_6.0 https://github.com/include-what-you-use/include-what-you-use.git iwyu/include-what-you-use && \
    cd iwyu && mkdir build && cd build && \
    cmake -G "Unix Makefiles" -DIWYU_LLVM_ROOT_PATH=/usr/lib/llvm-${CLANG_VERSION} ../include-what-you-use && \
    # cmake -G "Unix Makefiles" -DCMAKE_PREFIX_PATH=/usr/lib/llvm-7 ../include-what-you-use && \
    make && make install && \
    ln -s "$(command -v include-what-you-use)" /usr/local/bin/iwyu
    # echo "alias iwyu=include-what-you-use" >> ~/.bashrc

VOLUME [ "/target" ]
WORKDIR /target

ENTRYPOINT [ "include-what-you-use" ]
CMD [ "--version" ]
