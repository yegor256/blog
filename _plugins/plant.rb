# Copyright (c) 2014-2017 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so. The Software doesn't include files with .md extension.
# That files you are not allowed to copy, distribute, modify, publish, or sell.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'uri'
require 'net/http'
require 'liquid'
require 'json'

module Yegor
  class PlantBlock < Liquid::Block
    def initialize(tag, markup, tokens)
      super
      @markup = markup.strip
    end

    # This block doesn't work. I don't know why. The URL returned by
    # www.planttext.com doesn't render.
    def render(context)
      api = URI.parse('https://www.planttext.com/api/scripting')
      http = Net::HTTP.new(api.host, api.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(api.request_uri)
      request['Content-Type'] = 'application/x-www-form-urlencoded'
      uml = "\n@startuml\n#{super}\n@enduml\n"
      request.set_form_data(type: 'svg', plantuml: uml)
      response = http.request(request)
      return "<p>Can't render PlantUML diagram.</p>" unless response.code == '200'
      url = response.body.gsub(/^"|"$/, '')
      puts "PlantUML SVG generated: #{url}"
      "<p><object data='#{url}' type='image/svg+xml' #{@markup}></object></p>"
    end
  end
end

Liquid::Template.register_tag('plant', Yegor::PlantBlock)
