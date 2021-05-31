FROM python:3.7
RUN pip install protobuf grpcio
COPY ./grpc/examples/python/route_guide .
CMD python route_guide_server.py
EXPOSE 50051