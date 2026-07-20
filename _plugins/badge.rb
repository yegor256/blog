# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'fastimage'

# My module
module Yegor
  # A small clickable image badge, sized from its source.
  class BadgeBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      opts = markup.strip.split(/\s+/, 3)
      @src = opts[0].strip
      @width = opts[1].strip
      @url = opts[2].strip if opts[2]
    end

    def render(context)
      src = Yegor::Img.new(@src, context).to_s
      dims = ''
      if @src.start_with?('/') && !@src.start_with?('//')
        path = File.exist?("./_site#{@src}") ? "./_site#{@src}" : ".#{@src}"
        size = FastImage.size(path) if File.exist?(path)
        if size
          h = (@width.to_i * size[1] / size[0].to_f).round
          dims = "width='#{@width}' height='#{h}' "
        end
      end
      img = "<img #{dims}src='#{src}' " \
            "style='width:#{@width}px;max-width:100%;' alt='badge'/>"
      img = "<a href='#{CGI.escapeHTML @url}'>#{img}</a>" if @url
      "<figure class='badge'>#{img}</figure>\n\n"
    end
  end
end

Liquid::Template.register_tag('badge', Yegor::BadgeBlock)
