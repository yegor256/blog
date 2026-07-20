# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'fastimage'

# My module
module Yegor
  # A small clickable image badge, sized from its source.
  class Badge
    def initialize(src, size, url = nil)
      @src = src
      @size = size
      @url = url
    end

    def render(context)
      src = Yegor::Img.new(@src, context).to_s
      rem = width
      dims = ''
      if @src.start_with?('/') && !@src.start_with?('//')
        path = File.exist?("./_site#{@src}") ? "./_site#{@src}" : ".#{@src}"
        size = FastImage.size(path) if File.exist?(path)
        if size
          px = (rem * 16).round
          h = (px * size[1] / size[0].to_f).round
          dims = "width='#{px}' height='#{h}' "
        end
      end
      img = "<img #{dims}src='#{src}' " \
            "style='width:#{rem}rem;max-width:100%;' alt='badge'/>"
      img = "<a href='#{CGI.escapeHTML @url}'>#{img}</a>" if @url
      "<figure class='badge'>#{img}</figure>\n\n"
    end

    private

    def width
      { 'XS' => 3, 'S' => 4.25, 'M' => 6, 'L' => 8.5, 'XL' => 12, 'XXL' => 17 }
        .fetch(@size.upcase) { raise "Unknown badge size #{@size.inspect}" }
    end
  end

  # The Liquid tag for a badge.
  class BadgeBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      opts = markup.strip.split(/\s+/, 3)
      @src = opts[0].strip
      @size = opts[1].strip
      @url = opts[2].strip if opts[2]
    end

    def render(context)
      Yegor::Badge.new(@src, @size, @url).render(context)
    end
  end
end

Liquid::Template.register_tag('badge', Yegor::BadgeBlock)
