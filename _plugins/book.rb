module Yegor
  module Filters
    def book(book)
      opts = book.strip.split(/\s+/, 2)
      "<aside class='book'>" \
      "<a href='http://www.amazon.com/Elegant-Objects-Yegor-Bugayenko/dp/1519166915/'>" \
      "<img src='/images/books/elegant-objects/cover.png' style='width:50px;float:left;margin-right:1em;'>" \
      "</a>" \
      "Read more about this problem in Section #{opts[1]} of this book..." \
      "</aside>"
    end
  end
end

Liquid::Template.register_filter(Yegor::Filters)
