# Copyright (c) 2014-2022 Yegor Bugayenko
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
  class YegorBufferFile < StaticFile
    def write(dest)
      target = File.join(dest, @dir, @name)
      FileUtils.copy_file(
        File.join(dest, "/../_temp/#{@name}"),
        target
      )
      puts "#{target} created (#{File.size(target)} bytes)"
      true
    end
  end
  class YegorBufferGenerator < Generator
    priority :low
    safe true
    def generate(site)
      home = 'https://www.yegor256.com'
      rss = RSS::Maker.make("atom") do |maker|
        maker.channel.author = "yegor256"
        maker.channel.updated = Time.now.to_s
        maker.channel.about = "For buffer.com only"
        maker.channel.title = "yegor256.com for buffer.com only"
        articles = []
        site.posts.docs.each do |p|
          tags = p['tags'] ? " #{p['tags'].map {|t| "##{t}"}.join(' ')}" : ''
          if p['buffer']
            p['buffer'].each do |quote|
              raise "Quote too log in #{p.url}" if quote.length > 200
              articles << { link: home + p.url, title: quote + tags }
            end
          end
          months = ((Time.now - p['date']) / (30 * 24 * 60 * 60)).to_i
          if months > 3
            articles << {
              link: home + p.url,
              title: if months < 6
                [
                  "I wrote this #{months}-months ago:",
                  "#{months}-months ago I wrote:",
                  "Re-read this #{months}-months old post:"
                ].sample
              elsif months < 12
                [
                  'I wrote this almost a year ago:',
                  'Almost a year old article:',
                  'Re-read this year-old blog post:'
                ].sample
              else
                [
                  'I wrote this over a year ago:',
                  'Pretty old, but still relevant:',
                  'Over a year old, read it again:'
                ].sample
              end + " \"#{p['title']}\"#{tags}"
            }
          end
        end
        key = ENV['YOUTUBE_API_KEY'] # configured in .travis.yml
        unless key.nil?
          uri = URI.parse("https://www.googleapis.com/youtube/v3/playlistItems?playlistId=UUr9qCdqXLm2SU0BIs6d_68Q&part=snippet&maxResults=50&key=#{key}")
          JSON.parse(Net::HTTP.get(uri))['items'].each do |video|
            date = Time.parse(video['snippet']['publishedAt'])
            id = video['snippet']['resourceId']['videoId']
            tags = JSON.parse(
              Net::HTTP.get(
                URI.parse(
                  "https://www.googleapis.com/youtube/v3/videos?part=snippet&fields=items(snippet(title,description,tags))&key=#{key}&id=#{id}"
                )
              )
            )['items'][0]['snippet']['tags']
            raise "No tags for #{id}" if tags.nil?
            tags = tags.select{ |t| t =~ /[a-z]{3,12}/ }.take(3).map{ |t| "##{t}" }.join(' ')
            articles << {
              link: "https://www.youtube.com/watch?v=#{id}",
              title: "Watch it again: \"#{video['snippet']['title']}\" #{tags}"
            }
          end
        end
        {
          'Don\'t forget to follow me in Facebook, here is the link': 'https://www.facebook.com/yegor256',
          'Don\'t forget to subscribe to my YouTube channel, I post videos a few times a month': 'https://www.youtube.com/c/yegor256?sub_confirmation=1',
          'Don\'t forget to follow my Angel.co account, if you are also there': 'https://angel.co/yegor256',
          'BTW, here is my GitHub account, don\'t hesitate to follow it': 'https://github.com/yegor256?tab=followers'
        }.each do |tweet, link|
          articles << { link: link, title: tweet }
        end
        {
          'yegor256/xembly': 'Xembly is an XML building and manipulation language and a library',
          'yegor256/tacit': 'Tacit is a class-less CSS framework, for clueless programmers like me',
          'yegor256/takes': 'Takes is a unique truly object-oriented Java web framework',
          'yegor256/rultor': 'Rultor is a chatbot DevOps assistant to automate deployment and merge operations',
          'teamed/qulice': 'Qulice is an aggregator of Java static analyzers',
          'yegor256/cactoos': 'Cactoos is a library of truly object-oriented Java primitives',
          'jcabi/jcabi-http': 'jcabi-http is an object-oriented Java HTTP client',
        }.each do |repo, tweet|
          articles << { link: "https://github.com/#{repo}", title: "#{tweet}. Please, add your GitHub star, help the project:" }
        end
        articles.shuffle.each do |a|
          maker.items.new_item do |item|
            item.id = SecureRandom.uuid
            item.link = a[:link]
            item.title = a[:title]
            item.updated = Time.now.to_s
          end
        end
      end
      FileUtils.mkdir_p('_temp')
      File.write('_temp/buffer.rss', rss.to_s)
      site.static_files << Jekyll::YegorBufferFile.new(site, site.dest, '', 'buffer.rss')
    end
  end
end
