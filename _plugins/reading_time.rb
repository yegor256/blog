# reading_time
#
# A Liquid filter to estimate how long a passage of text will take to read
#
# https://github.com/bdesham/reading_time
#
# Copyright (c) Benjamin Esham, 2013
# See README.md for full copyright information.

require 'nokogiri'

module Jekyll
	module ReadingTime

		def count_words(html)
			words(html).length
		end

		def reading_time(html)
			(count_words(html) / 270.0).ceil
		end

		private

		def text_nodes(root)
			ignored_tags = %w[ area audio canvas code embed footer form img
				map math nav object pre script svg table track video ]

			texts = []
			root.children.each { |node|
				if node.text?
					texts << node.text
				elsif not ignored_tags.include? node.name
					texts.concat text_nodes node
				end
			}
			texts
		end
		

		def words(html)
			fragment = Nokogiri::HTML.fragment html
			text_nodes(fragment).map { |text| text.scan(/[[:word:]]+/)}.flatten
		end

	end
end

Liquid::Template.register_filter(Jekyll::ReadingTime)
