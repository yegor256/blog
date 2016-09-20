# encoding: utf-8

require 'rubygems'
require 'rake'
require 'tempfile'
require 'rake/clean'
require 'scss_lint/rake_task'
require 'w3c_validators'
require 'nokogiri'
require 'rubocop/rake_task'
require 'English'
require 'net/http'
require 'html-proofer'

task default: [
  # :clean,
  :build,
  :pages,
  :garbage,
  :scss_lint,
  :spell,
  :excerpts,
  :ping,
  # :jslint,
  # :proofer,
  # :rubocop,
  :others
]

def done(msg)
  puts msg + "\n\n"
end

desc 'Delete _site directory'
task :clean do
  rm_rf '_site'
  done 'Jekyll site directory deleted'
end

desc 'Lint SASS sources'
SCSSLint::RakeTask.new do |t|
  f = Tempfile.new(['yegor256-', '.scss'])
  f << File.open('css/layout.scss').drop(2).join("\n")
  f.flush
  f.close
  t.files = Dir.glob([f.path])
end

desc 'Build Jekyll site'
task :build do
  if File.exist? '_site'
    done 'Jekyll site already exists in _site (run "rake clean" first)'
  else
    system('jekyll build')
    fail 'Jekyll failed' unless $CHILD_STATUS.success?
    done 'Jekyll site generated without issues'
  end
end

desc 'Check the existence of all critical pages'
task pages: [:build] do
  File.open('_rake/pages.txt').map(&:strip).each do |p|
    file = "_site/#{p}"
    fail "Page #{file} is not found" unless File.exist? file
    puts "#{file}: OK"
  end
  done 'All files are in place'
end

desc 'Check the absence of garbage'
task garbage: [:build] do
  File.open('_rake/garbage.txt').map(&:strip).each do |p|
    file = "_site/#{p}"
    fail "Page #{file} is still there" if File.exist? file
    puts "#{file}: absent, OK"
  end
  done 'There is no garbage'
end

desc 'Validate a few pages for W3C compliance'
# It doesn't work now, because of: https://github.com/alexdunae/w3c_validators/issues/16
task w3c: [:build] do
  include W3CValidators
  validator = MarkupValidator.new
  [
    'index.html',
    '2014/04/06/introduction.html'
  ].each do |p|
    file = "_site/#{p}"
    results = validator.validate_file(file)
    if results.errors.length > 0
      results.errors.each do |err|
        puts err.to_s
      end
      fail "Page #{file} is not W3C compliant"
    end
    puts "#{p}: OK"
  end
  done 'HTML is W3C compliant'
end

desc 'Validate a few pages through HTML proofer'
task proofer: [:build] do
  HTMLProofer.check_directory(
    '_site',
    log_level: :warn,
    check_favicon: true,
    check_html: true,
    file_ignore: [/201[4-6].*/]
  ).run
  done 'HTML passed through html-proofer'
end

desc 'Check spelling in all HTML pages'
task spell: [:build] do
  typos = Dir['_site/**/*.html'].reject{ |f| f['.amp.html'] }.reduce(0) do |total, f|
    html = Nokogiri::HTML(File.read(f))
    html.search('//code').remove
    html.search('//script').remove
    html.search('//pre').remove
    html.search('//header').remove
    html.search('//footer').remove
    tmp = Tempfile.new(['yegor256-', '.txt'])
    text = html.xpath('//section//p|//section//h2|//section//h3').to_a.join(' ')
      .gsub(/[\n\r\t ]+/, ' ')
      .gsub(/&[a-z]+;/, ' ')
      .gsub(/&#[0-9]+;/, ' ')
      .gsub(/n't/, ' not')
      .gsub(/'ll/, ' will')
      .gsub(/'ve/, ' have')
      .gsub(/'s/, ' ')
      .gsub(/á|à/, 'a')
      .gsub(/Š/, 'S')
      .gsub(/[,:;<>?!-#$%^&@]+/, ' ')
    tmp << text
    tmp.flush
    tmp.close
    stdout = `cat "#{tmp.path}" \
      | aspell -a --lang=en_US -W 3 --ignore-case -p ./_rake/aspell.en.pws \
      | grep ^\\&`
    if stdout.empty?
      puts "#{f}: OK (#{text.split(' ').size} words)"
    else
      puts "Typos in #{f}:"
      puts stdout
    end
    total + stdout.split("\n").size
  end
  fail "#{typos.size} typo(s)" unless typos == 0
  done 'No spelling errors'
end

desc 'Ping all foreign links'
task ping: [:build] do
  links = Dir['_site/**/*.html'].reduce([]) do |array, f|
    array + Nokogiri::HTML(File.read(f)).xpath(
      '//article//a/@href[starts-with(.,"http://") or starts-with(.,"https://")]'
    ).to_a.map(&:to_s)
  end
    .sort
    .uniq
    .reject{ |a| a['http://www.yegor256.com/'] }
  tmp = Tempfile.new(['yegor256-', '.txt'])
  tmp << links.join("\n")
  tmp.flush
  tmp.close
  out = Tempfile.new(['yegor256-', '.txt'])
  out.close
  puts "#{links.size} links found, testing them..."
  system("./_rake/ping.sh #{tmp.path} #{out.path}")
  errors = File.read(out).split("\n").reduce(0) do |cnt, p|
    code, link = p.split(' ')
    next if link.nil?
    if code != '200'
      puts "#{link}: #{code}"
      cnt + 1
    else
      cnt
    end
  end
  fail "#{errors} broken link(s)" unless errors < 20
  done "All #{links.size} links are valid"
end

desc 'Run RuboCop on all Ruby files'
RuboCop::RakeTask.new do |t|
  t.fail_on_error = true
  t.requires << 'rubocop-rspec'
end

desc 'Test all JavaScript files with JSLint'
task :jslint do
  Dir['js/**/*.js'].each do |f|
    stdout = `jslint #{f}`
    fail "jslint failed at #{f}:\n#{stdout}" unless $CHILD_STATUS.success?
  end
  done 'JSLint says JavaScript files are clean'
end

desc 'Make sure all pages have excerpts'
task :excerpts do
  Dir['_posts/**/*.md'].each do |f|
    fail "No excerpt in #{f}" unless File.read(f).include? '<!--more-->'
  end
  done 'All articles have excerpts'
end

desc 'Other tests'
task others: [:build] do
  [
    'test_snippets.sh',
    'test_orphans.sh'
  ].each do |s|
    system("_rake/#{s}")
    fail "#{s} failed" unless $CHILD_STATUS.success?
    done "#{s} passed without issues"
  end
end

