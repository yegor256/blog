# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# My module
module Yegor
  # A badge of a JTTU dictionary entry, wrapping BadgeBlock.
  class JttuBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      @name = markup.strip
      @tokens = tokens
    end

    def render(context)
      src = "https://github.com/yegor256/bibliography/blob/master/book-covers/#{@name}.jpg?raw=true"
      url = "https://jttu.net/#{@name}"
      Yegor::BadgeBlock.new('badge', "#{src} 96 #{url}", @tokens).render(context)
    end
  end
end

Liquid::Template.register_tag('jttu', Yegor::JttuBlock)
