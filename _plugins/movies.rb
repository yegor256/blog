# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'kramdown'

# My module
module Yegor
  # The class
  module MovieFilters
    def yb_movies_count(posts)
      with_movies(posts).size
    end

    def yb_movies(posts)
      with_movies(posts).map do |p|
        "<p><a href='#{p.url}'>#{Kramdown::Document.new(p['jb_picture']['caption']).to_html.gsub(%r{</?p>},
                                                                                                 '')}</a></p>"
      end
    end

    private

    def with_movies(posts)
      posts
        .select { |p| p['jb_picture'] && p['jb_picture']['caption'] }
        .uniq { |p| p['jb_picture']['caption'] }
        .sort { |a, b| a['jb_picture']['caption'] <=> b['jb_picture']['caption'] }
    end
  end
end

Liquid::Template.register_filter(Yegor::MovieFilters)
