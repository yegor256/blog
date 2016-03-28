module Jekyll
  class AmpGenerator < Generator
    priority :low
    def generate(site)
      site.posts.docs.each do |doc|
        page = Page.new(site, site.source, File.dirname(doc.relative_path), doc.basename)
        page.data['title'] = doc['title']
        page.data['date'] = doc['date']
        page.do_layout(
          site.site_payload,
          'post' => Layout.new(site, site.source, '_layouts/amp.html')
        )
        # page.write('') // this doesn't work
        # site.pages << page
      end
    end
  end
end
