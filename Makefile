# Parameters to compile and run application
GOOS?=linux
GOARCH?=amd64

PROJECT?=github.com/moris2/gosofia
BUILD_PATH?=cmd/gosofia
APP?=gosofia

PORT?=80
DIAG_PORT?=8080

# Current version and commit
RELEASE?=0.0.1
COMMIT?=$(shell git rev-parse --short HEAD)
BUILD_TIME?=$(shell date -u '+%Y-%m-%d_%H:%M:%S')

# Parameters to push images and release app to Kubernetes or try it with Docker
REGISTRY?=docker.io/webdeva
NAMESPACE?=moris2
CONTAINER_NAME?=${NAMESPACE}-${APP}
CONTAINER_IMAGE?=${REGISTRY}/${CONTAINER_NAME}
VALUES?=values-stable

container:
	docker build -t $(CONTAINER_IMAGE):$(RELEASE) .

push: container
	docker push $(CONTAINER_IMAGE):$(RELEASE)

deploy: push
	helm upgrade --install ${CONTAINER_NAME} -f charts/${VALUES}.yaml charts \
		--kube-context ${KUBE_CONTEXT} --namespace ${NAMESPACE} --version=${RELEASE} -i --wait \
		--set image.registry=${REGISTRY} --set image.name=${CONTAINER_NAME} --set image.tag=${RELEASE}
