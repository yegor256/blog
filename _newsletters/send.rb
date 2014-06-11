#!/usr/bin/env ruby
STDOUT.sync = true

require 'trollop'
require 'mail'
require 'uuidtools'

opts = Trollop::options do
  banner <<-EOS
Send newsletter to all blog subscribers

Usage: send.rb [options]
  EOS
  opt :host, 'SMTP host', :type=>String, :required=>true
  opt :port, 'SMTP port', :default=>25
  opt :user, 'SMTP user name', :type=>String, :required=>true
  opt :password, 'SMTP password', :type=>String, :required=>true
  opt :file, 'Absolute path to the list of emails', :type=>String, :required=>true
  opt :subject, 'Email subject', :type=>String, :required=>true
  opt :body, 'Email body file', :type=>String, :required=>true
  opt :dry, 'Dry run (always email to the same test address)', :default=>false
end

body = File.read(opts[:body])

Mail.defaults do
  delivery_method :smtp, address: opts[:host], port: opts[:port]
end

if opts[:dry]
  emails = ['test@yegor256.com']
else
  emails = File.readlines(opts[:file]).collect(&:strip)
end

puts "Sending #{emails.length} email(s) to #{opts[:host]}:#{opts[:port]} as #{opts[:user]}"
emails.each do |email|
  print "  sending to #{email}..."
  mail = Mail.deliver do
    from 'me@yegor256.com'
    to email
    subject opts[:subject]
    body body
    message_id "<#{UUIDTools::UUID.random_create}@yegor256.com>"
  end
  puts ' done'
end
