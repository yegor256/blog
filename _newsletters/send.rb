#!/usr/bin/env ruby
STDOUT.sync = true

require 'trollop'
require 'mail'
require 'uuidtools'
require 'liquid'
require 'redcarpet'

opts = Trollop::options do
  banner <<-EOS
Send newsletter to all blog subscribers

Usage: send.rb [options]
  EOS
  opt :host, 'SMTP host/server', :type=>String, :default=>'email-smtp.us-east-1.amazonaws.com'
  opt :port, 'SMTP port', :default=>587
  opt :user, 'SMTP user name', :type=>String, :default=>'AKIAIPMIS45U6UG2TZCQ'
  opt :password, 'SMTP password', :type=>String, :required=>true
  opt :letter, 'Newsletter name, e.g. "2014/june"', :type=>String, :required=>true
  opt :subject, 'Email subject', :type=>String, :required=>true
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

skip = File.readlines('/code/home/leads/skip.txt').map(&:strip)

if opts[:dry]
  emails = ['Yegor Bugayenko,test@yegor256.com']
else
  emails = File.readlines(opts[:file]).collect(&:strip).reject(&:blank?).uniq
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
    address = "#{name} <#{email}>"
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
      print "  #{address} ignored\n"
      next
    end
  end
  if skip.include? email
    print "  #{address} skipped\n"
    next
  end
  if sent.include? email
    print "  #{email} is a duplicate\n"
    next
  end
  html = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(markdown)
  print "  sending to #{address}..."
  mail = Mail.new do
    from 'Yegor Bugayenko <yegor@teamed.io>'
    to address
    subject 'yegor256.com: ' + opts[:subject]
    message_id "<#{UUIDTools::UUID.random_create}@yegor256.com>"
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
