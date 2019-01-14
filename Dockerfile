FROM ubuntu:xenial

LABEL maintainer "srz_zumix <https://github.com/srz-zumix>"

ARG CLANG_VERSION=6.0

RUN apt-get update -q -y && \
    apt-get install -y software-properties-common
RUN apt-get update -q -y && \
    apt-get install -y wget sudo curl git make cmake gcc g++ \
        libncurses-dev zlib1g-dev
# RUN apt-get install -y iwyu


# clang
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add - && \
    apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-${CLANG_VERSION} main" && \
    apt-get update && \
    apt-get install -y llvm-${CLANG_VERSION}-dev libclang-${CLANG_VERSION}-dev clang-${CLANG_VERSION}
# RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${CLANG_VERSION} 1000 && \
#     update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${CLANG_VERSION} 1000 && \
#     update-alternatives --config clang && \
#     update-alternatives --config clang++

RUN mkdir iwyu && cd iwyu && \
    git clone https://github.com/include-what-you-use/include-what-you-use.git && \
    cd include-what-you-use && \
    git checkout clang_6.0
RUN cd iwyu && mkdir build && cd build && \
    cmake -G "Unix Makefiles" -DIWYU_LLVM_ROOT_PATH=/usr/lib/llvm-${CLANG_VERSION} ../include-what-you-use && \
 #   cmake -G "Unix Makefiles" -DCMAKE_PREFIX_PATH=/usr/lib/llvm-7 ../include-what-you-use && \
    make && make install


RUN ln -s $(which include-what-you-use) /usr/bin/iwyu
# RUN echo "alias iwyu=include-what-you-use" >> ~/.bashrc

RUN mkdir /target
VOLUME [ "/target" ]
WORKDIR /target

ENTRYPOINT [ "include-what-you-use" ]
CMD [ "--version" ]
