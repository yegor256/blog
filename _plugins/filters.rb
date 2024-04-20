# frozen_string_literal: true

# Copyright (c) 2014-2024 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so. The Software doesn't include files with .md extension.
# That files you are not allowed to copy, distribute, modify, publish, or sell.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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
