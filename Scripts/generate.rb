#!/usr/bin/env ruby
require 'fileutils'
require 'optparse'
require 'redcarpet'

# constants
SCRIPTS_DIR = File.dirname(__FILE__)
OUTPUT_DIR = File.expand_path(File.join(SCRIPTS_DIR, '..', 'HTML'))
TEXT_DIR = File.expand_path(File.join(SCRIPTS_DIR, '..', 'Text'))

class Generator
  def main
    parse_options
    prepare_output_dir
    markdown_files = get_markdown_files
    generate_index_html markdown_files
  end

  def die(msg)
    warn msg
    exit -1
  end

  def parse_options
    @options = {}
    OptionParser.new do |opt|
      opt.on('-f', '--force', 'delete output directory if already exists') do
        @options[:force] = true
      end
      opt.on('-n', '--dryrun', 'dryrun') do
        @options[:dryrun] = true
      end
      opt.on('-v', '--verbose', 'verbose') do
        @options[:verbose] = true
      end
      opt.on('-j', '--jekyll', 'export for jekyll') do
        @options[:jekyll] = true
      end
    end.parse!

    @fileutils_options = {}
    @fileutils_options[:verbose] = @options[:verbose]
    @fileutils_options[:noop] = @options[:dryrun]
    @fileutils_options[:force] = @options[:force]
  end

  def prepare_output_dir
    if File.exists? OUTPUT_DIR then
      if @options[:force] then
        # remove all files in dir
        FileUtils.rm_r(File.join(OUTPUT_DIR, '.'), @fileutils_options)
      else
        die "Directory #{OUTPUT_DIR} already exists"
      end
    else
      FileUtils.mkdir(OUTPUT_DIR, @fileutils_options)
    end
  end

  def get_markdown_files
    markdown_files = Dir[File.join(TEXT_DIR, '*.md')]
    markdown_files.empty? && die("Could not find any files in #{TEXTS_DIR}")
    markdown_files
  end

  def generate_index_html(markdown_files)
    index_html = setup_index_html
    generate_chapters(index_html, markdown_files)
    finish_index_html(index_html)
  end

  def setup_index_html
    index_filename = File.join(OUTPUT_DIR, @options[:jekyll] ? 'haxespel.html' : 'index.html')
    @options[:verbose] && warn("Generating #{index_filename}")
    index_html = @options[:dryrun] ? STDERR : File.open(index_filename, 'w')
    if @options[:jekyll] then
      index_html.write <<eos
---
title: HaxeSpel
layout: page
---
eos
    else
      index_html.write <<eos
<!DOCTYPE html>
<html lang="sv">
<head>
<meta charset="utf-8">
<title>HaxeSpel</title>
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">
</head>
<body>
<div class="container">
eos
    end
    index_html
  end

  def generate_chapters(index_html, markdown_files)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    markdown_files.each do |markdown_file|
      md = IO.read(markdown_file)
      md = preprocess_markdown(md)
      index_html.write(markdown.render(md))
    end
  end

  def preprocess_markdown(md)
    md = md.gsub(/^@include_git_show\(([^)]+)\)$/) do |_|
      git_show_arg = $1.split(' ')
      content = git_cmd('show', *git_show_arg)
      content.gsub(/^/, '    ')
    end
    md = md.gsub(/^@include_git_diff\(([^)]+)\)$/) do |_|
      git_diff_arg = $1.split(' ')
      content = git_cmd('diff', *git_diff_arg)
      content.gsub(/^/, '    ')
    end
    md
  end

  def finish_index_html(index_html)
    unless @options[:jekyll] then
      index_html.write <<eos
</div>
</body>
</html>
eos
    end
    !@options[:dryrun] || index_html.close
  end

  def git_cmd(*args)
    @options[:verbose] && warn("git #{args.join ' '}")
    IO.popen(['git'] + args) {|f| return f.read }
  end
end

Generator.new.main()
