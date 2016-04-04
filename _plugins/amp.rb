require 'liquid'
require 'redcarpet'

module Jekyll
  class AmpPage < Page
    def initialize(site, doc)
      super(site, site.source, File.dirname(doc.relative_path), doc.basename)
    end
    def title
      "hello"
    end
  end
  class AmpFile < StaticFile
    def initialize(site, path, html)
      super(site, site.dest, '', path)
      @path = path
      @html = html
        .gsub(/<figure ?.*>.*<\/figure>/, '')
        .gsub(/<img ?.*\/>/, '')
        .gsub(/<aside ?.*>.*<\/aside>/, '')
      write(site.dest)
    end
    def write(dest)
      target = File.join(dest, @path)
      FileUtils.mkdir_p File.dirname(target)
      File.write(target, @html)
      true
    end
  end
  class AmpGenerator < Generator
    priority :low
    def generate(site)
      total = 0
      site.posts.docs.each do |doc|
        page = AmpPage.new(site, doc)
        page.do_layout(
          site.site_payload,
          'post' => Layout.new(site, site.source, '_layouts/amp.html')
        )
        site.static_files << Jekyll::AmpFile.new(
          site, doc.url.gsub(/\.html$/, '.amp.html'), page.output
        )
        total += 1
      end
      puts "#{total} AMP pages generated"
    end
  end
end
