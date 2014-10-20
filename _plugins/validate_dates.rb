module Jekyll
  class DateValidateGenerator < Generator
    priority :low
    safe true
    def generate(site)
      site.posts.each do |post|
        prefix = post.date.strftime('_posts/%Y/%b/%Y-%m-%d-').downcase
        next if post.path.index('_drafts/') == 0
        if post.path.index(prefix) != 0
          raise "wrong path of #{post.path}, has to start with #{prefix}"
        end
      end
    end
  end
end
