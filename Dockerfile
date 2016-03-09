FROM qnib/terminal

ENV GOPATH=/usr/local/
RUN dnf install -y git-core golang make
RUN pip install --upgrade pip && \
    pip install mock
