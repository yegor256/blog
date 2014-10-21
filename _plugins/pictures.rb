module Yegor
  class FigureBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      opts = markup.strip.split(/\s+/, 3)
      @src = opts[0].strip
      @width = opts[1].strip
      file = '.' + @src
      if !File.exists?(file)
        raise "file doesn't exist: #{file}"
      end
    end

    def render(context)
      @home = context.registers[:site].config['url']
      html = "<figure><img src='#{CGI.escapeHTML(@home + @src)}'" \
        " style='width:#{@width}px;'" \
        " alt='figure'/></figure>\n\n"
    end
  end

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
      @home = context.registers[:site].config['url']
      img = "<img src='#{CGI.escapeHTML @home + @src}' style='width:#{@width}px;' alt='badge'/>"
      if @url
        img = "<a href='#{CGI.escapeHTML @url}'>#{img}</a>"
      end
      html = "<figure class='badge'>#{img}</figure>\n\n"
    end
  end

  class PictureBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      opts = markup.strip.split(/\s+/, 3)
      @src = opts[0].strip
      @width = opts[1].nil? ? '0' : opts[1].strip
      if @width == '0'
        @width = '600'
      end
      @title = opts[2].nil? ? '' : opts[2].strip
      file = '.' + @src
      if !File.exists?(file)
        raise "file doesn't exist: #{file}"
      end
    end

    def render(context)
      @home = context.registers[:site].config['url']
      html = "<figure><img src='#{CGI::escapeHTML(@home + @src)}'" +
        " style='width:#{@width}px;'" +
        " alt='#{CGI::escapeHTML @title}'/>"
      if @title != ''
        html += "<figcaption>#{CGI::escapeHTML @title}</figcaption>"
      end
      html += "</figure>\n\n"
    end
  end
end

Liquid::Template.register_tag('figure', Yegor::FigureBlock)
Liquid::Template.register_tag('badge', Yegor::BadgeBlock)
Liquid::Template.register_tag("picture", Yegor::PictureBlock)
