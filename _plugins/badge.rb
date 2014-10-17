module Yegor
  class BadgeBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      opts = markup.strip.split(/\s+/, 3)
      @src = opts[0].strip
      @width = opts[1].strip
      if opts[2]
        @url = opts[2].strip
      end
    end

    def render(context)
      url = context.registers[:site].config['url']
      if @src.index('/') == 0
        @src = url + @src
      end
      img = "<img src='#{CGI.escapeHTML @src}' style='width:#{@width}px;' alt='badge'/>"
      if @url
        img = "<a href='#{CGI.escapeHTML @url}'>#{img}</a>"
      end
      html = "<figure class='badge'>#{img}</figure>\n\n"
    end
  end
end

Liquid::Template.register_tag('badge', Yegor::BadgeBlock)
