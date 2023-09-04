FROM ubuntu:latest
WORKDIR /root
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean \
    && apt update && DEBIAN_FRONTEND=noninteractive apt install -y cmake build-essential rsync libboost-all-dev libgflags-dev libgmp-dev git ca-certificates libssl-dev libpq-dev
CMD ["sleep", "infinity"]
