# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# My module
module Yegor
  # Filters
  module Filters
    def book(book)
      opts = book.strip.split(/\s+/, 2)
      case opts[0]
      when 'elegant-objects-1'
        link = 'https://amzn.to/2qFt4Tn'
        cover = '/images/books/elegant-objects/cover-eo1.png'
      when 'elegant-objects-2'
        link = 'https://amzn.to/2pyceWc'
        cover = '/images/books/elegant-objects/cover-eo2.png'
      when 'code-ahead-1'
        link = 'https://amzn.to/2u9BbqF'
        cover = '/images/books/code-ahead/cover.png'
      when 'bloghacks'
        link = 'https://amzn.to/2qopIm5'
        cover = '/images/books/256-bloghacks/cover.png'
      end
      "<aside class='book'>" \
        "<a href='#{link}'>" \
        "<img src='#{cover}' class='book-cover' alt='book cover'/>" \
        '</a>' \
        'Read more about this subject in ' \
        "<a href='#{link}'>Section&nbsp;#{opts[1]}</a><br/> " \
        'of my book' \
        "<a href='#{link}'><img src='/images/books/amazon-buy-button.png' class='amazon-button' alt='Click to buy'/></a>" \
        '</aside>'
    end
  end
end

Liquid::Template.register_filter(Yegor::Filters)
