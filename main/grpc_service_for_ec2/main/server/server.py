from concurrent.futures import ThreadPoolExecutor
import logging

import grpc

import simple_pb2
import simple_pb2_grpc


logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
)

class MyCoolServer(simple_pb2_grpc.MygrpcExmplServicer):

    def SayHello(self, request, context):
        return simple_pb2.HelloReply(message='Hello, %s!' % request.name)


def main():
    server = grpc.server(ThreadPoolExecutor(max_workers=200), maximum_concurrent_rpcs=100)
    simple_pb2_grpc.add_MygrpcExmplServicer_to_server(MyCoolServer(), server)
    port = 5050
    server.add_insecure_port(f'[::]:{port}')
    server.start()
    logging.info('Optopy server ready on port %r', port)
    server.wait_for_termination()

if __name__ == "__main__":
    main()
