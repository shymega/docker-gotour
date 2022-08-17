######################
# Dockerfile for     #
# building a go-tour #
# image for Docker   #
######################

# Set base image to Alpine.
FROM docker.io/alpine:latest AS base

FROM base AS app

# Set maintainer.
LABEL maintainer="Dom Rodriguez <shymega@shymega.org.uk>"

RUN apk add --update go git \
    ca-certificates

ENV GOPATH /app

RUN go install -v golang.org/x/website/tour@latest

ENTRYPOINT ["/app/bin/tour", "-http", "0.0.0.0:3999"]
