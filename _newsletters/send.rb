#!/usr/bin/env ruby
# Copyright (c) 2014-2018 Yegor Bugayenko
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

STDOUT.sync = true

require 'trollop'
require 'mail'
require 'uuidtools'
require 'liquid'
require 'redcarpet'
require 'rainbow'

opts = Trollop::options do
  banner <<-EOS
Send newsletter to all blog subscribers

Usage: send.rb [options]
  EOS
  opt :sender, 'Sender', :type=>String, :default=>'Yegor Bugayenko <yegor256@gmail.com>'
  opt :domain, 'Sending domain', :type=>String, :default=>'yegor256.com'
  opt :host, 'SMTP host/server', :type=>String, :default=>'email-smtp.us-east-1.amazonaws.com'
  opt :port, 'SMTP port', :default=>587
  opt :user, 'SMTP user name', :type=>String, :default=>'AKIAIPMIS45U6UG2TZCQ'
  opt :password, 'SMTP password', :type=>String, :required=>true
  opt :letter, 'Newsletter name, e.g. "2014/june"', :type=>String, :required=>true
  opt :subject, 'Email subject', :type=>String, :required=>true
  opt :skip, 'List of emails to skip, absolute file path', :type=>String, :default=>'/code/home/leads/skip.txt'
  opt :file, 'List of emails, absolute file path', :type=>String, :default=>'/code/home/subscribers.txt'
  opt :dry, 'Dry run (always email to test@yegor256.com)'
  opt :from, 'Start from this email', :type=>String
end

fs = Liquid::LocalFileSystem.new('./_newsletters')
Liquid::Template.file_system = fs
template = Liquid::Template.parse(File.read(fs.full_path('main')))

Mail.defaults do
  delivery_method :smtp, {
    :address => opts[:host],
    :port => opts[:port],
    :user_name => opts[:user],
    :password => opts[:password],
    :domain => 'yegor256.com',
    :enable_starttls_auto => true
  }
end

skip = File.readlines(opts[:skip]).map(&:strip)

if opts[:dry]
  emails = ['Yegor Bugayenko,test@yegor256.com']
else
  emails = File.readlines(opts[:file]).collect(&:strip).reject(&:empty?).uniq
end

total = 0
sent = []
ignore = !opts[:from].nil?
puts "Sending #{emails.length} email(s) to #{opts[:host]}:#{opts[:port]} as #{opts[:user]}"
emails.each do |line|
  if line.index(',').nil?
    email = line
    first = nil
    address = email
  else
    name, email = line.split(',')
    first, last = name.split(' ')
    if name.empty?
      address = email
    else
      address = "#{name} <#{email}>"
    end
  end
  email = email.strip.downcase
  markdown = template.render(
    'email' => email,
    'first' => first,
    'letter' => opts[:letter]
  )
  if ignore
    if opts[:from] == email
      ignore = false
    else
      print "  #{email} ignored (waiting for #{opts[:from]})\n"
      next
    end
  end
  if skip.include? email
    print "  #{address} #{Rainbow('skipped').red}\n"
    next
  end
  if sent.include? email
    print "  #{email} is a #{Rainbow('duplicate').red}\n"
    next
  end
  html = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(markdown)
  print "  sending to #{address}..."
  mail = Mail.new do
    from opts[:sender]
    to address
    subject "#{opts[:domain]}: #{opts[:subject]}"
    message_id "<#{UUIDTools::UUID.random_create}@#{opts[:domain]}>"
    text_part do
      content_type 'text/plain; charset=UTF-8'
      body markdown
    end
    html_part do
      content_type 'text/html; charset=UTF-8'
      body html
    end
  end
  mail.deliver!
  sent.push email
  total += 1
  puts " done (##{total})"
end

puts "sent #{sent.size} emails"
