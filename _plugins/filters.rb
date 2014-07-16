module Yegor
  module Filters
    def clean_list(arr)
      arr.compact.sort.uniq
    end
  end
end

Liquid::Template.register_filter(Yegor::Filters)
