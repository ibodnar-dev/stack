IMAGE_NAME_DEV := stack-app-dev
IMAGE_TAG_DEV := $(IMAGE_NAME_DEV)
CLUSTER_NAME := stack
CNPG_MANIFEST_URL := https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.23/\
releases/cnpg-1.23.2.yaml


build-dev-image:
	docker build -t $(IMAGE_NAME_DEV) -f infra/docker/app/dev.dockerfile .

kd-create:
	kind create cluster --name $(CLUSTER_NAME)

kd-delete:
	kind delete clusters $(CLUSTER_NAME)

kd-reset: kd-delete kd-create

install-cnpg-controller:
	kubectl apply --server-side -f $(CNPG_MANIFEST_URL)

install-cnpg-cluster:
	kubectl apply -f ./postgres/cluster.yaml

install-kc:
	kubectl apply -f keycloak/keycloak.yaml

uninstall-kc:
	kubectl delete -f keycloak/keycloak.yaml
