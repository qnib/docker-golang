FROM qnib/terminal

ENV GOPATH=/root/
RUN yum install -y git-core golang
