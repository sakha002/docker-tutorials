FROM buildpack-deps 

# AS grpc

RUN apt-get update -y &&   \
    apt-get install -y  \
    cmake  \
    build-essential \
    autoconf \
    libtool \
    pkg-config 

ENV MY_INSTALL_DIR /opt/grpc

RUN mkdir /opt/grpc

# RUN git clone -b v1.138.x https://github.com/grpc/grpc &&    \
#     cd grpc &&                                              \
#     git submodule update --init &&                          \
#     make -j$(nproc) &&                                      \
#     make install &&                                         \
#     make -C third_party/protobuf install prefix=$prefix

# ENV PATH="$MY_INSTALL_DIR/bin:$PATH"

RUN  git clone --recurse-submodules -b v1.38.0 https://github.com/grpc/grpc

RUN   cd grpc && \
    mkdir -p cmake/build 
    # cmake/build  && \

WORKDIR /grpc/cmkae/build
RUN cmake -DgRPC_INSTALL=ON \
      -DgRPC_BUILD_TESTS=OFF \
      -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
      ../.. && \
    make -j && \
    make install 

WORKDIR /grpc/third_party/abseil-cpp/cmake/
RUN  mkdir -p build && cd build &&\
   cmake -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
      -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE \
      ../.. && \
    make -j && \
    make install 


# RUN cd grpc && \
#     mkdir -p cmake/build && \
#     pushd cmake/build && \
#     cmake -DgRPC_INSTALL=ON &&\
#       -DgRPC_BUILD_TESTS=OFF \
#       -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
#       ../..  &&\
#      make -j &&\
#     make install &&\
#     popd &&\
#     mkdir -p third_party/abseil-cpp/cmake/build &&\
#     pushd third_party/abseil-cpp/cmake/build &&\
#     cmake -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR &&\
#       -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE \
#       ../.. &&\
#     make -j &&\
#     make install &&\
#     popd 
