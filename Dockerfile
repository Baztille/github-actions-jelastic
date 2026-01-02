FROM eclipse-temurin:17-jdk-alpine

LABEL maintainer="dovnar.alexander@gmail.com"

RUN apk add --no-cache curl bash jq && \
    rm -vrf /var/cache/apk/*

ENV USER=docker
ENV _UID=12345
ENV _GID=23456

RUN mkdir /cli && \
    addgroup --gid "$_GID" --system "$USER" && \
    adduser --disabled-password --gecos "" --home /cli \
    --ingroup "$USER" --uid "$_UID" "$USER" && \
    chown $USER:$USER /cli

WORKDIR /cli
USER docker

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN curl -s ftp://ftp.jelastic.com/pub/cli/jelastic-cli-installer.sh | bash

COPY entrypoint.sh /cli/entrypoint.sh
COPY entrypoint-github.sh /cli/entrypoint-github.sh

ENTRYPOINT ["/cli/entrypoint.sh"]
