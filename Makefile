PKGS := $(shell go list ./... | grep -v /vendor)

.PHONY: test
test: deps lint
	go test $(PKGS)

BIN_DIR := $(GOPATH)/bin
GOMETALINTER := $(BIN_DIR)/gometalinter

$(GOMETALINTER):
	go get -u github.com/alecthomas/gometalinter
	gometalinter --install &> /dev/null

.PHONY: lint
lint: $(GOMETALINTER)
	gometalinter --disable=gotype ./...

BINARY := helloworld
VERSION ?= $(shell cat ./VERSION)
PLATFORMS := windows linux darwin
os = $(word 1, $@)

.PHONY: deps
deps:
	go get

.PHONY: $(PLATFORMS)
$(PLATFORMS):
	mkdir -p release
	GOOS=$(os) GOARCH=amd64 go build -o release/$(BINARY)-$(VERSION)-$(os)-amd64

.PHONY: release
release: deps linux darwin #windows
	cp release/$(BINARY)-$(VERSION)-linux-amd64 release/$(BINARY)-linux

.PHONY: docker
docker:
	@echo "Building and tagging Docker image v$(VERSION)"
	docker build -t $(BINARY):$(VERSION) .