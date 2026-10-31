# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'net/http'
require 'uri'
require 'yaml'
require 'cgi'

# My module
module Yegor
  # The class
  class VideosBlock < Liquid::Tag
    def render(_context)
      'not implemented yet...'
      # path = File.expand_path('~/secrets.yml')
      # return unless File.exist?(path)
      # key = YAML.safe_load(File.open(path))['youtube_api_key']
      # uri = URI.parse("https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&myRating=like&key=#{key}")
      # json = JSON.parse(Net::HTTP.get(uri))
      # raise json['error']['message'] if json['error']
      # raise 'No YouTube videos found' if json['items'].empty?
      # json['items'].each do |item|
      #   put item
      #   snippet = item['snippet']
      #   "<p>
      #     <a href='https://www.youtube.com/watch?v=#{@id}'>
      #     <img src='#{snippet['thumbnails']['medium']['url']}' alt='YouTube video ##{@id}'/><br/>
      #     #{CGI.escapeHTML(snippet['title'])}<br/>
      #     #{Time.parse(snippet['publishedAt']).strftime('%-d %B %Y')}<br/>
      #     #{item['statistics']['viewCount']} views; #{item['statistics']['likeCount']} likes</p>"
      # end
    end
  end
end

Liquid::Template.register_tag('videos', Yegor::VideosBlock)
