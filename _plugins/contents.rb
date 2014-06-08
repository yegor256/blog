require 'fileutils'

module Yegor
  class Contents < Jekyll::Generator
    priority :low

    def generate(site)
      html = '<html><body>'
      year = ''
      month = ''
      site.posts.reverse.each do |post|
        if post.date.year != year
          year = post.date.year
          html += "<h1>#{year}</h1>"
        end
        if post.date.month != month
          month = post.date.month
          html += "<h2>#{month}</h2>"
        end
        html += "<p>#{post.title}</p>"
      end
      html += '</body></html>'
      path = File.join(site.dest, 'contents.html')
      FileUtils.mkdir_p(File.dirname(path))
      File.open(path, 'w') { |f| f.write(html) }
      site.pages << Jekyll::Page.new(site, site.dest, '', File.basename(path))
    end

  end
end
