require 'w3c_validators'

include W3CValidators

@validator = MarkupValidator.new
file = ARGV[0]
results = ''
attempt = 0
3.times do
  begin
    results = @validator.validate_file(file)
    break
  rescue Exception => e
    puts "failure, lets try again, attempt ##{attempt}: #{e}"
    attempt += 1
    raise 'W3C problem' if attempt > 2
  end
end
if results.errors.length > 0
  puts "#{file}: INVALID"
  results.errors.each do |err|
    puts err.to_s
  end
  exit -1
else
  puts "#{file}: valid"
end
