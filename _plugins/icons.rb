module Jekyll
  class FontFile < StaticFile
    def write(dest)
      begin
        super(dest)
      rescue
      end
      true
    end
  end
  class IconsGenerator < Generator
    priority :low
    safe true
    def generate(site)
      font = 'fontcustom'
      dir = 'ico'
      temp = '_temp'
      scss = '_ico.scss'
      system(
        "fontcustom compile _glyphs --output=_site/#{dir} \
        --font-name=#{font} --templates=scss --no-hash --force \
        --autowidth --preprocessor-path=http://localhost:4000/#{dir} \
        && mkdir -p #{temp} && mv _site/#{dir}/_#{font}.scss #{temp}/#{scss}"
      )
      file = "#{temp}/#{scss}";
      File.write(file, File.read(file).gsub(/font-url\((.*)\)/, 'url(\1)'))
      ['ttf', 'svg', 'woff', 'eot'].each { |ext|
        site.static_files << Jekyll::FontFile.new(site, site.dest, '/', "#{dir}/#{font}.#{ext}")
      }
    end
  end
end
