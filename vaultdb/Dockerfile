ARG token
ARG branch=emp-operators

FROM library-builder AS library-builder 

FROM ubuntu:latest as source
ARG token
ARG branch
WORKDIR /root/sources
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \ 
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean \
    && apt update && apt install -y git
RUN git clone https://${token}@github.com/vaultdb/vaultdb-core.git --branch=${branch} vaultdb
RUN tar -zcvf archive.tar.gz vaultdb/

FROM ubuntu:latest AS builder
COPY --from=library-builder /usr/local/lib/ /usr/local/lib/
COPY --from=library-builder /usr/local/include/ /usr/local/include/
COPY --from=source /root/sources/archive.tar.gz /root/sources/archive.tar.gz
RUN tar -xzvf /root/sources/archive.tar.gz -C /root/sources
RUN apt update && apt install -y rsync cmake build-essential libboost-all-dev libgflags-dev libgmp-dev git ca-certificates libssl-dev libpq-dev
WORKDIR /root/sources/vaultdb/src/main/cpp
RUN cmake -DCMAKE_BUILD_TYPE=Release -Wno-dev . && cmake --build . --config Release -j 2
