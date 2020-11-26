FROM openjdk:8-jre-alpine
LABEL maintainer=rgs1<rgs1@uw.edu>

ARG GATK_VERSION=4.1.9.0

# base utils to be used inside container
RUN apk add --update --no-cache \
      libc6-compat \
      libgomp \
      python2 \
    && wget https://github.com/broadinstitute/gatk/releases/download/$GATK_VERSION/gatk-$GATK_VERSION.zip \
    && unzip -q gatk-$GATK_VERSION.zip \
    && rm gatk-$GATK_VERSION.zip \
    && cd gatk-$GATK_VERSION \
    && wget https://github.com/broadinstitute/gatk/blob/master/LICENSE.TXT \
    && rm -fr gatkdoc gatk-completion.sh gatkPythonPackageArchive.zip scripts \
      gatkcondaenv.yml GATKConfig.EXAMPLE.properties README.md

RUN ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

WORKDIR /root

# add gatk to PATH
ENV PATH="/gatk-$GATK_VERSION:$PATH"
