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
      system("
        set -e
        dir=$(pwd)
        fontcustom compile ${dir}/_glyphs --output=${dir}/_site/icons \
          --font-name=icons --templates=css \
          --no-hash --force --autowidth
      ")
      ['svg', 'ttf', 'woff', 'eot', 'css'].each do |ext|
        site.static_files << Jekyll::FontcustomFile.new(site, site.dest, '/', "icons/icons.#{ext}")
      end
    end
  end
end
