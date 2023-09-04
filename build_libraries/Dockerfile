FROM ubuntu:latest AS builder
WORKDIR /root
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean \
    && apt update && DEBIAN_FRONTEND=noninteractive apt install -y wget python3 sudo libpq-dev
ADD https://raw.githubusercontent.com/emp-toolkit/emp-readme/master/scripts/install.py .
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean \
	&& python3 install.py --deps --tool --ot --zk --sh2pc
RUN git clone --branch v1.13.0 https://github.com/google/googletest.git && git clone --branch 7.7.4 https://github.com/jtv/libpqxx.git
WORKDIR googletest
RUN cmake . && make all -j 4 && make install
WORKDIR ../libpqxx
RUN ./configure --disable-documentation --enable-shared CXXFLAGS="-std=c++17 -O2" && make -j 4
RUN make install

FROM alpine:latest
COPY --from=builder /usr/local/lib/ /usr/local/lib/
COPY --from=builder /usr/local/include/ /usr/local/include/
CMD true
