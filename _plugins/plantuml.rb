require 'digest'
require 'fileutils'

module Yegor
  class PlantumlBlock < Liquid::Block
    def initialize(tag_name, markup, tokens)
      super
    end

    def render(context)
      site = context.registers[:site]
      name = Digest::MD5.hexdigest(super)
      if !File.exists?(File.join(site.dest, "uml/#{name}.svg"))
        uml = File.join(site.source, "uml/#{name}.uml")
        FileUtils.mkdir_p(File.dirname(uml))
        File.open(uml, 'w') { |f|
          f.write("@startuml\n")
          f.write(super)
          f.write("\n@enduml")
        }
        system("plantuml -tsvg #{uml}")
        site.static_files << Jekyll::StaticFile.new(
          site, site.source, 'uml', "#{name}.svg"
        )
      end
      "<p><img src='/uml/#{name}.svg' alt='UML' style='width:100%;'/></p>"
    end
  end
end

Liquid::Template.register_tag('plantuml', Yegor::PlantumlBlock)
