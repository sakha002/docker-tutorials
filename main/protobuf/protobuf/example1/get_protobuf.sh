#!/bin/bash


PROTOC_ZIP=protoc-3.13.0-linux-x86_64.zip
wget https://github.com/protocolbuffers/protobuf/releases/download/v3.13.0/$PROTOC_ZIP
unzip -o $PROTOC_ZIP -d /usr/local bin/protoc
unzip -o $PROTOC_ZIP -d /usr/local 'include/*'
rm -f $PROTOC_ZIP
