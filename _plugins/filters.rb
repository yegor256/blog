module Yegor
  module Filters
    def keywords(page)
        list = page['keywords']
        if list.nil?
            list = []
        end
        list.compact.sort.uniq
    end
    def description(page)
        text = page['description']
        if text.nil?
            text = ''
        end
        text
    end
  end
end

Liquid::Template.register_filter(Yegor::Filters)
