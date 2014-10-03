# Jekyll plugin for generating an rss 2.0 feed for posts
#
# Usage: place this file in the _plugins directory and set the required configuration
#        attributes in the _config.yml file
#
# Uses the following attributes in _config.yml:
#   name           - the name of the site
#   url            - the url of the site
#   description    - (optional) a description for the feed (if not specified will be generated from name)
#   author         - (optional) the author of the site (if not specified will be left blank)
#   copyright      - (optional) the copyright of the feed (if not specified will be left blank)
#   rss_path       - (optional) the path to the feed (if not specified "/" will be used)
#   rss_name       - (optional) the name of the rss file (if not specified "rss.xml" will be used)
#   rss_post_limit - (optional) the number of posts in the feed
#
# Author: Assaf Gelber <assaf.gelber@gmail.com>
# Site: http://agelber.com
# Source: http://github.com/agelber/jekyll-rss
#
# Distributed under the MIT license
# Copyright Assaf Gelber 2014

require 'rss'

module Jekyll
  class RssFeed < Page; end

  class RssGenerator < Generator
    priority :low
    safe true

    def generate(site)
      rss = RSS::Rss.new('2.0')
      channel = RSS::Rss::Channel.new
      rss.channel = channel
      channel.title = site.config['name']
      channel.link = site.config['url']
      channel.language = 'en-us'
      channel.generator = 'Jekyll'
      image = RSS::Rss::Channel::Image.new
      channel.image = image
      image.url = '/images/icon-128x128.png'
      image.title = site.config['name']
      image.link = site.config['url'] + '/rss.xml'
      channel.description = site.config['description'] || "RSS feed for #{site.config['name']}"
      channel.lastBuildDate = site.posts.map { |p| p.date  }.max
      channel.copyright = site.config['copyright']
      post_limit = (site.config['rss_post_limit'] - 1 rescue site.posts.count)
      site.posts.reverse[0..post_limit].each do |post|
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
      rss_path = ensure_leading_slash(ensure_trailing_slash(site.config['rss_path'] || '/'))
      rss_name = site.config['rss_name'] || 'rss.xml'
      full_path = File.join(site.dest, rss_path)
      FileUtils.mkdir_p(full_path)
      File.open("#{full_path}#{rss_name}", 'w') { |f| f.write(rss.to_s) }
      site.pages << Jekyll::RssFeed.new(site, site.dest, rss_path, rss_name)
    end

    private

    def ensure_leading_slash(path)
      path[0] == '/' ? path : "/#{path}"
    end

    def ensure_trailing_slash(path)
      path[-1] == '/' ? path : "#{path}/"
    end
  end
end
