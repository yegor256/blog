# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# Jekyll module
module Jekyll
  # The module
  module Tags
    # The class
    class Pst < Liquid::Tag
      def initialize(tag_name, post, tokens)
        super
        @post = post.strip
        @file = "_posts/#{@post}.md"
        raise "File #{@file} doesn't exist" unless File.exist?(@file)
      end

      def render(context)
        context.registers[:site].posts.docs.each do |p|
          return p.url if p.relative_path == @file
        end
        raise "Can't find post with \"#{@post}\" name"
      end
    end
  end
end

Liquid::Template.register_tag('pst', Jekyll::Tags::Pst)
