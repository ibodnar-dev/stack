IMAGE_NAME_DEV := stack-app-dev
IMAGE_TAG_DEV := $(IMAGE_NAME_DEV)
CLUSTER_NAME := stack
CNPG_MANIFEST_URL := \
https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.23/releases/cnpg-1.23.2.yaml

kd-create:
	kind create cluster --name $(CLUSTER_NAME)

kd-delete:
	kind delete clusters $(CLUSTER_NAME)

kd-reset: kd-delete kd-create

install-cnpg-controller:
	kubectl apply --server-side -f $(CNPG_MANIFEST_URL)

install-cnpg-cluster:
	kubectl apply -f ./infra/k8s/postgres/cluster.yaml

install-kc:
	kubectl apply -f ./infra/k8s/keycloak/keycloak.yaml

uninstall-kc:
	kubectl delete -f ./infra/k8s/keycloak/keycloak.yaml

build-dev-image:
	docker build -t $(IMAGE_NAME_DEV) -f ./infra/docker/app/dev.dockerfile .

load-dev-image:
	kind load docker-image $(IMAGE_NAME_DEV) --name $(CLUSTER_NAME)

port-forward-app:
	kubectl port-forward service/app-service 8080:8081