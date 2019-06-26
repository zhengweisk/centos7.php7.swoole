#!/bin/bash

img="docker.sklinux.com/rd/c7php7:v2019"

docker build  -t "$img" .
#docker push $img
