module Yegor
  class Img
    def initialize(src, ctx)
      if src.index('/') == 0
        @url = src
        raise "file doesn't exist: #{src}" unless
          File.exists?('./_site' + src) ||
          File.exists?('.' + src) ||
          src =~ /gnuplot/
      else
        @url = src
      end
    end
    def to_s
      CGI.escapeHTML(@url)
    end
  end

  class FigureBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      opts = markup.strip.split(/\s+/, 3)
      @src = opts[0].strip
      @width = opts[1].strip
    end

    def render(context)
      html = "<figure class='unprintable'><img src='#{Yegor::Img.new(@src, context)}'" \
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
      img = "<img src='#{Yegor::Img.new(@src, context)}'" +
        " style='width:#{@width}px;' alt='badge'/>"
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
    end

    def render(context)
      alt = @title.gsub(/[ \n\r\t]+/, ' ')
        .gsub(/&/, '&amp;')
        .gsub(/"/, '&quot;')
        .gsub(/'/, '&apos;')
        .gsub(/</, '&lt;')
        .gsub(/>/, '&gt;')
      html = "<figure><img src='#{Yegor::Img.new(@src, context)}'" +
        " style='width:#{@width}px;' alt='#{CGI.escapeHTML alt}'/>"
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
