# Copyright (c) 2014-2017 Yegor Bugayenko
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

module Yegor
  module Filters
    def book(book)
      opts = book.strip.split(/\s+/, 2)
      link = 'http://goo.gl/W2WVMk'
      "<aside class='book'>" \
      "<a href='#{link}'>" \
      "<img src='/images/books/elegant-objects/cover.png' class='book-cover'/>" \
      "</a>" \
      "Read more about this subject in " \
      "<a href='#{link}'>Section&nbsp;#{opts[1]}</a><br/>" \
      " of my book" \
      "<a href='#{link}'><img src='/images/books/amazon-buy-button.png' class='amazon-button'/></a>" \
      "</aside>"
    end
  end
end

Liquid::Template.register_filter(Yegor::Filters)
