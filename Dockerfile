######################
# Dockerfile for     #
# building a go-tour #
# image for Docker   #
######################

# Set base image to Alpine.
FROM alpine:3.8 AS builder

# Set maintainer.
LABEL maintainer="Dom Rodriguez <shymega@shymega.org.uk>"

RUN adduser -D -g '' docker \
 && apk add --update bash go git mercurial \
    ca-certificates musl-dev \
  && mkdir -p /docker \
  && chown -R docker:docker /docker

USER docker
ENV GOPATH /docker/gopath

ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64

RUN go get -v golang.org/x/tour/gotour

WORKDIR $GOPATH/src/golang.org/x/tour/gotour

RUN go build -a -installsuffix cgo -ldflags \
  '-extldflags "-static"' -o /docker/gotour .

# Clean up compile environment.

USER root
RUN apk del --no-cache --rdepends bash go git \
 mercurial ca-certificates musl-dev && \
 rm -rf /docker/gopath/pkg /docker/gopath/bin \
 /docker/gopath/src/golang.org/x/net \
 /docker/gopath/src/golang.org/x/tools

# Produce final image.
FROM scratch

ENV GOPATH /docker/gopath
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /tmp /tmp
COPY --from=builder /docker/gopath /docker/gopath
COPY --from=builder /docker/gotour /docker/gotour

USER docker

EXPOSE 3999
ENTRYPOINT ["/docker/gotour", "-http=0.0.0.0:3999"]
