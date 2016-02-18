module Jekyll
  class DateValidateGenerator < Generator
    priority :low
    safe true
    def generate(site)
      site.posts.docs.each do |post|
        prefix = post.date.strftime('_posts/%Y/%b/%Y-%m-%d-').downcase
        path = post.relative_path
        next if path.index('_drafts/') == 0
        if path.index(prefix) != 0
          raise "wrong path of '#{path}', it has to start with #{prefix}"
        end
      end
    end
  end
end
