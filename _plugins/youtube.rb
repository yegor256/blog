module Yegor
  class YoutubeBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      @id = markup
    end

    def render(context)
      "<iframe class='video' width='640' height='360'" \
      " src='https://www.youtube.com/embed/#{@id}' allowfullscreen></iframe>\n\n"
    end
  end
end

Liquid::Template.register_tag('youtube', Yegor::YoutubeBlock)
