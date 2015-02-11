####################
# Dockerfile for   #
# building go-tour #
# image for Docker #
####################

# Set base image to golang:1.3
FROM gliderlabs/alpine

# I made this!
MAINTAINER shymega <shymega@shymega.org.uk>

# Create go-tour user for added security
RUN mkdir -p /home/gotour && adduser -h /home/gotour -D gotour

# Download Go, bash, git, mercurial and ca-certificates && gotour
RUN apk-install bash go git mercurial ca-certificates && mkdir /home/gotour/go-tour && export GOPATH=/home/gotour/go-tour && go get code.google.com/p/go-tour/gotour

# Add run.sh
ADD ./run.sh /home/gotour/go-tour/run.sh

# Make gotour own home dir
RUN chown -R gotour /home/gotour

# Set cmd on run and run as gotour
USER gotour
CMD ["/home/gotour/go-tour/run.sh"]
