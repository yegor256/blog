#!/usr/bin/env ruby
STDOUT.sync = true

ARGF.each_line do |line|
  date, id, name, twitter, email = line.split(',')
  puts "#{name},#{email}"
end
