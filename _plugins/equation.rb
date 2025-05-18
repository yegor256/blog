# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# My module
module Yegor
  # The class
  class EqtnBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      @tex = markup.strip
    end

    def render(_context)
      "<img src='http://latex.codecogs.com/svg.image?#{CGI.escape(@tex).gsub('+',
                                                                             '%20')}' class='eqtn' alt='equation'/>"
    end
  end
end

Liquid::Template.register_tag('eqtn', Yegor::EqtnBlock)
