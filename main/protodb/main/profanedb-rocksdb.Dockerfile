FROM buildpack-deps 
# AS rocksdb

ENV INSTALL_PATH /opt/rocksdb
RUN apt-get update -y &&                                                \
    apt-get install -y                                                  \
        libbz2-dev                                                      \
        libgflags-dev                                                   \
        liblz4-dev                                                      \
        libsnappy-dev                                                   \
        # libzstd-dev   Doesn't work during linking for some reason...
        zlib1g-dev                                                    
# RUN wget https://github.com/facebook/rocksdb/archive/refs/tags/v6.20.3.tar.gz && \
#      tar xzvf v6.20.3.tar.gz &&                                          \
#      make -C rocksdb-6.20.3 -j$(nproc) shared_lib &&                     \
#     make -C rocksdb-6.20.3 install DESTDIR=$INSTALL_PATH

RUN  wget https://github.com/facebook/rocksdb/archive/v5.12.4.tar.gz &&  \
    tar xzvf v5.12.4.tar.gz &&                                          \
    make -C rocksdb-5.12.4 -j$(nproc) shared_lib &&                     \
    make -C rocksdb-5.12.4 install

