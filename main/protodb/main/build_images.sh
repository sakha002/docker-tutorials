#!/bin/bash

# TAG=1.0.0-rocksdbv6.20.3-grpcv1.11.1

TAG=1.0.0


build() {
    NAME=$1
    IMAGE=profanedb-$NAME:$TAG
    FILE=profanedb-$NAME.Dockerfile
    echo '--------------------------' building $IMAGE in $(pwd)
    docker build  -f $FILE -t $IMAGE .
}

#

# build base
# build namenode
# build datanode
# build filebrowser

# build÷ rocksdb
# build grpc
# build core
build wrap
