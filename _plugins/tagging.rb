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

require 'nuggets/range/quantile'
require 'erb'

module Yegor
  class Tagger < Jekyll::Generator
    safe true
    attr_accessor :site
    @types = [:page, :feed]
    class << self; attr_accessor :types, :site; end

    def generate(site)
      self.class.site = self.site = site
      site.tags.each { |tag, posts| new_tag(tag, posts) }
    end

    private

    def new_tag(tag, posts)
      self.class.types.each { |type|
        if layout = site.config["tag_#{type}_layout"]
          data = { 'layout' => layout, 'posts' => posts.sort.reverse!, 'tag' => tag }
          name = yield data if block_given?
          site.pages << TagPage.new(
            site, site.source, site.config["tag_#{type}_dir"],
            "#{name || tag}#{site.layouts[data['layout']].ext}",
            data
          )
        end
      }
    end
  end

  class TagPage < Jekyll::Page
    def initialize(site, base, dir, name, data = {})
      self.content = data.delete('content') || ''
      self.data = data
      @title = data['tag']
      super(site, base, dir[-1, 1] == '/' ? dir : '/' + dir, name + '.html')
      data['tag'] ||= basename
    end

    alias orig_to_liquid to_liquid
    def to_liquid
      hash = orig_to_liquid
      hash['title'] = @title
      hash['description'] = "#{@title}: more about #{@title} in this collection of recently published articles... the list is updated every few weeks."
      hash
    end

    def read_yaml(*)
      # Do nothing
    end
  end

  module TaggingFilters
    def tag_cloud(tags)
      tags.keys.sort.map{ |t| tag_link(t) }.join(' ')
    end

    def tag_link(tag)
      prefix = case tag
      when 'oop'
        "<img src='/images/books/elegant-objects/cactus.svg' alt='OOP'/>"
      when 'management'
        "<img src='/images/books/code-ahead/mushroom.svg' alt='Management'/>"
      when 'java'
        "<img src='/images/java-icon.svg' alt='Java'/>"
      when 'zerocracy'
        "<img src='//www.0crat.com/svg/logo.svg' alt='Zerocracy'/>"
      when 'xdsd'
        "<img src='//www.xdsd.org/images/logo.svg' alt='XDSD'/>"
      else
        ""
      end
      "<a href='#{tag_url(tag)}' class='tag notranslate'>#{prefix}#{tag}</a>"
    end

    def tag_url(tag)
      "/tag/#{tag}.html"
    end

    def yb_tagged_list(posts)
      posts.select { |p| p['noindex'].nil? }.map{ |p| tagged(p) }.join() unless posts.nil?
    end

    def tagged(post)
      "<div class='tagged' data-length='#{post.content.split(/\s+/).length}'>
        <div><a href='#{post.url}'>#{post['title']}</a></div>
        <ul class='subline'>
          <li>
            <time datetime='#{post['date'].xmlschema()}'>
              #{post['date'].strftime('%-d %B %Y')}
            </time>
          </li>
          <li class='tags'>#{yb_page_tags(post)}</li>
          <li class='unprintable'>
            <a href='https://www.yegor256.com#{post.url}#disqus_thread' class='comment_count notranslate'>comments</a>
          </li>
          #{post.content.include?('twitter-tweet') ? '<li class="has-poll" title="There is a Twitter poll inside"><i class="icon icon-twitter"></i></li>' : ''}
        </ul>
      </div>".gsub(/\n/, '')
    end

    def yb_page_tags(page)
      return '' unless page['tags'].kind_of?(Array)
      tags = page['tags'].dup.sort
      tags.map! { |t| t.first } if tags.first.is_a?(Array)
      tags.map { |t| tag_link(t) if t.is_a?(String) }
        .compact
        .join(' ')
    end
  end
end

require 'liquid'
Liquid::Template.register_filter(Yegor::TaggingFilters)

