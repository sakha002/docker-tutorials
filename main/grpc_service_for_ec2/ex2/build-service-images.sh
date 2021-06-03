

build() {
    NAME=$1
    IMAGE=grpc-go-$NAME
    FILE=grpc-$NAME.Dockerfile
    echo '--------------------------' building $IMAGE in $(pwd)
    docker build  -f $FILE -t $IMAGE .
}


build server
build client