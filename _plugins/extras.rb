# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# Jekyll module
module Jekyll
  # The class
  class RssFile < StaticFile
    def write(dest)
      FileUtils.copy_file(File.join(dest, 'rss.xml'), File.join(dest, 'rss'))
      true
    end
  end

  # The class
  class ExtraGenerator < Generator
    priority :low
    safe true
    def generate(site)
      site.static_files << Jekyll::RssFile.new(site, site.dest, '', 'rss.xml')
    end
  end
end
