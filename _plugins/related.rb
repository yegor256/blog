# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# My module
module Yegor
  # The class
  class RelatedBlock < Liquid::Tag
    def render(context)
      page = context.registers[:page]
      site = context.registers[:site]
      page['related'].map do |p|
        html(site, p)
      end.join
    end

    def html(site, name)
      file = "_posts/#{name}.md"
      page = site.posts.docs.detect do |p|
        p.relative_path == file
      end
      desc = page.data['description']
      raise "Empty description at #{file}" if desc.nil?
      "<p><a href='#{page.url}'><strong>#{CGI.escapeHTML(page.data['title'])}</strong></a>\
<br/>#{CGI.escapeHTML(desc)}</p>"
    end
  end
end

Liquid::Template.register_tag('related_posts', Yegor::RelatedBlock)
