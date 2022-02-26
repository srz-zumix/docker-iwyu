#
# Makefile

IMAGE_NAME=srzzumix/iwyu

defaut: help

help: ## Display this help screen
	@grep -E '^[a-zA-Z][a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sed -e 's/^GNUmakefile://' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

docker-build: ## build docker image
	docker build -t ${IMAGE_NAME} .

docker-clean-build: ## clean docker image
	docker build -t ${IMAGE_NAME} .

docker-run: ## run docker image
	docker run -it --rm ${IMAGE_NAME}

clang-9:
	docker build -t ${IMAGE_NAME}:clang-9 --build-arg CLANG_VERSION=9 --build-arg IWYU_BRANCH=clang_9.0 .

clang-8:
	docker build -t ${IMAGE_NAME}:clang-8 --build-arg CLANG_VERSION=8 --build-arg IWYU_BRANCH=clang_8.0 .

clang-6:
	docker build -t ${IMAGE_NAME}:clang-6 --build-arg CLANG_VERSION=6.0 --build-arg IWYU_BRANCH=clang_6.0 .

bionic-clang-6:
	docker build -t ${IMAGE_NAME}:bionic-clang-6 --build-arg UBUNTU_VERSION=bionic --build-arg CLANG_VERSION=6.0 --build-arg IWYU_BRANCH=clang_6.0 .

bionic-clang-3.9:
	docker build -t ${IMAGE_NAME}:bionic-clang-3.9 --build-arg UBUNTU_VERSION=bionic --build-arg CLANG_VERSION=3.9 --build-arg IWYU_BRANCH=clang_3.9 .
