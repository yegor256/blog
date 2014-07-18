module Yegor
  module Filters
    def clean_list(arr)
        if arr.nil?
            []
        else
            arr.compact.sort.uniq
        end
    end
  end
end

Liquid::Template.register_filter(Yegor::Filters)
