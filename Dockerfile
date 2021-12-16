ARG from
FROM ${from}

ENV CMAKE_VERSION=3.20.5

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget build-essential libssl-dev && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean -y --no-install-recommends && \
    apt-get autoclean -y --no-install-recommends

RUN cd /home/ && \
    wget --no-check-certificate https://cmake.org/files/v$(echo $CMAKE_VERSION | sed "s/\.[0-9][0-9]*$//g")/cmake-${CMAKE_VERSION}.tar.gz && \
    tar xf cmake-${CMAKE_VERSION}.tar.gz && rm cmake-${CMAKE_VERSION}.tar.gz && cd /home/cmake-${CMAKE_VERSION} && \
    ./bootstrap --parallel=$(nproc) && \
    make -j$(nproc) && \
    make install && \
    rm -rf /home/cmake-${CMAKE_VERSION}
