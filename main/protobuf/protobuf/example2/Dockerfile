FROM ubuntu

ADD ./install_python.sh .
RUN ./install_python.sh

ADD ./get_ortools_proto.sh .
RUN ./get_ortools_proto.sh 

ADD ./install_protobuf_compiler.sh .
RUN ./install_protobuf_compiler.sh

ADD ./mip.proto ./operations_research/
RUN python3 -m grpc_tools.protoc -I operations_research --python_out=. --grpc_python_out=. operations_research/*.proto


ADD ./mip_client.py  .
