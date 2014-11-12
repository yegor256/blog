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
      system('
        set -e
        dir=$(pwd)
        cd _gnuplot/2014/11
        gnuplot netbout-hoc-vs-loc.gpi
        mkdir -p ${dir}/gnuplot/2014/11
        mv netbout-hoc-vs-loc.svg ${dir}/gnuplot/2014/11/
      ')
      site.static_files << Jekyll::GnuplotFile.new(site, site.dest, '/', "gnuplot/2014/11/netbout-hoc-vs-loc.svg")
    end
  end
end
