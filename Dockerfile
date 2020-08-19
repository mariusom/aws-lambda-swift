FROM swift:5.2.5-amazonlinux2

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
  libssl-dev \
  openssl-devel \
  tzdata \
  libtool \
  jq \
  tar \
  zip \
  perf
