# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# Jekyll module
module Jekyll
  # The class
  class GnuplotFile < StaticFile
    def write(dest)
      target = File.join(dest, @dir, @name)
      FileUtils.copy_file(
        File.join(dest, "/../_temp/gnuplot/#{@name}"),
        target
      )
      puts "#{target} created (#{File.size(target)} bytes)"
      true
    end
  end

  # The class
  class GnuplotGenerator < Generator
    priority :low
    safe true
    def generate(site)
      Dir.glob("#{site.config['source']}/_gnuplot/**/*.gpi").each do |f|
        path = File.dirname(f).gsub(%r{^.*_gnuplot/}, '')
        base = File.basename(f).gsub(/\.gpi$/, '')
        puts `
          set -e
          dir=#{site.config['source']}
          cd ${dir}/_gnuplot/#{path}
          gnuplot #{base}.gpi
          mkdir -p ${dir}/_site/gnuplot/#{path}
          mkdir -p ${dir}/_temp/gnuplot/#{path}
          mv #{base}.svg ${dir}/_temp/gnuplot/#{path}
        `
        raise 'failed to build gnuplot image' unless $CHILD_STATUS.exitstatus
        site.static_files << Jekyll::GnuplotFile.new(site, site.dest, 'gnuplot', "#{path}/#{base}.svg")
      end
    end
  end
end
