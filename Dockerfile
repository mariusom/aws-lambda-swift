FROM amazonlinux:2

RUN yum -y update && \
  yum -y install libatomic libedit gcc gcc-c++ make zlib-devel git zip openssl

ARG SWIFT_VERSION
ADD ./tmp/swift-package-$SWIFT_VERSION.tar.gz /