FROM ubuntu:18.04
LABEL maintainer="contact@dziurdziak.pl"

ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="contact@dziurdziak.pl" \
  org.opencontainers.image.url="https://github.com/mateusz-dziurdziak/megacmd-docker" \
  org.opencontainers.image.documentation="https://github.com/mateusz-dziurdziak/megacmd-docker/blob/main/README.md" \
  org.opencontainers.image.source="https://github.com/mateusz-dziurdziak/megacmd-docker.git" \
  org.opencontainers.image.revision=$VCS_REF \
  org.opencontainers.image.licenses="Apache-2.0" \
  org.opencontainers.image.title="Dockerized MEGAcmd" \
  org.opencontainers.image.description="MEGAcmd build from scratch running inside container"

ENV LD_LIBRARY_PATH="/usr/local/lib:${LD_LIBRARY_PATH}"

RUN apt-get update && apt-get install -y \
  autoconf \
  libtool \
  g++ \
  libcrypto++-dev \
  libz-dev \
  libsqlite3-dev \
  libssl-dev \
  libcurl4-gnutls-dev \
  libreadline-dev \
  libpcre++-dev \
  libsodium-dev \
  libc-ares-dev \
  libfreeimage-dev \
  libavcodec-dev \
  libavutil-dev \
  libavformat-dev \
  libswscale-dev \
  libmediainfo-dev \
  libzen-dev \
  libuv1-dev \
  wget \
  git \
  build-essential \
  && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/meganz/MEGAcmd.git

WORKDIR /MEGAcmd

RUN git submodule update --init --recursive

RUN sh autogen.sh && ./configure && make && make install

WORKDIR /

ENTRYPOINT ["/usr/local/bin/mega-cmd"]
