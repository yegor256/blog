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
      words = []
      context['site'].posts.each do |doc|
        words += Jekyll.all_words(doc.content)
      end
      puts "#{decimal(words.length)} words in the entire blog, #{decimal(words.uniq.length)} uniques"
      "approx. #{decimal(words.length)} words in the entire blog, \
      <a href='/words.txt'>#{decimal(words.uniq(&:downcase).length)}</a> unique ones"
    end
    def decimal(num)
      num.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
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
      words = []
      site.posts.docs.each do |doc|
        next if doc.date < min
        m = doc.date.strftime("%Y-%m")
        months[m] = 0 if !months.key?(m)
        all = Jekyll.all_words(doc.content)
        words += all
        months[m] += all.length
      end
      File.write(
        File.join(site.config['source'], '_temp/stats/words.txt'),
        words.sort{ |a,b| a.downcase <=> b.downcase }.uniq(&:downcase).join("\n")
      )
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
      site.static_files << Jekyll::StatsFile.new(site, site.dest, '', 'words.txt')
    end
  end

  def self.all_words(text)
    text
      .gsub(/\{% highlight .+ endhighlight %\}/m, ' ')
      .gsub(/\[([^\]]+)\]\([^\)]+\)/, ' \1 ')
      .gsub(/`[^`]+`/, ' ')
      .gsub(/\{% .+ %\}/, ' ')
      .gsub(/&mdash;/, ' ')
      .gsub(/<[^>]+>/, ' ')
      .gsub(/[^A-Za-z'-]/, ' ')
      .split(/\s+/)
      .select{ |w| w.length > 1 }
      .select{ |w| /^[A-Za-z].*/ =~ w }
      .map do |w|
        if /[A-Z]{2}.*/ =~ w
          w
        else
          w.downcase
        end
      end
  end
end

Liquid::Template.register_tag('wordcount', Jekyll::WordCountBlock)
