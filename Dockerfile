FROM qnib/fedora

ENV GOPATH=/usr/local/
RUN dnf install -y golang make automake autoconf git-core python-configobj python-configobj python-mock
