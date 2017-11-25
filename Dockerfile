# build stage
FROM golang:1.9.2 AS build-env
ADD . /src
RUN cd /src && \
    go get k8s.io/apimachinery/pkg/api/errors \
	k8s.io/apimachinery/pkg/apis/meta/v1 \
	k8s.io/client-go/kubernetes \
	k8s.io/client-go/rest && \
    go build -o goapp

# final stage
FROM alpine
WORKDIR /app
COPY --from=build-env /src/goapp /app/
ENTRYPOINT ./goapp
