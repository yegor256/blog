# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# Jekyll module
module Jekyll
  # The class
  class DateValidateGenerator < Generator
    priority :low
    safe true
    def generate(site)
      site.posts.docs.each do |post|
        prefix = post.date.strftime('_posts/%Y/%b/%Y-%m-%d-').downcase
        path = post.relative_path
        next unless path.index('_drafts/').nil?
        next if path.index(prefix).zero?
        raise "Wrong path of '#{path}', it has to start with #{prefix}"
      end
    end
  end
end
