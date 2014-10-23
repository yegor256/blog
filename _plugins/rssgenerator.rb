require 'rss'

module Jekyll
  class RssGenerator < Generator
    priority :low
    safe true
    def generate(site)
      build(site, '')
      build(site, 'jcg')
    end
    def build(site, category)
      name = 'rss' + (category.empty? ? '' : "-#{category}") + '.xml'
      rss = RSS::Rss.new('2.0')
      channel = RSS::Rss::Channel.new
      rss.channel = channel
      channel.title = site.config['title']
      channel.link = site.config['url']
      channel.language = 'en-us'
      channel.generator = 'Jekyll'
      image = RSS::Rss::Channel::Image.new
      channel.image = image
      image.url = '/images/icon-128x128.png'
      image.title = site.config['name']
      image.link = site.config['url'] + '/' + name
      channel.description = site.config['description']
      channel.lastBuildDate = site.posts.map { |p| p.date  }.max
      channel.copyright = site.config['copyright']
      post_limit = (site.config['rss_post_limit'] - 1 rescue site.posts.count)
      site.posts
        .select{ |p| category.empty? || p.categories.include?(category) }
        .reverse[0..post_limit].each do |post|
          post.render(site.layouts, site.site_payload)
          item = RSS::Rss::Channel::Item.new
          item.guid = RSS::Rss::Channel::Item::Guid.new
          link = "#{site.config['url']}#{post.url}"
          item.guid.content = link
          item.title = post.title
          item.link = link
          item.description = post.content
          item.pubDate = post.date
          channel.items << item
        end
      path = File.join(site.dest, '/')
      FileUtils.mkdir_p(path)
      File.open("#{path}#{name}", 'w') { |f| f.write(rss.to_rss('2.0')) }
      site.pages << Jekyll::Page.new(site, site.dest, '/', name)
    end
  end
end
