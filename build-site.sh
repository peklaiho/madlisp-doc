#!/bin/sh
docker run \
       --rm \
       --tty \
       -v $(pwd):/app \
       --workdir /app \
       mkdocs-builder
