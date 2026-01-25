# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'elapsed'
require 'English'
require 'fileutils'
require 'html-proofer'
require 'net/http'
require 'nokogiri'
require 'qbash'
require 'rake'
require 'rake/clean'
require 'rubocop/rake_task'
require 'rubygems'
require 'shellwords'
require 'tempfile'
require 'w3c_validators'

VERBOSE = false

raise "Invalid encoding \"#{Encoding.default_external}\"" unless Encoding.default_external.to_s == 'UTF-8'

task default: [
  :build,
  :pages,
  :garbage,
  :spell,
  :regex,
  :excerpts,
  :snippets,
  :orphans,
  :ping,
  # :proofer,
  :rubocop
]

def done(msg)
  puts "#{msg}\n\n"
end

def all_html
  Dir['_site/**/*.html']
    .reject { |f| f.end_with?('.amp.html') }
    .reject { |f| f.start_with?('_site/en/') }
    .reject { |f| f.start_with?('_site/zh/') }
    .reject { |f| f.start_with?('_site/ru/') }
end

def all_links
  links = all_html.reduce([]) do |array, f|
    array + Nokogiri::HTML(File.read(f)).xpath(
      '//article//a/@href'
    ).to_a.map(&:to_s)
  end
  links.sort.map { |a| a.gsub(%r{^/}, 'https://www.yegor256.com/') }
end

desc 'Delete _site directory'
task :clean do
  elapsed do
    rm_rf '_site'
    rm_rf 'uml'
    rm_rf '.sass-cache'
    rm_rf '.jekyll-metadata'
    rm_rf '_temp'
    rm_rf 'gnuplot'
    throw :'Jekyll temporary files and directories deleted'
  end
end

desc 'Build Jekyll site'
task :build do
  if File.exist? '_site'
    done 'Jekyll site already exists in _site (run "rake clean" first)'
  else
    elapsed do
      qbash("jekyll build --trace --future -- #{ARGV.join(' ').match(/(?:^| )(-- .*)$/)}", log: $stdout)
      throw :'Jekyll site generated without issues'
    end
  end
end

desc 'Check the existence of all critical pages'
task pages: [:build] do
  elapsed do
    File.open('_rake/pages.txt').map(&:strip).each do |p|
      file = "_site/#{p}"
      raise "Page/directory #{file} is not found (try to run 'rake clean' and start over)" unless File.exist?(file)
      puts "#{file}: OK" if VERBOSE
    end
    throw :'Files correct places checked'
  end
end

desc 'Check the absence of garbage'
task garbage: [:build] do
  elapsed do
    File.open('_rake/garbage.txt').map(&:strip).each do |p|
      file = "_site/#{p}"
      raise "Page #{file} is still there" if File.exist? file
      puts "#{file}: absent, OK" if VERBOSE
    end
    %w[_posts static].each do |p|
      garbage = Dir["#{p}/**/*"].reject { |f| f.end_with?('.md') || !File.file?(f) }
      raise "Suspicious files in #{p}: #{garbage}" unless garbage.empty?
    end
    throw :'Garbage checked and nothing found'
  end
end

desc 'Validate a few pages for W3C compliance'
# It doesn't work now, because of: https://github.com/alexdunae/w3c_validators/issues/16
task w3c: [:build] do
  include W3CValidators

  elapsed do
    validator = MarkupValidator.new
    [
      'index.html',
      '2014/04/06/introduction.html'
    ].each do |p|
      file = "_site/#{p}"
      results = validator.validate_file(file)
      if results.errors.length.positive?
        results.errors.each do |err|
          puts err
        end
        raise "Page #{file} is not W3C compliant"
      end
      puts "#{p}: OK" if VERBOSE
    end
    throw :'HTML is W3C compliant'
  end
end

desc 'Validate a few pages through HTML proofer'
task proofer: [:build] do
  elapsed do
    HTMLProofer.check_directory(
      '_site',
      only_4xx: true,
      disable_external: true,
      log_level: :warn,
      validation: {
        report_invalid_tags: false,
        report_missing_names: true,
        report_script_embeds: true
      },
      parallel: {
        in_processes: 8
      },
      check_favicon: true,
      check_html: true,
      file_ignore: [
        '_site/2009/03/04/pdd.html',
        '_site/2017/05/02/unlimited-number-of-bugs.html'
      ]
    ).run
    throw :'HTML passed through html-proofer'
  end
end

desc 'Check spelling in all HTML pages'
task spell: [:build] do
  elapsed do
    bad_pages = 0
    bad_words = []
    typos = all_html.reduce(0) do |total, f|
      html = Nokogiri::HTML(File.read(f))
      html.search('//code').remove
      html.search('//script').remove
      html.search('//pre').remove
      html.search('//div[@class="nospell"]').remove
      html.search('//header').remove
      html.search('//footer').remove
      tmp = Tempfile.new(['yegor256-', '.txt'])
      text = html.xpath('//article//p|//article//h2|//article//h3').to_a.join(' ')
        .gsub(/[\n\r\t ]+/, ' ')
        .gsub(/&[a-z]+;/, ' ')
        .gsub(/&#[0-9]+;/, ' ')
        .gsub(/n[’']t/, ' not')
        .gsub(/[’']ll/, ' will')
        .gsub(/[’']ve/, ' have')
        .gsub(/[’']s/, ' ')
        .gsub(/[,:;<>?!-#$%^&@]+/, ' ')
      tmp << text
      tmp.flush
      tmp.close
      stdout = qbash(
        "cat #{Shellwords.escape(tmp.path)} |",
        'aspell -a --lang=en_US -W 3 --ignore-case --encoding=utf-8 -p ./_rake/aspell.en.pws |',
        'grep ^\\&',
        accept: nil
      )
      found = 0
      if stdout.empty?
        puts "#{f}: OK (#{text.split.size} words)" if VERBOSE
      else
        lines = stdout.split("\n")
        found = lines.size
        words = lines.map { |t| t.split[1] }
        bad_words += words
        puts "#{found} typos in #{f}: #{words.join(', ')}"
        puts stdout
        puts text if VERBOSE
        bad_pages += 1
      end
      total + found
    end
    unless typos.zero?
      puts "All typos:\n  #{bad_words.uniq.join("\n  ")}"
      raise "#{typos.size} typo(s) in #{bad_pages} pages"
    end
    throw :'No spelling errors'
  end
end

desc 'Ping some foreign links'
task ping: [:build] do
  elapsed do
    links = all_links.uniq
      .reject { |a| a.start_with?('https://www.yegor256.com/') }
      .reject { |a| a.include?('linkedin.com') }
      .grep(%r{^https?://.*})
      .reject { |a| a.start_with?('http://localhost') }
      .reject { |a| a.start_with?('https://www.youtube.com/watch?v=') }
      .shuffle
      .take(128)
    tmp = Tempfile.new(['yegor256-', '.txt'])
    tmp << links.join("\n")
    tmp.flush
    tmp.close
    out = Tempfile.new(['yegor256-', '.txt'])
    out.close
    puts "#{links.size} links found, testing them..."
    qbash("./_rake/ping.sh #{Shellwords.escape(tmp.path)} #{Shellwords.escape(out.path)}")
    errors = File.read(out).split("\n").reduce(0) do |cnt, p|
      code, link = p.split
      next nil if link.nil?
      if %w[200 403].include?(code)
        cnt
      else
        puts "#{link}: #{code}"
        cnt + 1
      end
    end
    total = links.size
    per = (100 * errors / total).to_i
    raise "#{errors} among #{total} links are broken (#{per}%)" unless per < 16
    throw :"#{total} links are found, #{errors} are broken, it's more or less OK (#{per}%)"
  end
end

desc 'Run RuboCop on all Ruby files'
RuboCop::RakeTask.new do |t|
  t.fail_on_error = true
end

desc 'Make sure all pages have excerpts'
task :excerpts do
  elapsed do
    Dir['_posts/**/*.md'].each do |f|
      raise "No excerpt in #{f}" unless File.read(f).include? '<!--more-->'
    end
    throw :'All articles have excerpts'
  end
end

desc 'Make sure there are no prohibited RegEx-es in generated HTMLs'
task regex: [:build] do
  elapsed do
    ptns = [
      /\s—\s[a-zA-Z]/,
      /("|&quot;)[,.?!]/,
      /\s&mdash;/,
      /&mdash;\s/
    ]
    errors = 0
    pages = 0
    all_html.each do |f|
      html = Nokogiri::HTML(File.read(f))
      html.search('//code').remove
      html.search('//script').remove
      html.search('//pre').remove
      text = html.xpath('//article//p').to_a.join(' ')
      ptns.each do |re|
        if re.match text
          puts "#{f}: #{re} found and it's prohibited"
          errors += 1
        end
      end
      pages += 1
    end
    raise "#{errors} violations of RegEx prohibition" unless errors.zero?
    throw :"No prohibited regular expressions in #{pages} pages"
  end
end

desc 'Make sure all snippets are compact enough'
task :snippets do
  elapsed do
    all_html.each do |f|
      lines = Nokogiri::HTML(File.read(f)).xpath(
        '//article//figure[@class="highlight"]/pre/code[not(contains(@class,"text"))]'
      ).to_a.map(&:to_s)
        .join("\n")
        .gsub(/<code [^>]+>/, '')
        .gsub(/<span class="[A-Za-z0-9-]+">/, '')
        .gsub(/<a href="[^"]+">/, '')
        .gsub(%r{</a>}, '')
        .gsub(%r{</code>}, "\n")
        .gsub(%r{</span>}, '')
        .gsub('&lt;', '<')
        .gsub('&gt;', '>')
        .split("\n")
      long = lines.reject { |s| s.length < 81 }
      raise "Too wide snippet in #{f}: #{long}" unless long.empty?
      puts "#{f}: OK (#{lines.size} lines)" if VERBOSE
    end
    throw :'All snippets are compact enough'
  end
end

desc 'Make sure there are no orphan articles (nobody cites them)'
task orphans: [:build] do
  elapsed do
    prefix = 'https://www.yegor256.com/'
    links = all_links
      .select { |a| a.start_with? prefix }
      .map { |a| a.gsub(/#.*/, '') }
    links += all_html.map { |f| f.gsub('_site', 'https://www.yegor256.com') }
    counts = {}
    links
      .grep(%r{.*/[0-9]{4}/[0-9]{2}/[0-9]{2}/.*})
      .reject { |a| a.end_with?('.amp.html') }
      .reject { |a| a.include?('2009/03/04/pdd') }
      .reject { |a| a.include?('2017/05/02/unl') }
      .group_by(&:itself)
      .each { |k, v| counts[k] = v.length }
    orphans = 0
    counts.each do |k, v|
      if v < 4
        puts "#{k} is an orphan (#{v})"
        orphans += 1
      else
        puts "#{k}: #{v}"
      end
    end
    raise "There are #{orphans} orphans" unless orphans.zero?
    throw :"There are no orphans in #{links.size} links"
  end
end
