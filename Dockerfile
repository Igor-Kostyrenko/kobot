FROM golang:1.19 as builder

ARG TARGETARCH

WORKDIR /go/src/app
COPY . .
RUN make build

/workspaces/kobot/cmdFROM scratch
WORKDIR /
COPY --from=builder /go/src/app/kobot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./kobot"]