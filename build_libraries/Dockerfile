FROM ubuntu:latest
WORKDIR /root
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y wget python3 sudo libpq-dev
RUN wget https://raw.githubusercontent.com/emp-toolkit/emp-readme/master/scripts/install.py
RUN python3 install.py --deps --tool --ot --zk --sh2pc
RUN git clone --branch v1.13.0 https://github.com/google/googletest.git
RUN git clone --branch 7.7.4 https://github.com/jtv/libpqxx.git
WORKDIR googletest
RUN cmake .
RUN make all -j 4
RUN make install
WORKDIR ../libpqxx
RUN ./configure --disable-documentation --enable-shared CXXFLAGS="-std=c++17 -O2"
RUN make -j 4
CMD make install
