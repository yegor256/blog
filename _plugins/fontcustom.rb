module Jekyll
  class FontcustomFile < StaticFile
    def write(dest)
      begin
        super(dest)
      rescue
      end
      true
    end
  end
  class FontcustomGenerator < Generator
    priority :low
    safe true
    def generate(site)
      system('mkdir -p _site/css')
      ['svg', 'ttf', 'woff', 'eot', 'css'].each do |ext|
        FileUtils.copy_file("_temp/icons/icons.#{ext}", "_site/icons.#{ext}")
        site.static_files << Jekyll::FontcustomFile.new(site, site.dest, '/', "icons.#{ext}")
      end
    end
  end
end
