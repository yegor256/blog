#!/usr/bin/env ruby
STDOUT.sync = true

require 'trollop'
opts = Trollop::options do
  banner <<-EOS
send newsletter to all blog subscribers

Usage: send.rb [options]
  EOS
  opt :host, 'SMTP host', :type=>String, :required=>true
  opt :port, 'SMTP port', :default=>25
  opt :user, 'SMTP user name', :type=>String, :required=>true
  opt :password, 'SMTP password', :type=>String, :required=>true
  opt :file, 'Absolute path to the list of emails', :type=>String, :required=>true
  opt :subject, 'Email subject', :type=>String, :required=>true
  opt :body, 'Email body file', :type=>String, :required=>true
end

host = opts[:host]
puts "Sending emails to #{opts[:host]}:#{opts[:port]} as #{opts[:user]}"

require 'mail'
require 'uuidtools'

body = File.read(opts[:body])

Mail.defaults do
  delivery_method :smtp, address: opts[:host], port: opts[:port]
end

File.readlines(opts[:file]).collect(&:strip).each do |email|
  print "  sending to #{email}..."
  mail = Mail.deliver do
    from 'me@yegor256.com'
    to email
    message_id "<#{UUIDTools::UUID.random_create}@yegor256.com>"
    subject opts[:subject]
    body body
  end
  puts mail.to_s
  puts ' done'
end
