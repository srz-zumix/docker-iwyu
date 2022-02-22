# docker-iwyu

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/1364d1cccc2742e1934afe4909287106)](https://app.codacy.com/app/srz-zumix/docker-iwyu?utm_source=github.com&utm_medium=referral&utm_content=srz-zumix/docker-iwyu&utm_campaign=Badge_Grade_Dashboard)
[![Docker Build](https://github.com/srz-zumix/docker-iwyu/actions/workflows/docker-build.yml/badge.svg)](https://github.com/srz-zumix/docker-iwyu/actions/workflows/docker-build.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/srzzumix/iwyu)](https://hub.docker.com/r/srzzumix/iwyu)

[DockerHub](https://hub.docker.com/r/srzzumix/iwyu/)

## Usage

docker run -it -v ${pwd}:/target --entrypoint="bash" srzzumix/iwyu:clang-9 -c "CXX=iwyu CC=iwyu \<your build command\>"
