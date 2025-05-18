# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# My module
module Yegor
  # Module
  module FrontFilters
    def yb_keywords(page)
      list = page['keywords']
      list = [] if list.nil?
      raise "too many keywords in [#{page['url']}]: #{list}" if list.length > 8
      raise "too few keywords in [#{page['title']}]: #{list.length}" if list.length > 1 && list.length < 3
      # list.each { |word|
      #   if page['content'].index(word).nil? && page['description'].index(word).nil?
      #     fail "keyword '#{word}' is not found in #{page['title']}"
      #   end
      # }
      list.compact.sort.uniq
    end

    def yb_description(page)
      text = page['description']
      text = '' if text.nil?
      raise "too short description in [#{page['title']}] (#{text.length} chars): \"#{text}\"" if text.length < 80
      raise "too long description in [#{page['title']}] (#{text.length} chars): \"#{text}\"" if text.length > 200
      text.gsub(/[ \n\r\t]+/, ' ').strip
    end

    def yb_menu(url, title)
      if url.end_with?("#{title}.html")
        ' class="selected" '
      else
        ''
      end
    end
  end
end

require 'liquid'
Liquid::Template.register_filter(Yegor::FrontFilters)
