# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# My module
module Yegor
  # Disqus keeps Russian threads under the permalinks of the old
  # ru.yegor256.com blog, while the posts live here now.
  module DisqusFilters
    def yb_disqus(post)
      return post['disqus'] if post['disqus']
      return '' unless post['layout'] == 'russian'
      "https://ru.yegor256.com/#{post['date'].strftime('%Y-%m-%d')}-#{post['slug']}.html"
    end
  end
end

Liquid::Template.register_filter(Yegor::DisqusFilters)
