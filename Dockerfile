# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install build-essential autoconf clang automake autopoint gettext intltool libgmp3-dev libmpfr-dev libtool libcurl4-gnutls-dev pkg-config icu-devtools libicu-dev libxml2-dev -y && rm -rf /var/lib/apt/lists/*

## Add source code to the build stage.
ADD . /libqalculate
WORKDIR /libqalculate

## Build qalc.
# ENV CC gcc
# ENV CXX g++
RUN ./autogen.sh && make && make install && ldconfig && clang++ -I/usr/include/x86_64-linux-gnu -I/usr/local/include -I/usr/include/libxml2 -L/usr/local/lib -lqalculate -fsanitize=fuzzer fuzz/fuzz.cpp -o fuzz/fuzz
# RUN make
# RUN make install
# RUN ldconfig


# # Package Stage
FROM --platform=linux/amd64 ubuntu:20.04
# RUN apt-get update && \
#     DEBIAN_FRONTEND=noninteractive apt-get install libiconv-hook1 gettext -y


# # ## TODO: Change <Path in Builder Stage>
COPY --from=builder /libqalculate /libqalculate
WORKDIR /libqalculate
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install libcurl4-gnutls-dev libxml2-dev libgmp3-dev libmpfr-dev -y && rm -rf /var/lib/apt/lists/* && ./docker_install.sh && ldconfig && mv fuzz/fuzz /
WORKDIR /
RUN rm -rf /libqalculate