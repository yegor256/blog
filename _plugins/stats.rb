# Copyright (c) 2014-2016 Yegor Bugayenko
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

require 'fileutils'

module Jekyll
  class StatsFile < StaticFile
    def write(dest)
      target = File.join(dest, @dir, @name)
      FileUtils.copy_file(
        File.join(dest, "/../_temp/stats/#{@name}"),
        target
      )
      puts "#{target} created (#{File.size(target)} bytes)"
      true
    end
  end
  class WordCountBlock < Liquid::Tag
    def render(context)
      words = 0
      context['site'].posts.each do |doc|
        words += doc.content.split(/\s+/).length
      end
      count = words.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
      puts "#{count} words in the entire blog"
      count
    end
  end
  class StatsGenerator < Generator
    priority :low
    safe true
    def generate(site)
      dat = File.join(site.config['source'], '_temp/stats/stats.dat')
      FileUtils.mkdir_p File.dirname(dat)
      months = {}
      min = Time.parse('2014-04-01')
      site.posts.docs.each do |doc|
        next if doc.date < min
        m = doc.date.strftime("%Y-%m")
        months[m] = 0 if !months.key?(m)
        months[m] += doc.content.split(/\s+/).length
      end
      open(dat, 'w') do |f|
        for m, c in months
          f.puts "#{m}-01T00:00 #{c}"
        end
      end
      puts %x[
        set -e
        src=#{site.config['source']}
        tmp=#{File.dirname(dat)}
        cp ${src}/_stats/stats.gpi ${tmp}/stats.gpi
        cd ${tmp}
        gnuplot stats.gpi
        mkdir -p ${src}/_site
        cp ${tmp}/stats.svg ${src}/_site/stats.svg
      ]
      raise 'failed to build gnuplot stats image' if !$?.exitstatus
      site.static_files << Jekyll::StatsFile.new(site, site.dest, '', 'stats.svg')
    end
  end
end

Liquid::Template.register_tag('wordcount', Jekyll::WordCountBlock)
