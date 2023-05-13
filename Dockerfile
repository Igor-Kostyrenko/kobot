FROM golang:1.19 as builder

ARG TARGETARCH

ARG TARGETOS

WORKDIR /go/src/app
COPY . .
RUN make build TARGETOS=${TARGETOS} TARGETARCH=${TARGETARCH}

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/kobot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./kobot"]