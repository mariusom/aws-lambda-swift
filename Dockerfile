FROM swiftlang/swift:nightly-amazonlinux2

RUN yum -y update && \
  yum -y install \
  libatomic \
  gcc \ 
  gcc-c++ \ 
  make \ 
  zlib-devel \
  git \
  libuuid-devel \
  libicu-devel \
  libedit-devel \
  libxml2-devel \
  sqlite-devel \
  python-devel \
  ncurses-devel \
  curl-devel \
  openssl-devel \
  tzdata \
  libtool \
  jq \
  tar \
  zip \
  perf
