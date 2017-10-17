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

require 'date'
module Yegor
  module Modified
    def modified(page)
      path = page['path']
      count = `git rev-list HEAD --count #{path}`.strip.to_i
      if count > 1
        date = Time.parse(`git log -n 1 --date=iso --format=%ad #{path}`.strip)
        if date > page['date']
          "<li class='unprintable desktop-only'><a href='https://github.com/yegor256/blog/commits/master/#{path}'>Modified</a>\
          on <time itemprop='dateModified' datetime='#{date.strftime('%Y-%m-%dT%H:%M:%S%z')}'>#{date.strftime('%-d %B %Y')}</time></li>"
        end
      end
      print '.'
    end
  end
end

Liquid::Template.register_filter(Yegor::Modified)
