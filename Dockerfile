# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM yegor256/rultor-image:1.24.0
LABEL Description="yegor256.com" Vendor="Yegor Bugayenko" Version="1.0"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update --fix-missing && \
  apt-get -y install aspell aspell-en graphviz gnuplot s3cmd fontforge liblapack-dev cmake libxml2-utils shellcheck plantuml && \
  plantuml -version && \
  aspell --version && \
  fontforge --version && \
  gnuplot --version && \
  cmake --version && \
  shellcheck --version

RUN npm install -g eslint@8.44.0 && \
  eslint --version

RUN git clone https://github.com/htacg/tidy-html5.git _tidy-html5 && \
  cd _tidy-html5/build/cmake && \
  git checkout 5.8.0 && \
  cmake ../.. && \
  make && \
  make install && \
  tidy --version

RUN apt-get install -y woff2
COPY _docker/woff.zip /tmp/woff.zip
RUN unzip /tmp/woff.zip -d _sfnt2woff && \
  cd _sfnt2woff && \
  make && \
  cp sfnt2woff /usr/local/bin/ && \
  sfnt2woff --version

RUN npm install -g cssshrink@0.0.5

RUN /bin/bash -l -c "gem update --system && gem install jgd -v 1.13.0"
