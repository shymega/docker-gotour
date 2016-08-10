#!/bin/sh -eu

# Export env vars.
export GOPATH=/home/gotour/go-tour

echo "Create user.."
adduser -h /home/gotour -D gotour
mkdir -p /home/gotour

echo "Install required packages.."
apk-install bash go git mercurial ca-certificates

echo "Create folders.."
mkdir -p $GOPATH

echo "Install Go Tour.."
go get golang.org/x/tour/gotour

echo "Set permissions.."
chown -R gotour:gotour /home/gotour

