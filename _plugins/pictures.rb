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
  class Img
    def initialize(src, ctx)
      if src.index('/') == 0 && src.index('//') != 0
        @url = src
        raise "file doesn't exist: #{src}" unless
          File.exists?('./_site' + src) ||
          File.exists?('.' + src) ||
          src =~ /gnuplot/
      else
        @url = src
      end
    end
    def to_s
      CGI.escapeHTML(@url)
    end
  end

  class FigureBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      opts = markup.strip.split(/\s+/, 3)
      @src = opts[0].strip
      @width = opts[1].strip
    end

    def render(context)
      uri = Yegor::Img.new(@src, context).to_s
      attrs = "itemprop='image' style='width:#{@width}px;max-width:100%;' alt='The figure'"
      html = if uri.end_with?('.svg')
        "<object data='#{uri}' type='image/svg+xml' #{attrs}></object>"
      else
        "<img src='#{uri}' #{attrs}/>"
      end
      "<figure class='unprintable'>#{html}</figure>"
    end
  end

  class BadgeBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      opts = markup.strip.split(/\s+/, 3)
      @src = opts[0].strip
      @width = opts[1].strip
      if opts[2]
        @url = opts[2].strip
      end
    end

    def render(context)
      img = "<img src='#{Yegor::Img.new(@src, context)}'" +
        " style='width:#{@width}px;max-width:100%;' alt='badge'/>"
      if @url
        img = "<a href='#{CGI.escapeHTML @url}'>#{img}</a>"
      end
      html = "<figure class='badge'>#{img}</figure>\n\n"
    end
  end

  class PictureBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      opts = markup.strip.split(/\s+/, 3)
      @src = opts[0].strip
      @width = opts[1].nil? ? '0' : opts[1].strip
      if @width == '0'
        @width = '600'
      end
      @title = opts[2].nil? ? '' : opts[2].strip
    end

    def render(context)
      alt = @title.gsub(/[ \n\r\t]+/, ' ')
        .gsub(/&/, '&amp;')
        .gsub(/"/, '&quot;')
        .gsub(/'/, '&apos;')
        .gsub(/</, '&lt;')
        .gsub(/>/, '&gt;')
      alt = 'picture' if alt.empty?
      html = "<figure class='picture'><img src='#{Yegor::Img.new(@src, context)}'" +
        " style='width:#{@width}px;max-width:100%;' alt='#{CGI.escapeHTML(alt)}'/>"
      if @title != ''
        html += "<figcaption>#{CGI::escapeHTML @title}</figcaption>"
      end
      html += "</figure>\n\n"
    end
  end
end

Liquid::Template.register_tag('figure', Yegor::FigureBlock)
Liquid::Template.register_tag('badge', Yegor::BadgeBlock)
Liquid::Template.register_tag("picture", Yegor::PictureBlock)
