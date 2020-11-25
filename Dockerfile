FROM ubuntu:18.04
LABEL maintainer=rgs1<rgs1@uw.edu>

ENV DEBIAN_FRONTEND noninteractive

# base utils to be used inside container
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      libgomp1 \
      openjdk-8-jre-headless \
      python3-minimal \
      wget \
      unzip \
    && wget -nv https://github.com/broadinstitute/gatk/releases/download/4.1.9.0/gatk-4.1.9.0.zip \
    && unzip -q gatk-4.1.9.0.zip -d /root \
    && rm gatk-4.1.9.0.zip \
    && apt-get remove -y wget unzip \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

# create a symlink from python3 to python
RUN /bin/bash -c "ln -s /usr/bin/python3 /usr/bin/python"

# add gatk to PATH
ENV PATH="/root/gatk-4.1.9.0:$PATH"
