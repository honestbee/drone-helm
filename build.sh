#!/bin/bash

set -ex

export GOOS=linux
export GOARCH=386
export GIT_COMMIT=$(git rev-parse HEAD)
export DIRTY=$([[ -z $(git diff --shortstat 2> /dev/null) ]] || echo "-dirty")
export REGISTRY="quay.io/honestbee/"
go build -ldflags "-s -w -X main.build=${GIT_COMMIT}${DIRTY}" -o bin/drone-helm
docker build -t drone-helm .
docker tag drone-helm ${REGISTRY}drone-helm:${GIT_COMMIT}${DIRTY}
