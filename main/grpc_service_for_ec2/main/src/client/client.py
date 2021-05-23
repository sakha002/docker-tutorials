import sys
import json
import logging
import grpc
from google.protobuf.json_format import ParseDict, MessageToDict
from simple_pb2 import HelloRequest
from simple_pb2_grpc import MygrpcExmplStub


def create_stub(channel):
    stub = MygrpcExmplStub(channel)
    return stub



def greet(channel, name):
    stub = create_stub(channel)
    response = stub.SayHello(HelloRequest(name=name))
    print("Greeter client received: " + response.message)
    return 



if __name__ == '__main__':

    logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(levelname)s - %(message)s',
        )

    if len(sys.argv) > 1:
        target = sys.argv[1]
    else:
        target = '0.0.0.0:5050'

    with grpc.insecure_channel(target) as channel:
        greet(channel, "Bob")


