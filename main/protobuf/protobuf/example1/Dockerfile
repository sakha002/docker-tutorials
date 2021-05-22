FROM ubuntu

RUN apt-get update -y 
RUN apt-get install -y git wget build-essential curl

COPY ./install_python.sh .
RUN ./install_python.sh

RUN apt-get install -y zip
COPY ./get_protobuf.sh .

RUN ./get_protobuf.sh

COPY ./todolist.proto .
COPY ./compile_proto.sh .


RUN pip3 install protobuf
RUN ./compile_proto.sh


COPY ./todolist.py .


