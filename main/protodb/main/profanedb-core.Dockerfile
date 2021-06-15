# FROM alpine:3.6
# # LABEL maintainer giorgio.azzinnaro+profanedb@gmail.com
# ARG GRPC_TAG=v1.7.x
# ENV GRPC_TAG $GRPC_TAG
# RUN apk add --no-cache git curl coreutils pkgconfig libstdc++ g++ autoconf automake make libtool openssl-dev file 
# RUN    git clone --recurse-submodules -b $GRPC_TAG https://github.com/grpc/grpc /tmp/grpc && \
#     cd /tmp/grpc/third_party/protobuf && ./autogen.sh && ./configure && make -j $(nproc --all) && make install && \
#     cd /tmp/grpc && make -j $(nproc --all) && make install && cd / && \
#     rm -rf /tmp/grpc

# # CMD ["protoc"]
# RUN apk add --no-cache cmake boost

# RocksDB is the first dependency
# FROM buildpack-deps AS rocksdb

# ENV INSTALL_PATH /opt/rocksdb
# RUN apt-get update -y &&                                                \
#     apt-get install -y                                                  \
#         libbz2-dev                                                      \
#         libgflags-dev                                                   \
#         liblz4-dev                                                      \
#         libsnappy-dev                                                   \
#         # libzstd-dev   Doesn't work during linking for some reason...
#         zlib1g-dev                                                    
# RUN wget https://github.com/facebook/rocksdb/archive/refs/tags/v6.20.3.tar.gz && \
#      tar xzvf v6.20.3.tar.gz &&                                          \
#      make -C rocksdb-6.20.3 -j$(nproc) shared_lib &&                     \
#     make -C rocksdb-6.20.3 install

# # gRPC installs Protobuf too
# FROM buildpack-deps AS grpc

# RUN apt-get update -y &&   \
#     apt-get install -y  cmake                                             

# ENV prefix /opt/grpc

# RUN mkdir /opt/grpc

# RUN git clone -b v1.38.x https://github.com/grpc/grpc &&    \
#     cd grpc &&                                              \
#     git submodule update --init &&                          \
#     make -j$(nproc) &&                                      \
#     make install &&                                         \
#     make -C third_party/protobuf install prefix=$prefix

# ENV PATH="$MY_INSTALL_DIR/bin:$PATH"

# This last step builds ProfaneDB

FROM profanedb-grpc:1.0.0-rocksdbv6.20.3-grpcv1.38 as grpc
FROM profanedb-rocksdb:1.0.0-rocksdbv6.20.3-grpcv1.38 as rocksdb
FROM buildpack-deps AS builder


# COPY --from=rocksdb /usr/local/include/rocksdb/   /usr/local
# COPY --from=rocksdb /usr/local/lib/librocksdb.a  /usr/local

COPY --from=rocksdb /opt/rocksdb   /usr/local
COPY --from=grpc    /opt/grpc/      /usr/local

# ADD . /profanedb

RUN apt-get update -y &&                \
    apt-get install -y                  \
        cmake                           \
        libboost-dev                    \
        libboost-filesystem-dev         \
        libboost-log-dev                \
        libboost-program-options-dev    \
        libboost-random-dev             \
        libboost-test-dev               \
        libbz2-dev                      \
        libgflags-dev                   \
        liblz4-dev                      \
        libsnappy-dev                   \
        zlib1g-dev                  


RUN git clone --single-branch --branch develop https://gitlab.com/ProfaneDB/ProfaneDB.git && \
    mv /ProfaneDB /profanedb

RUN mkdir /profanedb/build &&           \
    cd /profanedb/build &&              \
    cmake                               \
        -D BUILD_PROFANEDB_SERVER=ON    \
        -D BUILD_TESTS=ON               \
        .. &&                           \
    make -j$(nproc) &&                  \
    make install

VOLUME [ "/var/profanedb/schema" ]

CMD [ "profanedb_server", "-c /usr/local/etc/profanedb/server.conf" ]


