module Jekyll
  module Tags
    class Pst < Liquid::Tag
      def initialize(tag_name, post, tokens)
        super
        @post = post.strip
        @file = "_posts/#{@post}.md"
        raise "file #{@file} doesn't exist" unless File.exists?(@file)
      end

      def render(context)
        context.registers[:site].posts.docs.each do |p|
          return p.url if p.relative_path == @file
        end
        raise "can't fine post with \"#{@post}\" name"
      end
    end
  end
end

Liquid::Template.register_tag('pst', Jekyll::Tags::Pst)
