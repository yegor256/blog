require 'nokogiri'
require 'net/http'

def status(href)
  3.times do
    begin
      uri = URI(href)
      res = Net::HTTP.get_response(uri)
      return res.code.to_i
    rescue Exception => e
      puts 'failure, lets try again: ' + uri.to_s
    end
  end
end

file = ARGV[0]
xml = Nokogiri::XML(File.read(file))
xml.remove_namespaces!
links = xml.xpath('//img/@src')
puts "#{file}: #{links.length}"
xml.xpath('//img/@src|//*[@class="main"]//a/@href').each { |uri|
  next unless uri.to_s.index('http') == 0
  status = status(uri)
  puts "#{uri}: #{status}"
  if status >= 400
    exit -1
  end
}
