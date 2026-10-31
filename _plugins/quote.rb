# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'kramdown'

# My module
module Yegor
  # The class
  class QuoteBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      @text = markup.strip
    end

    def render(_context)
      "<aside class='quote'>#{Kramdown::Document.new(@text).to_html.gsub(%r{</?p>}, '')}</aside>\n\n"
    end
  end
end

Liquid::Template.register_tag('quote', Yegor::QuoteBlock)
