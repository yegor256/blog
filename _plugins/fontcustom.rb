module Jekyll
  class FontcustomFile < StaticFile
    def write(dest)
      target = File.join(dest, @dir, @name)
      FileUtils.copy_file(
        File.join(dest, "/../_temp/icons/#{@name}"),
        target
      )
      puts "#{target} created (#{File.size(target)} bytes)"
      true
    end
  end
  class FontcustomGenerator < Generator
    priority :low
    safe true
    def generate(site)
      puts %x[
        set -e
        #{site.config['source']}/_glyphs/compile.sh #{site.config['source']}/_temp/icons
        mkdir -p #{site.config['source']}/_site/css
      ]
      raise 'failed to build icon files' unless $? == 0
      ['svg', 'ttf', 'woff', 'eot', 'css'].each do |ext|
        site.static_files << Jekyll::FontcustomFile.new(site, site.dest, 'css', "icons.#{ext}")
      end
    end
  end
end
