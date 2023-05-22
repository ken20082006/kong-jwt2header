FROM alpine:latest

RUN apk update && \
    apk add lua5.4 lua5.4-dev build-base && \
    wget https://luarocks.org/releases/luarocks-3.9.2.tar.gz && \
    tar zxpf luarocks-3.9.2.tar.gz && \
    cd luarocks-3.9.2 && \
    ./configure --lua-version=5.4 && \
    make build && \
    make install

CMD ["tail", "-f", "/dev/null"]