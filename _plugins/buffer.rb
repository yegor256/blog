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

require 'rss'
require 'securerandom'

module Jekyll
  class BufferGenerator < Generator
    priority :low
    safe true
    def generate(site)
      home = 'http://www.yegor256.com'
      rss = RSS::Maker.make("atom") do |maker|
        maker.channel.author = "yegor256"
        maker.channel.updated = Time.now.to_s
        maker.channel.about = "For buffer.com only"
        maker.channel.title = "yegor256.com for buffer.com only"
        site.posts.docs.each do |p|
          tags = p['tags'] ? " #{p['tags'].map {|t| "##{t}"}.join(' ')}" : ''
          if p['buffer']
            p['buffer'].each do |quote|
              maker.items.new_item do |item|
                item.id = SecureRandom.uuid
                item.link = home + p.url
                item.title = quote + tags
                item.updated = Time.now.to_s
              end
            end
          end
          months = ((Time.now - p['date']) / (30 * 24 * 60 * 60)).to_i
          if months > 3
            maker.items.new_item do |item|
              item.id = SecureRandom.uuid
              item.link = home + p.url
              if months < 6
                item.title = "I wrote this #{months} months ago: \"#{p['title']}\"#{tags}"
              elsif months < 12
                item.title = "I wrote this almost a year ago: \"#{p['title']}\"#{tags}"
              else
                item.title = "I wrote this over a year ago: \"#{p['title']}\"#{tags}"
              end
              item.updated = Time.now.to_s
            end
          end
        end
      end
      File.write(File.join(site.dest, 'buffer.rss'), rss.to_s)
      site.static_files << StaticFile.new(site, site.dest, '', 'buffer.rss')
      puts 'buffer.rss generated'
    end
  end
end
