# docker-iwyu

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/1364d1cccc2742e1934afe4909287106)](https://app.codacy.com/app/srz-zumix/docker-iwyu?utm_source=github.com&utm_medium=referral&utm_content=srz-zumix/docker-iwyu&utm_campaign=Badge_Grade_Dashboard)
[![Docker Build](https://github.com/srz-zumix/docker-iwyu/actions/workflows/docker-build.yml/badge.svg)](https://github.com/srz-zumix/docker-iwyu/actions/workflows/docker-build.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/srzzumix/iwyu)](https://hub.docker.com/r/srzzumix/iwyu)

[DockerHub](https://hub.docker.com/r/srzzumix/iwyu/)

dockerized [include-what-you-use][]

## Usage

```sh
docker run -it -v ${pwd}:/target --entrypoint="bash" srzzumix/iwyu:clang-13 -c "CXX=iwyu CC=iwyu \<your build command\>"
```

```sh
$ docker run -it -v ${pwd}:/target --entrypoint="bash" srzzumix/iwyu:clang-13
root@49089388910c:/target# mkdir build && cd build
root@49089388910c:/target# CC="clang" CXX="clang++" cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ...
root@49089388910c:/target# iwyu_tool.py -j2 -p ./cmake-build -Xiwyu --mapping_file=/opt/iwyu/gcc.symbols.imp
```

[include-what-you-use]:https://github.com/include-what-you-use/include-what-you-use
