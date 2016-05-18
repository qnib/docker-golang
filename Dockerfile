FROM qnib/fedora

ENV GOPATH=/usr/local/ \
    LIBSODIUM_VER=1.0.10 \
    ZMQ_VER=4.1.1 \
    CZMQ_VER=3.0.1 \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/
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
 && go get github.com/zeromq/goczmq
