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
      '<div>Watch this:' +
      list.each { |id| "<a href='https://www.youtube.com/watch?v=#{id}'>video</a>" }.join(' ') +
      '</div>'
    end
  end
end

Liquid::Template.register_filter(Yegor::Youtube)
Liquid::Template.register_tag('youtube', Yegor::YoutubeBlock)
