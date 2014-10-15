require 'nuggets/range/quantile'
require 'erb'

module Jekyll

  class Tagger < Generator
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
          data = { 'layout' => layout, 'posts' => posts.sort.reverse! }
          name = yield data if block_given?
          site.pages << TagPage.new(
            site, site.source, site.config["tag_#{type}_dir"],
            "#{name || tag}#{site.layouts[data['layout']].ext}", data
          )
        end
      }
    end
  end

  class TagPage < Page

    def initialize(site, base, dir, name, data = {})
      self.content = data.delete('content') || ''
      self.data    = data
      super(site, base, dir[-1, 1] == '/' ? dir : '/' + dir, name)
      data['tag'] ||= basename
    end

    def read_yaml(*)
      # Do nothing
    end

  end

  module Filters

    def tag_cloud(tags)
      tags.keys.sort.map{ |t| tag_link(t) }.join(' ')
    end

    def tag_link(tag)
      %Q{<a href="#{tag_url(tag)}" class='tag'>#{tag}</a>}
    end

    def tag_url(tag)
      "/tag/#{tag}.html"
    end

    def tagged(post)
      "<p><a href='#{post['url']}'>#{post['title']}</a><br/>
      <time class='gray small' datetime='#{post['date'].xmlschema()}'>
      #{post['date'].strftime('%-d %B %Y')}</time>
      <a href='http://www.yegor256.com#{post['url']}#disqus_thread'>comments</a>
      <span>#{tags(post)}</span></p>"
    end

    def tags(obj)
      tags = obj['tags'].dup
      tags.map! { |t| t.first } if tags.first.is_a?(Array)
      tags.map! { |t| tag_link(t) if t.is_a?(String) }.compact!
      tags.join(' ')
    end
  end

end
