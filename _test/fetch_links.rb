require 'nokogiri'

file = ARGV[0]
xml = Nokogiri::XML(File.read(file))
xml.remove_namespaces!
xml.xpath('//img/@src|//*[@class="main"]//a/@href').each { |uri|
  next unless uri.to_s.index('http') == 0
  puts uri
}
