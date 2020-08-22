######################
# Dockerfile for     #
# building a go-tour #
# image for Docker   #
######################

# Set base image to Alpine.
FROM alpine:3.12 AS builder

LABEL maintainer="Dom Rodriguez <shymega@shymega.org.uk>"

# Install toolchain.
RUN apk add --update bash go git mercurial \
    ca-certificates musl-dev \
    && mkdir -v /work
ENV GOPATH /work
WORKDIR $GOPATH

# Build Go tour executable
RUN go get -v -u golang.org/x/tour

# Clean up.
# But keep Go package, and Tour src dir, for
# Tour to work.
RUN apk del --no-cache --rdepends bash git \
 mercurial ca-certificates musl-dev \
 && rm -rf /work/pkg

# Expose port 3999.
EXPOSE 3999

# Run Tour on all addresses for container port bindings to work
CMD ["/work/bin/tour", "-http=0.0.0.0:3999", "-openbrowser=false"]
