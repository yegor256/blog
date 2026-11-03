# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# My module
module Yegor
  # Index pages with two and three times more posts than the main
  # pagination, so that wide screens, which render the listing in
  # columns, page through the blog in bigger steps.
  class Series < Jekyll::Generator
    safe true
    priority :lowest

    def generate(site)
      home = site.pages.find { |p| p.url == '/' }
      home.data['series'] = [2, 3].to_h do |scale|
        size = site.config['paginate'] * scale
        total = site.posts.docs.size.fdiv(size).ceil
        (2..total).each do |number|
          page = Jekyll::PageWithoutAFile.new(site, site.source, "p#{scale}/#{number}", 'index.html')
          page.data.merge!(
            home.data.slice('description', 'keywords', 'image'),
            'layout' => 'series',
            'title' => "#{home.data['title']} (page ##{number})",
            'sitemap' => false,
            'prefix' => "/p#{scale}",
            'number' => number,
            'total' => total,
            'offset' => size * (number - 1),
            'limit' => size
          )
          site.pages << page
        end
        ["x#{scale}", total]
      end
    end
  end
end
