# docker-iwyu

[![Docker Status](https://images.microbadger.com/badges/image/srzzumix/iwyu.svg)](https://microbadger.com/images/srzzumix/iwyu)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/1364d1cccc2742e1934afe4909287106)](https://app.codacy.com/app/srz-zumix/docker-iwyu?utm_source=github.com&utm_medium=referral&utm_content=srz-zumix/docker-iwyu&utm_campaign=Badge_Grade_Dashboard)

[DockerHub](https://hub.docker.com/r/srzzumix/iwyu/)

* Ubuntu:bionic
* include-what-you-use clang_6.0

## Usage

docker run -it -v ${pwd}:/target --entrypoint="bash" srzzumix/iwyu -c "CXX=iwyu CC=iwyu \<your build command\>"
