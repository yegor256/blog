module Yegor
  module Filters
    def book(book)
      opts = book.strip.split(/\s+/, 2)
      link = 'http://www.amazon.com/gp/product/1519166915/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=1519166915&linkCode=as2&tag=yegor256com-20&linkId=RMGEO4ESPM4CGD3O'
      "<aside class='book'>" \
      "<a href='#{link}'>" \
      "<img src='/images/books/elegant-objects/cover.png' class='book-cover'/>" \
      "</a>" \
      "Read more about this subject in " \
      "<a href='#{link}'>Section&nbsp;#{opts[1]}</a>" \
      " of this book" \
      "<a href='#{link}'><img src='/images/books/amazon-buy-button.png' class='amazon-button'/></a>" \
      "</aside>"
    end
  end
end

Liquid::Template.register_filter(Yegor::Filters)
