# frozen_string_literal: true

# Copyright (c) 2014-2025 Yegor Bugayenko
# Copyright (c) 2014-2025 Yegor Bugayenko
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

require 'net/http'
require 'uri'
require 'yaml'
require 'cgi'

# My module
module Yegor
  # The class
  class YoutubeBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      @id = markup.strip
    end

    def render(_context)
      path = File.expand_path('~/secrets.yml')
      return unless File.exist?(path)
      key = YAML.safe_load(File.open(path))['youtube_api_key']
      uri = URI.parse("https://www.googleapis.com/youtube/v3/videos?id=#{@id}&part=snippet&key=#{key}")
      json = JSON.parse(Net::HTTP.get(uri))
      # raise json['error']['message'] if json['error']
      if json['error']
        puts "Can't download YouTube video #{@id}, skipped: #{json['error']}"
        return "<!-- YouTube video #{@id} skipped -->"
      end
      raise "YouTube video #{@id} not found" if json['items'].empty?
      item = json['items'][0]
      snippet = item['snippet']
      puts "YouTube video #{@id} found: #{snippet['title']}"
      "<aside class='youtube'>
        <a href='https://www.youtube.com/watch?v=#{@id}'><div class='box'>
        <img src='#{snippet['thumbnails']['medium']['url']}' alt='YouTube video ##{@id}'/>
        <div class='play'><i class='icon icon-play'></i></div>
        </div></a>
        <div>#{CGI.escapeHTML(snippet['title'])};
        #{Time.parse(snippet['publishedAt']).strftime('%-d %B %Y')}.</div></aside>"
      # "#{item['statistics']['viewCount']} views; #{item['statistics']['likeCount']} likes"
    end
  end
end

Liquid::Template.register_tag('youtube', Yegor::YoutubeBlock)
