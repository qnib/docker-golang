FROM qnib/fedora

ARG LIBSODIUM_VER=1.0.10
ARG ZMQ_VER=4.1.4
ARG CZMQ_VER=3.0.1
ENV GOPATH=/usr/local \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/ \
    LD_LIBRARY_PATH=/usr/local/lib
RUN dnf install -y bc golang make unzip findutils perl-ExtUtils-MakeMaker openssl-devel automake curl-devel expat-devel gettext autoconf python-configobj python-configobj python-mock gcc-c++ libsodium-devel tar gnuplot
RUN dnf install -y git
#RUN for x in Azure/azure BurntSushi/toml \
#             Sirupsen/logrus armon/go aws/aws bugsnag/bugsnag bugsnag/osext \
#             bugsnag/panicwrap codegangsta/cli coreos/go denverdino/aliyungo \
#             docker/distribution docker/docker docker/go docker/goamz docker/libkv \
#             docker/libnetwork docker/libtrust garyburd/redigo godbus/dbus \
#             golang/protobuf gorilla/context gorilla/handlers gorilla/mux \
#             hashicorp/memberlist inconshreveable/mousetrap influxdata/influxdb \
#             jmespath/go kardianos/govendor kr/pty mattn/gom microsoft/hcsshim mistifyio/go \
#             mitchellh/mapstructure natefinch/npipe ncw/swift opencontainers/runc \
#             opencontainers/runtime pquerna/ffjson qnib/qcollect seccomp/libseccomp \
#             stevvooe/resumable syndtr/gocapability urfave/cli vishvananda/netlink \
#             vishvananda/netns xenolf/lego ;do git clone https://github.com/${x} ${GOPATH}/src/github.com/${x};done
RUN go get -d github.com/mattn/gom github.com/docker/go-connections \
 && go install github.com/mattn/gom
RUN go get -d github.com/docker/go-units github.com/docker/go-units github.com/pkg/errors golang.org/x/net/context github.com/stretchr/testify
RUN go get -d github.com/prometheus/client_model/go
RUN go get github.com/qnib/prom2json
RUN go get -u github.com/kardianos/govendor
RUN go get github.com/axw/gocov/gocov
RUN go get github.com/chouquette/coveraggregator
RUN go get github.com/stretchr/testify/assert
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
