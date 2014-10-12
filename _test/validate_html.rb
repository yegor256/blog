require 'w3c_validators'

include W3CValidators

@validator = MarkupValidator.new
file = '_site/index.html'
results = ''
3.times do
  begin
    results = @validator.validate_file(ARGV[0])
    break
  rescue Exception => e
    logger.info "Oh Noes!"
  end
end
if results.errors.length > 0
  results.errors.each do |err|
    puts err.to_s
  end
  exit -1
else
  puts 'Valid!'
end
