FROM ubuntu:18.04
LABEL maintainer=rgs1<rgs1@uw.edu>

ARG GATK_VERSION=4.1.9.0

# base utils to be used inside container
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      libgomp1 \
      openjdk-8-jre-headless \
      python3-minimal \
      wget \
      unzip \
    && wget -nv https://github.com/broadinstitute/gatk/releases/download/$GATK_VERSION/gatk-$GATK_VERSION.zip \
    && unzip -q gatk-$GATK_VERSION.zip -d /root \
    && rm gatk-$GATK_VERSION.zip \
    && apt-get purge -y wget unzip \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

# create a symlink from python3 to python
RUN /bin/bash -c "ln -s /usr/bin/python3 /usr/bin/python"

# add gatk to PATH
ENV PATH="/root/gatk-$GATK_VERSION:$PATH"
