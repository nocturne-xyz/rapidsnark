#!/bin/bash

set -e

git submodule init
git submodule update
if [[ $(uname -m) == 'arm64' ]]; then
	echo "dected arm64, building using docker buildx..."

    docker buildx build --platform linux/amd64 -t rapidsnark .
else
	docker build -t rapidsnark .
fi
