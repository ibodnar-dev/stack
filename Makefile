IMAGE_NAME_DEV := stack-app-dev
IMAGE_NAME_PROD := stack-app-prod
REGISTRY_URL_DEV := registry
REGISTRY_PORT_DEV := 5001
IMAGE_TAG_DEV := $(REGISTRY_URL_DEV):$(REGISTRY_PORT_DEV)/$(IMAGE_NAME_DEV)

build-dev-image:
	docker build -t $(IMAGE_NAME_DEV) -f infra/docker/app/dev.dockerfile .

build-prod-image:
	docker build -t $(IMAGE_NAME_PROD) .

push-dev-image:
	docker push $(IMAGE_TAG_DEV)
