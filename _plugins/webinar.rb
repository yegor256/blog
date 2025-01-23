# frozen_string_literal: true

# Copyright (c) 2014-2025 Yegor Bugayenko
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

# My module
module Yegor
  # The class
  class WebinarBlock < Liquid::Tag
    def initialize(tag, markup, tokens)
      super
      @date, @number, @id, @title = markup.strip.split(' ', 4)
    end

    def render(context)
      date = Time.parse(@date)
      url = [
        'https://www.google.com/calendar/event',
        '?action=TEMPLATE',
        "&dates=#{CGI.escape("#{date.strftime('%Y%m%dT170000Z')}/#{date.strftime('%Y%m%dT190000Z')}")}",
        "&sprop=#{CGI.escape("website:https://www.youtube.com/watch?v=#{@id}")}",
        "&text=#{CGI.escape("#{@title} (webinar ##{@number})")}",
        "&location=#{CGI.escape('YouTube Live')}",
        "&details=#{CGI.escape("Webinar ##{@number} by Yegor Bugayenko, click here to join: https://www.youtube.com/watch?v=#{@id}")}"
      ].join
      [
        "<figure class='badge'><a href='#{CGI.escapeHTML url}' title='Click to add this even to Google Calendar'>",
        "<img src='#{Img.new('/images/calendar-icon.png', context)}'",
        "style='width:96px;max-width:100%;' alt='Click to add this even to Google Calendar'/>",
        '</a></figure>'
      ].join
    end
  end
end

Liquid::Template.register_tag('webinar', Yegor::WebinarBlock)
