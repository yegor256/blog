# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# My module
module Yegor
  # The class
  class Img
    def initialize(src, _ctx)
      if src.index('/').zero? && src.index('//') != 0
        @url = src
        raise "File doesn't exist: #{src}" unless
          File.exist?("./_site#{src}") ||
          File.exist?(".#{src}") ||
          src =~ /gnuplot/
      else
        @url = src
      end
    end

    def to_s
      CGI.escapeHTML(@url)
    end
  end

  # The class
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

  # The class
  class BadgeBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      opts = markup.strip.split(/\s+/, 3)
      @src = opts[0].strip
      @width = opts[1].strip
      @url = opts[2].strip if opts[2]
    end

    def render(context)
      img = "<img src='#{Yegor::Img.new(@src, context)}' " \
            "style='width:#{@width}px;max-width:100%;' alt='badge'/>"
      img = "<a href='#{CGI.escapeHTML @url}'>#{img}</a>" if @url
      "<figure class='badge'>#{img}</figure>\n\n"
    end
  end

  # The class
  class PictureBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      opts = markup.strip.split(/\s+/, 3)
      @src = opts[0].strip
      @width = opts[1].nil? ? '0' : opts[1].strip
      @width = '600' if @width == '0'
      @title = opts[2].nil? ? '' : opts[2].strip
    end

    def render(context)
      alt = @title.gsub(/[ \n\r\t]+/, ' ')
        .gsub('&', '&amp;')
        .gsub('"', '&quot;')
        .gsub("'", '&apos;')
        .gsub('<', '&lt;')
        .gsub('>', '&gt;')
      alt = 'picture' if alt.empty?
      html = "<figure class='picture'><img src='#{Yegor::Img.new(@src, context)}' " \
             "style='width:#{@width}px;max-width:100%;' alt='#{CGI.escapeHTML(alt)}'/>"
      html += "<figcaption>#{CGI.escapeHTML @title}</figcaption>" if @title != ''
      "#{html}</figure>\n\n"
    end
  end
end

Liquid::Template.register_tag('figure', Yegor::FigureBlock)
Liquid::Template.register_tag('badge', Yegor::BadgeBlock)
Liquid::Template.register_tag('picture', Yegor::PictureBlock)
