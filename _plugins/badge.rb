module Yegor
  class BadgeBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      opts = markup.strip.split(/\s+/, 3)
      @src = opts[0].strip
      @width = opts[1].strip
    end
    def render(context)
      html = "<figure class='badge'><img src='#{CGI::escapeHTML @src}'" +
      " style='width:#{@width}px;' alt='badge'/></figure>\n\n"
    end
  end
end

Liquid::Template.register_tag("badge", Yegor::BadgeBlock)
