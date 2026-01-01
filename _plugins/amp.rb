# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'liquid'
require 'redcarpet'
require 'nokogiri'
require 'fastimage'

# Jekyll module
module Jekyll
  # The class
  class AmpGenerator < Generator
    priority :low
    def generate(site)
      # if ENV['JEKYLL_ENV'] != 'production'
      #   puts 'AMPs are not generated, since it is not production'
      #   return
      # end
      start = Time.now
      total = 0
      site.posts.docs.each do |doc|
        page = AmpPage.new(site, doc)
        payload = site.site_payload
        payload['page'] = page
        payload['doc'] = doc
        if page['image']
          payload['image_width'], payload['image_height'] = Jekyll.image_size(page['image'])
          payload['image_src'] = page['image']
        else
          payload['image_width'] = 1400
          payload['image_height'] = 1400
          payload['image_src'] = 'https://www.yegor256.com/images/face-1024x1024.jpg'
        end
        page.render(
          { 'post' => Layout.new(site, site.source, '_layouts/amp.html') },
          payload
        )
        site.static_files << Jekyll::AmpFile.new(
          site, doc.url.gsub(/\.html$/, '.amp.html'), page.output
        )
        total += 1
      end
      puts "#{total} AMP pages generated in #{(Time.now - start).round(2)}s"
    end
  end

  # The class
  class AmpPage < Page
    def initialize(site, doc)
      super(site, site.source, File.dirname(doc.relative_path), doc.basename)
    end
  end

  # The class
  class AmpFile < StaticFile
    def initialize(site, path, html)
      super(site, site.dest, '', path)
      @html = html
    end

    def modified?
      true
    end

    def modified_time
      Time.now
    end

    def write(_dest)
      FileUtils.mkdir_p File.dirname(path)
      xml = Nokogiri::HTML(@html)
      xml.xpath('//body//figure[@class="highlight"]').each do |f|
        f.before("<pre>#{f.xpath('pre//text()')}</pre>")
      end
      xml.xpath('//body//figure[@class="jb_picture"]').each do |f|
        src = f.xpath('img/@src').to_s
        alt = f.xpath('figcaption/text()').to_s
        width, height = Jekyll.image_size(src)
        raise "Can't calculate size of image: #{src}" unless width
        f.before("<amp-img src='#{CGI.escapeHTML(src)}' alt='#{CGI.escapeHTML(alt)}' height='#{height}' width='#{width}' layout='responsive'></amp-img>")
      end
      xml.xpath('//comment()').remove
      xml.xpath('//@style').remove
      xml.xpath('//body//iframe').remove
      xml.xpath('//body//script').remove
      xml.xpath('//body//form').remove
      xml.xpath('//body//figure').remove
      xml.xpath('//body//figcaption').remove
      xml.xpath('//body//img').remove
      xml.xpath('//body//svg').remove
      xml.xpath('//body//aside').remove
      content = xml.to_html
        .gsub(%r{<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">}, '')
      File.write(path, content)
      Jekyll.logger.debug("AMP written to #{path}")
      true
    end
  end

  def self.image_size(src)
    path = src
    path = File.join(Dir.pwd, path) unless path.start_with?('http://', 'https://')
    FastImage.size(path)
  end
end
