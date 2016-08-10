#!/bin/bash

export GOPATH=/home/gotour/go-tour
cd "$GOPATH" || exit 1
$GOPATH/bin/gotour -http=:3999
