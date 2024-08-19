IMAGE_NAME_DEV := stack-app-dev
IMAGE_TAG_DEV := $(IMAGE_NAME_DEV)

build-dev-image:
	docker build -t $(IMAGE_NAME_DEV) -f infra/docker/app/dev.dockerfile .
