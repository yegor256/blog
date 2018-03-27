# Copyright (c) 2014-2018 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so. The Software doesn't include files with .md extension.
# That files you are not allowed to copy, distribute, modify, publish, or sell.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

FROM yegor256/rultor
MAINTAINER Yegor Bugayenko <yegor256@gmail.com>
LABEL Description="yegor256.com" Vendor="Yegor Bugayenko" Version="1.0"

ENV DEBIAN_FRONTEND noninteractive

RUN sudo apt-get -y update
RUN sudo apt-get -y install aspell aspell-en build-essential graphviz gnuplot s3cmd fontforge liblapack-dev

ADD https://raw.githubusercontent.com/yegor256/blog/master/_docker/install.sh /tmp/
RUN /bin/bash /tmp/install.sh
RUN sudo apt-get -y update
RUN sudo apt-get install -y libxml2-utils

RUN npm install -g cssshrink@0.0.5

RUN /bin/bash -l -c "gem install --no-ri --no-rdoc jgd -v 1.6.5"

