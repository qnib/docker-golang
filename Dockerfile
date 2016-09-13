FROM qnib/fedora

ARG LIBSODIUM_VER=1.0.10
ARG ZMQ_VER=4.1.4
ARG CZMQ_VER=3.0.1
ENV GOPATH=/usr/local \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/ \
    LD_LIBRARY_PATH=/usr/local/lib
RUN dnf install -y golang make unzip findutils perl-ExtUtils-MakeMaker openssl-devel automake curl-devel expat-devel gettext autoconf python-configobj python-configobj python-mock gcc-c++ libsodium-devel tar
RUN cd /tmp/ \
 && wget -q https://github.com/git/git/archive/master.zip \
 && unzip master.zip \
 && cd git-master \
 && make -j4 \
 && make install \
 && cp ./git /usr/local/bin/
RUN for x in Azure/azure BurntSushi/toml \
             Sirupsen/logrus armon/go aws/aws bugsnag/bugsnag bugsnag/osext \
             bugsnag/panicwrap codegangsta/cli coreos/go denverdino/aliyungo \
             docker/distribution docker/docker docker/go docker/goamz docker/libkv \
             docker/libnetwork docker/libtrust garyburd/redigo godbus/dbus \
             golang/protobuf gorilla/context gorilla/handlers gorilla/mux \
             hashicorp/memberlist inconshreveable/mousetrap influxdata/influxdb \
             jmespath/go kardianos/govendor kr/pty mattn/go microsoft/hcsshim mistifyio/go \
             mitchellh/mapstructure natefinch/npipe ncw/swift opencontainers/runc \
             opencontainers/runtime pquerna/ffjson qnib/qcollect seccomp/libseccomp \
             stevvooe/resumable syndtr/gocapability urfave/cli vishvananda/netlink \
             vishvananda/netns xenolf/lego ;do git clone https://github.com/${x} ${GOPATH}/src/github.com/${x};done
RUN git clone https://github.com/davecheney/profile.git ${GOPATH}/src/github.com/davecheney/profile \
 && git -C ${GOPATH}/src/github.com/davecheney/profile checkout v0.1.0-rc.1
RUN git clone  https://github.com/docker/engine-api ${GOPATH}/src/github.com/docker/engine-api \
 && git -C ${GOPATH}/src/github.com/docker/engine-api checkout release/1.12
#RUN go get golang.org/x/net/context cmd/cover cmd/vet github.com/mattn/gom github.com/stretchr/testify/assert github.com/pkg/errors
# libsodium
#RUN wget -qO - http://download.zeromq.org/zeromq-${ZMQ_VER}.tar.gz |tar xfz - -C /opt/ \
# && cd /opt/zeromq-${ZMQ_VER} \
# && ./configure --with-libsodium \
# && make \
# && make install \
# && wget -qO - http://download.zeromq.org/czmq-${CZMQ_VER}.tar.gz | tar xfz - -C /opt/ \
# && cd /opt/czmq-${CZMQ_VER} \
# && ./configure \
# && make -j2 \
# && make install \
# && cd \
# && rm -rf /opt/zeromq* /opt/czmq* \
# && go get github.com/zeromq/goczmq
