#!/bin/bash

## Define Variables
IPAddr=`ip -o -4 addr show | awk -F '[ /]+' '/global/ {print $4}'` # This doesn't *need* to have a specific network interface for the moment, we'll see if any bugs arise.

cd /home/gotour/go-tour/
export GOPATH=$(pwd)
bin/gotour -http=$IPAddr:3999
