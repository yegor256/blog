# Copyright (c) 2014-2017 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so. The Software doesn't include files with .md extension.
# That files you are not allowed to copy, distribute, modify, publish, or sell.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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
          mv #{base}.svg ${dir}/_temp/gnuplot/#{path}
        ]
        raise 'failed to build gnuplot image' if !$?.exitstatus
        site.static_files << Jekyll::GnuplotFile.new(site, site.dest, 'gnuplot', "#{path}/#{base}.svg")
      end
    end
  end
end
