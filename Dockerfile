######################
# Dockerfile for     #
# building a go-tour #
# image for Docker   #
######################

# Set base image
FROM alpine:3.4

# Set maintainer.
MAINTAINER shymega <shymega@shymega.org.uk>

# Go-lang install.
# Update packages and install.
RUN apk add --update golang git

# Create docker container user.
ENV USERNAME docker
ENV GOPATH /docker/gotour

RUN addgroup -S "$USERNAME" \
    && adduser -S "$USERNAME" -h /docker \
    && adduser "$USERNAME" "$USERNAME"

# Set user for the install
USER "$USERNAME"

# Move to GOPATH dir
WORKDIR "$GOPATH"

# Download gotour
RUN go get golang.org/x/tour/gotour

# Expose port
EXPOSE 3999

# Set runtime command
CMD ["/docker/gotour/bin/gotour", "--http=:3999"]
