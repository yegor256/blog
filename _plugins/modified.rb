require 'date'
module Yegor
  module Modified
    def modified(page)
      path = page['path']
      count = `git rev-list HEAD --count #{path}`.strip.to_i
      if count > 1
        date = Date.parse(`git log --format=%aI #{path}`.strip)
        "<li><a href='https://github.com/yegor256/blog/commits/master/#{path}'>#{order(count)}</a>\
          modification on\
          <time itemprop='dateModified' datetime='#{date.strftime('%Y-%m-%dT%H:%M:%S%z')}'>#{date.strftime('%-d %B %Y')}</time></li>"
      else
        ''
      end
    end
    private
    def order(count)
      if count == 1
        'one'
      elsif count == 2
        'second'
      elsif count == 3
        'third'
      else
        "#{count}th"
      end
    end
  end
end

Liquid::Template.register_filter(Yegor::Modified)
