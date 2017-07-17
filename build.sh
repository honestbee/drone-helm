#!/bin/bash

set -ex

export GOOS=linux
export GOARCH=386
go build -o bin/drone-helm
docker build -t drone-helm .
