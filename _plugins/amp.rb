require 'liquid'
require 'redcarpet'
require 'nokogiri'

module Jekyll
  class AmpPage < Page
    def initialize(site, doc)
      super(site, site.source, File.dirname(doc.relative_path), doc.basename)
    end
  end
  class AmpFile < StaticFile
    def initialize(site, path, html)
      super(site, site.dest, '', path)
      @path = path
      xml = Nokogiri::HTML(html)
      xml.xpath('//comment()').remove
      xml.search('//body//script').remove
      xml.search('//body//form').remove
      xml.search('//body//figure').remove
      xml.search('//body//figcaption').remove
      xml.search('//body//img').remove
      xml.search('//body//svg').remove
      xml.search('//body//aside').remove
      @html = xml.to_html
        .gsub(/<meta http-equiv="Content-Type" content="text\/html; charset=UTF-8">/, '')
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
        payload = site.site_payload
        payload['page'] = page
        payload['doc'] = doc
        page.render(
          { 'post' => Layout.new(site, site.source, '_layouts/amp.html') },
          payload
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
