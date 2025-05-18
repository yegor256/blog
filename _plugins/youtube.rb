# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

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
      key = ENV['YOUTUBE_API_KEY']
      return if key.nil?
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
