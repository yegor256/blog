module Yegor
  module Filters
    def keywords(page)
      list = page['keywords']
      if list.nil?
        list = []
      end
      if list.length > 8
        fail "too many keywords in [#{page['url']}]: #{list}"
      end
      if list.length > 1 && list.length < 5
        fail "too few keywords in [#{page['title']}]: #{list.length}"
      end
      # list.each { |word|
      #   if page['content'].index(word).nil? && page['description'].index(word).nil?
      #     fail "keyword '#{word}' is not found in #{page['title']}"
      #   end
      # }
      list.compact.sort.uniq
    end

    def description(page)
      text = page['description']
      if text.nil?
        text = ''
      end
      if text.length < 100
        fail "too short description in [#{page['title']}] (#{text.length} chars): \"#{text}\""
      end
      if text.length > 200
        fail "too long description in [#{page['title']}] (#{text.length} chars): \"#{text}\""
      end
      text.gsub(/[ \n\r\t]+/, ' ')
        .gsub(/&/, '&amp;')
        .gsub(/"/, '&quot;')
        .gsub(/'/, '&apos;')
        .gsub(/</, '&lt;')
        .gsub(/>/, '&gt;')
    end
  end
end

Liquid::Template.register_filter(Yegor::Filters)
