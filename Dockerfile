# syntax=docker/dockerfile:1
# Using https://github.com/syncguy/go-legacy-winxp

FROM golang:1.24.4-bookworm AS builder

# Installing build deps
RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates build-essential python3 mingw-w64 && rm -rf /var/lib/apt/lists/*

WORKDIR /src

RUN git clone --filter=blob:none --no-checkout "https://github.com/syncguy/go-legacy-winxp" go-legacy-winxp \
  && cd go-legacy-winxp \
  && git fetch --tags --force \
  && git checkout winxp-compat \
  && git submodule update --init --recursive || true

WORKDIR /src/go-legacy-winxp

ENV GOROOT_BOOTSTRAP=/usr/local/go
RUN cd src && ./make.bash

# Building the final image
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates mingw-w64 && rm -rf /var/lib/apt/lists/*
COPY --from=builder /src/go-legacy-winxp /opt/go-legacy-winxp

ENV GOROOT=/opt/go-legacy-winxp
ENV PATH="${GOROOT}/bin:${PATH}"

ENV GOOS=windows
ENV GOARCH=386
# ENV GO386=387 # For CPU without SSE2

ENV CGO_ENABLED=1
ENV CC=i686-w64-mingw32-gcc
ENV CXX=i686-w64-mingw32-g++

WORKDIR /work
CMD ["go", "version"]
