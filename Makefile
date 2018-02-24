PKGS := $(shell go list ./... | grep -v /vendor)

BINARY := helloworld
ENTRYPOINT := cmd/server.go
VERSION ?= $(shell cat ./VERSION)
PLATFORMS := windows linux darwin
os = $(word 1, $@)

BIN_DIR := $(GOPATH)/bin
GOMETALINTER := $(BIN_DIR)/gometalinter
GOJUNITREPORT := $(BIN_DIR)/go-junit-report
GODEP := $(BIN_DIR)/dep

$(GOMETALINTER):
	go get -u github.com/alecthomas/gometalinter	
	gometalinter -i

$(GOJUNITREPORT):
	go get -u github.com/jstemmer/go-junit-report

$(GODEP):
	go get -u github.com/golang/dep/cmd/dep	

.PHONY: lint
lint: $(GOMETALINTER)
	gometalinter --disable=gotype --exclude=vendor $(PKGS) ./...

.PHONY: test
test: deps lint $(GOJUNITREPORT)
	mkdir -p ./test-reports
	go test -v $(PKGS) ./... 2>&1 | go-junit-report > ./test-reports/report.xml

.PHONY: deps
deps: $(GODEP)
	go get

.PHONY: $(PLATFORMS)
$(PLATFORMS):
	mkdir -p release
	GOOS=$(os) GOARCH=amd64 go build -o release/$(BINARY)-$(VERSION)-$(os)-amd64 $(ENTRYPOINT)

.PHONY: release
release: deps linux darwin #windows
	cp release/$(BINARY)-$(VERSION)-linux-amd64 release/$(BINARY)-linux

.PHONY: docker
docker:
	@echo "Building and tagging Docker image v$(VERSION)"
	docker build -t $(BINARY):$(VERSION) .