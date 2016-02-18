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
        puts %x[
          set -e
          dir=#{site.config['source']}
          cd ${dir}/_gnuplot/#{path}
          gnuplot #{base}.gpi
          mkdir -p ${dir}/_site/gnuplot/#{path}
          mkdir -p ${dir}/_temp/gnuplot/#{path}
          cp #{base}.svg ${dir}/_temp/gnuplot/#{path}
        ]
        raise 'failed to build gnuplot image' if !$?.exitstatus
        site.static_files << Jekyll::GnuplotFile.new(site, site.dest, 'gnuplot', "#{path}/#{base}.svg")
      end
    end
  end
end
