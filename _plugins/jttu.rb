# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# My module
module Yegor
  # A badge of a JTTU dictionary entry, wrapping Badge.
  class JttuBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      @name = markup.strip
    end

    def render(context)
      Yegor::Badge.new(
        "https://github.com/yegor256/bibliography/blob/master/book-covers/#{@name}.jpg?raw=true",
        'M',
        "https://jttu.net/#{@name}"
      ).render(context)
    end
  end
end

Liquid::Template.register_tag('jttu', Yegor::JttuBlock)
