#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/essential'

unless ARGV.length.eql?(2)
  warn "Usage:\n  #{__FILE__} <file name> 'regexp of mark'"
  exit 1
end

text = File.read(ARGV.first)
mark = Regexp.new(ARGV.last)

pacs = Essential::Text.extract_with_mark(text, mark)
pacs.each do |pac|
  # TODO: Add text extraction code for the script.
  # https://yumayx.github.io/Essential/Essential/ParentAndChild.html
end
