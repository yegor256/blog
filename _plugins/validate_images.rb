# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# Jekyll module
module Jekyll
  # The class
  class StatsGenerator < Generator
    priority :high
    safe true
    def generate(site)
      site.posts.docs.each do |doc|
        puts "WARN: No front image in #{doc.url}" unless doc['image']
      end
    end
  end
end
