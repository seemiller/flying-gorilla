BINARY_NAME=flying-gorilla

GOOS ?= $(shell go env GOOS)
GOARCH ?= $(shell go env GOARCH)

build:
	GOARCH=amd64 GOOS=darwin go build -o bin/${BINARY_NAME}-darwin-amd64 cmd/main.go
	GOARCH=amd64 GOOS=linux go build -o bin/${BINARY_NAME}-linux-amd64 cmd/main.go

package: build
	tar zcvf pkg/${BINARY_NAME}-darwin-amd64-$${VERSION}.tar.gz -C bin ${BINARY_NAME}-darwin-amd64
	tar zcvf pkg/${BINARY_NAME}-linux-amd64-$${VERSION}.tar.gz -C bin ${BINARY_NAME}-linux-amd64
	cd pkg && shasum -a 256 flying-gorilla-darwin-amd64-$${VERSION}.tar.gz flying-gorilla-linux-amd64-$${VERSION}.tar.gz > checksums.txt

run:
	./bin/${BINARY_NAME}-${GOOS}

build_and_run: build run

clean:
	go clean
	rm bin/${BINARY_NAME}-darwin-amd64
	rm bin/${BINARY_NAME}-linux-amd64
	rm pkg/*
