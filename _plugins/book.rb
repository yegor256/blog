module Yegor
  module Filters
    def book(book)
      opts = book.strip.split(/\s+/, 2)
      "<aside class='book'>" \
      "<a href='http://www.amazon.com/gp/product/1519166915/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=1519166915&linkCode=as2&tag=yegor256com-20&linkId=RMGEO4ESPM4CGD3O'>" \
      "<img src='/images/books/elegant-objects/cover.png'>" \
      "</a>" \
      "Read more about this problem in Section&nbsp;#{opts[1]} of this book" \
      "</aside>"
    end
  end
end

Liquid::Template.register_filter(Yegor::Filters)
