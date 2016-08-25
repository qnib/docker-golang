FROM qnib/fedora

ARG LIBSODIUM_VER=1.0.10 
ARG ZMQ_VER=4.1.4 
ARG CZMQ_VER=3.0.1 
ENV GOPATH=/usr/local/ \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/ \
    LD_LIBRARY_PATH=/usr/local/lib
RUN dnf install -y golang make automake autoconf git-core python-configobj python-configobj python-mock gcc-c++ libsodium-devel tar
# libsodium
RUN wget -qO - http://download.zeromq.org/zeromq-${ZMQ_VER}.tar.gz |tar xfz - -C /opt/ \
 && cd /opt/zeromq-${ZMQ_VER} \
 && ./configure --with-libsodium \
 && make \
 && make install \
 && wget -qO - http://download.zeromq.org/czmq-${CZMQ_VER}.tar.gz | tar xfz - -C /opt/ \
 && cd /opt/czmq-${CZMQ_VER} \
 && ./configure \
 && make -j2 \
 && make install \
 && cd \
 && rm -rf /opt/zeromq* /opt/czmq* \
 && go get github.com/zeromq/goczmq \
 && go get cmd/vet \
 && go get github.com/docker/engine-api \
 && go get golang.org/x/net/context \
 && go get github.com/buger/goterm \
 && go get github.com/spf13/cobra \
 && go get github.com/spf13/viper \
 && go get -u github.com/kardianos/govendor
