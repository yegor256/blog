# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'cgi'
require 'liquid'
require 'nokogiri'
require 'socket'
require_relative '../_plugins/pictures'

# These fixtures use an absolute synthetic URL, so rendering must stay offline.
class << Socket
  def tcp(*)
    raise 'Network access is prohibited in picture regression tests'
  end
end

class << TCPSocket
  def new(*)
    raise 'Network access is prohibited in picture regression tests'
  end
end

[
  ["A & B's \"quoted\" <title>\t with\n repeated   spaces", "A & B's \"quoted\" <title> with repeated spaces"],
  ['', 'picture']
].each do |title, expected|
  template = Liquid::Template.parse("{% picture https://example.invalid/picture.png 200 #{title} %}")
  fragment = Nokogiri::HTML.fragment(template.render!)
  images = fragment.css('img')
  raise "Expected one img, got #{images.length}" unless images.length == 1
  raise "Parsed alt mismatch: #{images.first['alt'].inspect}, expected #{expected.inspect}" unless images.first['alt'] == expected

  captions = fragment.css('figcaption')
  if title.empty?
    raise 'Empty title must not create a caption' unless captions.empty?
  else
    raise 'Expected the original caption text' unless captions.length == 1 && captions.first.text == title
  end
end

puts 'Picture title regression tests passed'
