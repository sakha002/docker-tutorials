#!/bin/bash


cd /
apt update
export DEBIAN_FRONTEND=noninteractive
apt-get install -y --no-install-recommends tzdata
apt install -yq software-properties-common
add-apt-repository -y ppa:deadsnakes/ppa
apt install -y python3.7

apt-get update && apt-get install -y python3-pip