module Jekyll
  module Tags
    class Pst < Liquid::Tag
      def initialize(tag_name, post, tokens)
        super
        @orig_post = post.strip
        begin
          @post = PostComparer.new(@orig_post)
        rescue
          @post = nil
        end
      end

      def render(context)
        site = context.registers[:site]
        site.posts.each do |p|
          if @post == p
            return p.url
          end
        end unless @post.nil?
        return '/'
      end
    end
  end
end

Liquid::Template.register_tag('pst', Jekyll::Tags::Pst)
