module Jekyll
  class GnuplotFile < StaticFile
    def write(dest)
      begin
        super(dest)
      rescue
      end
      true
    end
  end
  class GnuplotGenerator < Generator
    priority :low
    safe true
    def generate(site)
      Dir.glob("./_gnuplot/**/*.gpi").each do |f|
        path = File.dirname(f).gsub(/^.*_gnuplot\//, '')
        base = File.basename(f).gsub(/\.gpi$/, '')
        system("
          set -e
          dir=$(pwd)
          cd _gnuplot/#{path}
          gnuplot #{base}.gpi
          mkdir -p ${dir}/_site/gnuplot/#{path}
          mv #{base}.svg ${dir}/_site/gnuplot/#{path}
          cd ${dir}
        ")
        site.static_files << Jekyll::GnuplotFile.new(site, site.dest, '/', "gnuplot/#{path}/#{base}.svg")
      end
    end
  end
end
