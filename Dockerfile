# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM yegor256/latex:0.0.1
LABEL description="yegor256.com"
LABEL vendor="Yegor Bugayenko"
LABEL version="1.0"

SHELL ["/bin/bash", "-e", "-c", "-o", "pipefail"]

ENV DEBIAN_FRONTEND=noninteractive

COPY .github/ .github/
COPY _docker/ _docker/
RUN .github/install-apt.sh \
  && .github/install-tidy.sh \
  && .github/install-woff.sh \
  && npm install -g cssshrink@0.0.5 \
  && gem install jgd -v 1.13.0

RUN /usr/bin/install-node.sh \
  && npm install -g eslint@8.44.0 \
  && eslint --version
