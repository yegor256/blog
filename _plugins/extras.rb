module Jekyll
  class RssFile < StaticFile
    def write(dest)
      FileUtils.copy_file(File.join(dest, 'rss.xml'), File.join(dest, 'rss'))
      true
    end
  end
  class ExtraGenerator < Generator
    priority :low
    safe true
    def generate(site)
      site.static_files << Jekyll::RssFile.new(site, site.dest, '', 'rss.xml')
    end
  end
end
