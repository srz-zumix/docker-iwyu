#
# Makefile

IMAGE_NAME=srzzumix/docker-iwyu

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
