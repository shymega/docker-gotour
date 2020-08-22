######################
# Dockerfile for     #
# building a go-tour #
# image for Docker   #
######################

# Set base image to Alpine.
FROM alpine:3.12 AS builder

# Set maintainer.
LABEL maintainer="Dom Rodriguez <shymega@shymega.org.uk>"

RUN apk add --update bash go git mercurial \
    ca-certificates musl-dev \
    && mkdir -p /work

ENV GOPATH /work
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64

RUN go get -v -d golang.org/x/tour
WORKDIR $GOPATH/src/golang.org/x/tour

RUN go build -a -installsuffix cgo -ldflags \
    '-extldflags "-static"' -o /work/tour .

# Clean up compile environment.

USER root
RUN apk del --no-cache --rdepends bash go git \
    mercurial ca-certificates musl-dev && \
    rm -rf /work/pkg /work/bin \
    /work/src/golang.org/x/net \
    /work/src/golang.org/x/tools

# Produce final image.
    FROM scratch

    ENV GOPATH /work
    COPY --from=builder /tmp /tmp
    COPY --from=builder /work /work
    COPY --from=builder /work/tour /work/tour

    EXPOSE 3999
    ENTRYPOINT ["/work/tour", "-http=0.0.0.0:3999"]
