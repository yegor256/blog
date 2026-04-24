# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'date'
require 'shellwords'

# My module
module Yegor
  # Module
  module Modified
    def modified(page)
      path = page['path']
      escaped = Shellwords.escape(path)
      count = `git rev-list HEAD --count #{escaped}`.strip.to_i
      return '' if count <= 1
      date = Time.parse(`git log -n 1 --date=iso --format=%ad #{escaped}`.strip)
      return '' if date <= page['date']
      "<li class='unprintable desktop-only'><a href='https://github.com/yegor256/blog/commits/master/#{path}'>Modified</a>\
      on <time itemprop='dateModified' datetime='#{date.strftime('%Y-%m-%dT%H:%M:%S%z')}'>#{date.strftime('%-d %B %Y')}</time></li>"
    end
  end
end

Liquid::Template.register_filter(Yegor::Modified)
