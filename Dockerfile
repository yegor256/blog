# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM yegor256/latex
LABEL description="yegor256.com"
LABEL vendor="Yegor Bugayenko"
LABEL version="1.0"

SHELL ["/bin/bash", "-e", "-c", "-o", "pipefail"]

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --yes --fix-missing \
  && apt-get install --yes --no-install-recommends \
    aspell=* aspell-en=* \
    graphviz=* gnuplot=* \
    s3cmd=* \
    fontforge=* \
    liblapack-dev=* \
    cmake=* \
    libxml2-utils=* \
    shellcheck=* \
    plantuml=* \
    woff2=* \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && plantuml -version \
  && aspell --version \
  && fontforge --version \
  && gnuplot --version \
  && cmake --version \
  && shellcheck --version

RUN npm install -g eslint@8.44.0 \
  && eslint --version

RUN git clone https://github.com/htacg/tidy-html5.git _tidy-html5 \
  && cd _tidy-html5/build/cmake \
  && git checkout 5.8.0 \
  && cmake ../.. \
  && make \
  && make install \
  && tidy --version

COPY _docker/woff.zip /tmp/woff.zip
RUN unzip /tmp/woff.zip -d _sfnt2woff \
  && cd _sfnt2woff \
  && make \
  && cp sfnt2woff /usr/local/bin/ \
  && sfnt2woff --version

RUN npm install -g cssshrink@0.0.5

RUN /bin/bash -l -c "gem update --system && gem install jgd -v 1.13.0"
