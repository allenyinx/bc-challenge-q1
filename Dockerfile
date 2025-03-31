FROM ubuntu:22.04@sha256:ed1544e454989078f5dec1bfdabd8c5cc9c48e0705d07b678ab6ae3fb61952d2

LABEL com.bcchalledge.version="0.0.1"
LABEL author="Allen Yin"
LABEL com.bcchalledge.release-date="2025-03-31"

ENV BC_BINARY=chain-main
ENV BC_VERSION=4.2.14
ENV BC_PLATFORM=Linux
ENV BC_ARCH=x86_64
ENV BC_DOWNLOAD=https://github.com/crypto-org-chain/chain-main/releases/download

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /node

# Install Crypto.org binaries
RUN wget ${BC_DOWNLOAD}/v${BC_VERSION}/${BC_BINARY}_${BC_VERSION}_${BC_PLATFORM}_${BC_ARCH}.tar.gz \
    && tar -zxvf ${BC_BINARY}_${BC_VERSION}_${BC_PLATFORM}_${BC_ARCH}.tar.gz \
    && mv bin/* /usr/local/bin/ \
    && rm -rf bin ${BC_BINARY}_${BC_VERSION}_${BC_PLATFORM}_${BC_ARCH}.tar.gz

COPY init.sh /root/init.sh
RUN chmod +x /root/init.sh

EXPOSE 26657 1317

VOLUME /root/.chain-maind

ENTRYPOINT ["/root/init.sh"]