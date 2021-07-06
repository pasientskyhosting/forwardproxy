VERSION ?= v1.0.3
run:
	go run -ldflags="-X main.version=${VERSION} -X main.date=$(shell date '+%Y-%m-%dT%H:%M:%S%z')" src/main.go

all: prep binaries docker

prep:
	mkdir -p docker-build/bin

binaries: linux64 darwin64

build:
	go build ./cmd/caddy

linux64:
	GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o docker-build/bin/caddy ./cmd/caddy

darwin64:
	GOOS=darwin GOARCH=amd64 go build -ldflags="-s -w" -o docker-build/bin/caddyOSX ./cmd/caddy

pack-linux64: linux64
	upx --brute bin/caddy

docker: linux64
	docker build -t pasientskyhosting/forwardproxy:latest docker-build/. && \
	docker build -t pasientskyhosting/forwardproxy:$(VERSION) docker-build/.

docker-run:
	docker run pasientskyhosting/forwardproxy:$(VERSION)

docker-push:
	docker push pasientskyhosting/forwardproxy:$(VERSION)
