# Copyright (c) 2014-2017 Yegor Bugayenko
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

module Yegor
  class VideosBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
    end

    def render(context)
      return 'not implemented yet...'
      path = File.expand_path('~/secrets.yml')
      return unless File.exist?(path)
      key = YAML::safe_load(File.open(path))['youtube_api_key']
      uri = URI.parse("https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&myRating=like&key=#{key}")
      json = JSON.parse(Net::HTTP.get(uri))
      raise json['error']['message'] if json['error']
      raise 'No YouTube videos found' if json['items'].empty?
      json['items'].each do |item|
        put item
        snippet = item['snippet']
        "<p>
          <a href='https://www.youtube.com/watch?v=#{@id}'>
          <img src='#{snippet['thumbnails']['medium']['url']}' alt='YouTube video ##{@id}'/><br/>
          #{CGI.escapeHTML(snippet['title'])}<br/>
          #{Time.parse(snippet['publishedAt']).strftime('%-d %B %Y')}<br/>
          #{item['statistics']['viewCount']} views; #{item['statistics']['likeCount']} likes</p>"
      end
    end
  end
end

Liquid::Template.register_tag('videos', Yegor::VideosBlock)
