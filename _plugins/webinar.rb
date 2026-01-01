# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

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
