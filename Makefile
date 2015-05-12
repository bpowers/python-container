IMAGE ?= bpowers/dev-base
TAG ?= v10

all: build

build: Dockerfile readyexec-amd64
	docker build -t "$(IMAGE):$(TAG)" .

.PHONY: all build
