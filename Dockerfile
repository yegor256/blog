# Copyright (c) 2014-2024 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so. The Software doesn't include files with .md extension.
# That files you are not allowe
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

FROM yegor256/rultor-image:1.22.0
MAINTAINER Yegor Bugayenko <yegor256@gmail.com>
LABEL Description="yegor256.com" Vendor="Yegor Bugayenko" Version="1.0"

ENV DEBIAN_FRONTEND=noninteractive

RUN sudo apt-get -y update --fix-missing \
  && sudo apt-get -y install aspell aspell-en graphviz gnuplot s3cmd fontforge liblapack-dev cmake plantuml libxml2-utils shellcheck

COPY _docker/plantuml.jar /usr/share/plantuml/plantuml.jar

RUN git clone https://github.com/htacg/tidy-html5.git _tidy-html5 && \
  cd _tidy-html5/build/cmake && \
  git checkout 5.8.0 && \
  cmake ../.. && \
  make && \
  make install

RUN sudo apt-get install -y woff2
COPY _docker/woff.zip /tmp/woff.zip
RUN unzip /tmp/woff.zip -d _sfnt2woff && \
  cd _sfnt2woff && \
  make && \
  cp sfnt2woff /usr/local/bin/

RUN npm install -g cssshrink@0.0.5

RUN /bin/bash -l -c "gem update --system && gem install jgd -v 1.13.0"
