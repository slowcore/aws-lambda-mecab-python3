#!/bin/sh

mkdir -p artifacts

docker build -t aws-lambda-mecab-python3-packager .
docker run --rm -it -v $(PWD)/artifacts:/var/task/artifacts aws-lambda-mecab-python3-packager
