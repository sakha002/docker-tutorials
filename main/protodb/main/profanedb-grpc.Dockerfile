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


ENV prefix /opt/grpc


# RUN git clone -b v1.138.x https://github.com/grpc/grpc &&    \
#     cd grpc &&                                              \
#     git submodule update --init &&                          \
#     make -j$(nproc) &&                                      \
#     make install &&                                         \
#     make -C third_party/protobuf install prefix=$prefix

# ENV PATH="$MY_INSTALL_DIR/bin:$PATH"





# RUN  git clone --recurse-submodules -b v1.13.1 https://github.com/grpc/grpc

# # https://github.com/grpc/grpc/archive/refs/tags/v1.13.1.tar.gz
# RUN   cd grpc && \
#     mkdir -p cmake/build 
#     # cmake/build  && \

# WORKDIR /grpc/cmkae/build
# RUN wget https://golang.org/dl/go1.16.5.linux-amd64.tar.gz && \
#     rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.5.linux-amd64.tar.gz &&\
#     export PATH=$PATH:/usr/local/go/bin &&\
#     cmake -DgRPC_INSTALL=ON \
#       -DgRPC_BUILD_TESTS=OFF \
#       -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
#       ../.. && \
#     make -j && \
#     make install prefix=$prefix



# RUN  git clone --recurse-submodules -b v1.11.1 https://github.com/grpc/grpc

# # https://github.com/grpc/grpc/archive/refs/tags/v1.13.1.tar.gz
# RUN   cd grpc && \
#     mkdir -p cmake/build 
#     # cmake/build  && \

# WORKDIR /grpc/cmake/build
# RUN wget https://golang.org/dl/go1.16.5.linux-amd64.tar.gz && \
#     rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.5.linux-amd64.tar.gz &&\
#     export PATH=$PATH:/usr/local/go/bin &&\
#     cmake -DgRPC_INSTALL=ON \
#       -DgRPC_BUILD_TESTS=OFF \
#       -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
#       ../.. && \
#     make -j && \
#     make install && \
#     make -C third_party/protobuf install prefix=$prefix


# RUN  apt install -y apt-transport-https curl gnupg &&\
#     curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg  &&\
#     mv bazel.gpg /etc/apt/trusted.gpg.d/   &&\
#     echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" |  tee /etc/apt/sources.list.d/bazel.list 

# RUN apt update &&  apt install bazel 

RUN  git clone --recurse-submodules -b v1.11.1 https://github.com/grpc/grpc


WORKDIR /grpc/cmake/build
RUN wget https://golang.org/dl/go1.16.5.linux-amd64.tar.gz && \
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.5.linux-amd64.tar.gz &&\
    export PATH=$PATH:/usr/local/go/bin &&\
    cmake -DgRPC_INSTALL=ON \
      -DgRPC_BUILD_TESTS=OFF \
      -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
      ../.. && \
    make -j$(nproc) &&                      \
    make install DESTDIR=$MY_INSTALL_DIR &&                  \
    make -C third_party/protobuf install prefix=$prefix




# WORKDIR /grpc/third_party/abseil-cpp/cmake/
# RUN  mkdir -p build && cd build &&\
#    cmake -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
#       -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE \
#       ../.. && \
#     make -j && \
#     make install 









# root@9aa4597e2bb7:/opt/grpc# ls
# bin  include  lib  share
# root@9aa4597e2bb7:/opt/grpc# cd lib/
# root@9aa4597e2bb7:/opt/grpc/lib# ls
# cmake           libcares.a   libgflags_nothreads.a  libprotobuf.a  libz.a   libz.so.1       pkgconfig
# libbenchmark.a  libgflags.a  libprotobuf-lite.a     libprotoc.a    libz.so  libz.so.1.2.11
# root@9aa4597e2bb7:/opt/grpc/lib# cd ..
# root@9aa4597e2bb7:/opt/grpc# ls
# bin  include  lib  share
# root@9aa4597e2bb7:/opt/grpc# cd include/
# root@9aa4597e2bb7:/opt/grpc/include# ls
# ares.h  ares_build.h  ares_dns.h  ares_rules.h  ares_version.h  benchmark  gflags  google  grpc  grpc++  grpcpp  zconf.h  zlib.h
# root@9aa4597e2bb7:/opt/grpc/include# cd ..
# root@9aa4597e2bb7:/opt/grpc# ls
# bin  include  lib  share
# root@9aa4597e2bb7:/opt/grpc# ls bin
# acountry  adig  ahost  gflags_completions.sh  protoc
# root@9aa4597e2bb7:/opt/grpc# ls share
# grpc  man  pkgconfig
# root@9aa4597e2bb7:/opt/grpc# 



#v1.35

# oot@339cd0812099:/opt/grpc# ls lib
# cmake                                     libabsl_leak_check.a                              libabsl_throw_delegate.a
# libabsl_bad_any_cast_impl.a               libabsl_leak_check_disable.a                      libabsl_time.a
# libabsl_bad_optional_access.a             libabsl_log_severity.a                            libabsl_time_zone.a
# libabsl_bad_variant_access.a              libabsl_malloc_internal.a                         libabsl_wyhash.a
# libabsl_base.a                            libabsl_periodic_sampler.a                        libaddress_sorting.a
# libabsl_city.a                            libabsl_random_distributions.a                    libcares.a
# libabsl_civil_time.a                      libabsl_random_internal_distribution_test_util.a  libcrypto.a
# libabsl_cord.a                            libabsl_random_internal_platform.a                libgpr.a
# libabsl_debugging_internal.a              libabsl_random_internal_pool_urbg.a               libgrpc++.a
# libabsl_demangle_internal.a               libabsl_random_internal_randen.a                  libgrpc++_alts.a
# libabsl_examine_stack.a                   libabsl_random_internal_randen_hwaes.a            libgrpc++_error_details.a
# libabsl_exponential_biased.a              libabsl_random_internal_randen_hwaes_impl.a       libgrpc++_reflection.a
# libabsl_failure_signal_handler.a          libabsl_random_internal_randen_slow.a             libgrpc++_unsecure.a
# libabsl_flags.a                           libabsl_random_internal_seed_material.a           libgrpc.a
# libabsl_flags_commandlineflag.a           libabsl_random_seed_gen_exception.a               libgrpc_plugin_support.a
# libabsl_flags_commandlineflag_internal.a  libabsl_random_seed_sequences.a                   libgrpc_unsecure.a
# libabsl_flags_config.a                    libabsl_raw_hash_set.a                            libgrpcpp_channelz.a
# libabsl_flags_internal.a                  libabsl_raw_logging_internal.a                    libprotobuf-lite.a
# libabsl_flags_marshalling.a               libabsl_scoped_set_env.a                          libprotobuf.a
# libabsl_flags_parse.a                     libabsl_spinlock_wait.a                           libprotoc.a
# libabsl_flags_private_handle_accessor.a   libabsl_stacktrace.a                              libre2.a
# libabsl_flags_program_name.a              libabsl_status.a                                  libssl.a
# libabsl_flags_reflection.a                libabsl_statusor.a                                libupb.a
# libabsl_flags_usage.a                     libabsl_str_format_internal.a                     libz.a
# libabsl_flags_usage_internal.a            libabsl_strerror.a                                libz.so
# libabsl_graphcycles_internal.a            libabsl_strings.a                                 libz.so.1
# libabsl_hash.a                            libabsl_strings_internal.a                        libz.so.1.2.11
# libabsl_hashtablez_sampler.a              libabsl_symbolize.a                               pkgconfig
# libabsl_int128.a                          libabsl_synchronization.a
# root@339cd0812099:/opt/grpc# ls 
# bin  include  lib  share
# root@339cd0812099:/opt/grpc# ls bin
# acountry  ahost            grpc_csharp_plugin  grpc_objective_c_plugin  grpc_python_plugin  protoc
# adig      grpc_cpp_plugin  grpc_node_plugin    grpc_php_plugin          grpc_ruby_plugin    protoc-3.15.8.0
# root@339cd0812099:/opt/grpc# ls include/
# absl  ares.h  ares_build.h  ares_dns.h  ares_rules.h  ares_version.h  google  grpc  grpc++  grpcpp  re2  zconf.h  zlib.h
# root@339cd0812099:/opt/grpc# 