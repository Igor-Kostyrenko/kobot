APP=$(shell basename $(shell git remote get-url origin))
REGISTRY =ghcr.io/${{ github.actor }}
REPOSITORY= ${{ github.actor }}
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
#linux darwin windows
TARGETARCH=arm64
#amd64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kobot -ldflags "-X="github.com/Igor-Kostyrenko/kobot/cmd.appVersion=${VERSION}

# linux:
# 	CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH} go build -v -o kobot -ldflags "-X="github.com/Igor-Kostyrenko/kobot/cmd.appVersion=${VERSION}

# windows:
# 	CGO_ENABLED=0 GOOS=windows GOARCH=${TARGETARCH} go build -v -o kobot -ldflags "-X="github.com/Igor-Kostyrenko/kobot/cmd.appVersion=${VERSION}

# darwin:
# 	CGO_ENABLED=0 GOOS=darwin GOARCH=${TARGETARCH} go build -v -o kobot -ldflags "-X="github.com/Igor-Kostyrenko/kobot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${REPOSITORY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}  --build-arg TARGETOS=${TARGETOS} --build-arg TARGETARCH=${TARGETARCH}  --no-cache

  
push:
	docker push ${REGISTRY}/${REPOSITORY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}


clean:
	rm -rf kobot
	docker rmi ${REGISTRY}/${REPOSITORY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}


