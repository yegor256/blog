require 'net/http'
require 'uri'

module Yegor
  class YoutubeBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      opts = markup.strip.split(/\s+/, 2)
      @id = opts[0].strip
      @flags = opts[1].strip unless opts[1].nil?
    end

    def render(context)
      "<iframe class='video #{@flags unless @flags.nil?}'" \
      " src='https://www.youtube.com/embed/#{@id}?controls=2' allowfullscreen='true'></iframe>\n\n"
    end
  end

  module Youtube
    def youtube(list)
      key = ENV['YOUTUBE_API_KEY'] # configured in .travis.yml
      '<div class="youtube"><ul>' +
      list.map do |id|
        uri = URI.parse("https://www.googleapis.com/youtube/v3/videos?id=#{id}&part=snippet,statistics&key=#{key}")
        json = JSON.parse(Net::HTTP.get(uri))
        item = json['items'][0]
        snippet = item['snippet']
        "<li><a href='https://www.youtube.com/watch?v=#{id}'>" \
          "<img src='#{snippet['thumbnails']['medium']['url']}'/></a>" \
          "#{snippet['title']}; " \
          "#{Time.parse(snippet['publishedAt']).strftime('%-d %B %Y')}" \
          "#{item['statistics']['viewCount']} views, #{item['statistics']['likeCount']} likes" \
          "</li>"
      end.join('') +
      '</ul></div>'
    end
  end
end

Liquid::Template.register_filter(Yegor::Youtube)
Liquid::Template.register_tag('youtube', Yegor::YoutubeBlock)
