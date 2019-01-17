# docker-iwyu

[![](https://images.microbadger.com/badges/image/srzzumix/iwyu.svg)](https://microbadger.com/images/srzzumix/iwyu "Get your own image badge on microbadger.com")

https://hub.docker.com/r/srzzumix/iwyu/

* Ubuntu:xenial
* include-what-you-use clang_6.0

## Usage

docker run -it -v ${pwd}:/target --entrypoint="bash" srzzumix/iwyu -c "CXX=iwyu CC=iwyu <your build command>"
