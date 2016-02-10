module Jekyll
  class GnuplotFile < StaticFile
    def write(dest)
      target = File.join(dest, @dir, @name)
      FileUtils.copy_file(
        File.join(dest, "/../_temp/gnuplot/#{@name}"),
        target
      )
      puts "#{target} created (#{File.size(target)} bytes)"
      true
    end
  end
  class GnuplotGenerator < Generator
    priority :low
    safe true
    def generate(site)
      Dir.glob("#{site.config['source']}/_gnuplot/**/*.gpi").each do |f|
        path = File.dirname(f).gsub(/^.*_gnuplot\//, '')
        base = File.basename(f).gsub(/\.gpi$/, '')
        system("
          set -e
          dir=$(pwd)
          cd _gnuplot/#{path}
          gnuplot #{base}.gpi
          mkdir -p ${dir}/_temp/gnuplot/#{path}
          mv #{base}.svg ${dir}/_temp/gnuplot/#{path}
          cd ${dir}
        ")
        site.static_files << Jekyll::GnuplotFile.new(site, site.dest, 'gnuplot', "#{path}/#{base}.svg")
      end
    end
  end
end
