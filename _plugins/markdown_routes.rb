# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'fileutils'

# For every post rendered to "/path.html" this writes a clean Markdown twin to
# "/path.md", so that LLM agents can read the source instead of parsing HTML.
# The Markdown is generated from the post's own source file, keeping a single
# source of truth and zero drift.
Jekyll::Hooks.register :site, :post_write do |site|
  site.posts.docs.each do |post|
    body = File.read(post.path).sub(/\A---.*?\n---\n/m, '').sub("<!--more-->\n", '').strip
    url = "#{site.config['url']}#{post.url}"
    markdown = "# #{post.data['title']}\n\nSource: #{url}\n\n#{body}\n"
    file = File.join(site.dest, post.url.sub(/\.html\z/, '.md'))
    FileUtils.mkdir_p(File.dirname(file))
    File.write(file, markdown)
  end
end
