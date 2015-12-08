#!/usr/bin/env ruby
STDOUT.sync = true

emails = []
lines = []

list = '/code/home/subscribers.txt'

File.readlines(list).each do |row|
  line = row.strip
  next if line.empty?
  next if !line.include? '@'
  name, email = line.split(',')
  address = email.strip.downcase
  if !emails.include? address
    lines.push("#{name.strip},#{address}")
    emails.push(address)
  end
end

File.readlines('/Users/yegor/Downloads/leads.csv').each do |row|
  line = row.strip
  next if line.empty?
  date, id, name, twitter, email = line.split(',')
  address = email.strip.downcase
  if !emails.include? address
    lines.push("#{name.strip},#{address}")
    emails.push(address)
  end
end

File.open(list, 'w') do |f|
  lines.sort.each do |line|
    f << "#{line}\n"
  end
end

puts "#{lines.size} addresses saved to #{list}"
