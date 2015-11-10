module Yegor
  class QuoteBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      @text = markup.strip
    end

    def render(context)
      "<aside class='quote'>#{CGI::escapeHTML @text}</aside>\n\n"
    end
  end
end

Liquid::Template.register_tag('quote', Yegor::QuoteBlock)
