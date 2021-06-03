FROM golang:alpine AS build-env



RUN apk update && apk add protoc 
RUN apk update && apk add make

RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.26 && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1

ENV PATH="$PATH:$(go env GOPATH)/bin"


WORKDIR /home
COPY helloworld/ ./helloworld
COPY greeter_server/ greeter_server
RUN cd helloworld &&  make proto_server
   

RUN mkdir /app


WORKDIR /home/greeter_server

RUN cp -r ./*  ../../app

WORKDIR /app
RUN apk add git
RUN go mod download

RUN go get google.golang.org/grpc/examples/helloworld/helloworld
RUN go get google.golang.org/grpc@v1.36.0
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o /go/bin/app


FROM alpine

RUN apk update && apk upgrade && \
     apk add apache2 && \
     rm -rf /var/cache/apk/*



RUN mkdir /var/www/html && echo '<h1> gRPC Service Ready on Port 50051.</h1>' > /var/www/html/index.html 
# chkconfig httpd on

COPY ./startup.sh .
RUN chmod +x /startup.sh

COPY --from=build-env /go/bin/app /go/bin/app

CMD ["/bin/sh", "./startup.sh" ]

EXPOSE 50051 80