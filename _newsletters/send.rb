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
  opt :host, 'SMTP host/server', :type=>String, :required=>true
  opt :port, 'SMTP port', :default=>25
  opt :user, 'SMTP user name', :type=>String, :required=>true
  opt :password, 'SMTP password', :type=>String, :required=>true
  opt :letter, 'Newsletter name, e.g. "2014/june"', :type=>String, :required=>true
  opt :subject, 'Email subject', :type=>String, :required=>true
  opt :file, 'List of emails, absolute file path', :type=>String, :required=>true
  opt :dry, 'Dry run (always email to test@yegor256.com)', :default=>false
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
    :domain => 'yegor256.com'
  }
end

if opts[:dry]
  emails = ['test@yegor256.com']
else
  emails = File.readlines(opts[:file]).collect(&:strip).uniq
end

puts "Sending #{emails.length} email(s) to #{opts[:host]}:#{opts[:port]} as #{opts[:user]}"
emails.each do |email|
  markdown = template.render(
    'email' => email,
    'letter' => opts[:letter]
  )
  html = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(markdown)
  print "  sending to #{email}..."
  mail = Mail.new do
    from 'Yegor Bugayenko <yegor@teamed.io>'
    to email
    subject opts[:subject]
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
  puts ' done'
end
