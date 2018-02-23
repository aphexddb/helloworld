PKGS := $(shell go list ./... | grep -v /vendor)

BIN_DIR := $(GOPATH)/bin
GOMETALINTER := $(BIN_DIR)/gometalinter
GOJUNITREPORT := $(BIN_DIR)/go-junit-report

$(GOJUNITREPORT):
	go get -u github.com/jstemmer/go-junit-report

.PHONY: test
test: $(GOJUNITREPORT) lint deps
	mkdir -p ./test-reports
	go test -v $(PKGS) ./... 2>&1 | go-junit-report > ./test-reports/report.xml

$(GOMETALINTER):
	go get -u github.com/alecthomas/gometalinter	
	gometalinter -i -u

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