#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/essential'

unless ARGV.length.eql?(2)
  warn "Usage:\n  #{__FILE__} <file name> <'regexp of mark'>"
  exit 1
end

filename = ARGV.first
mark = Regexp.new(ARGV.last)

pacs = Essential::Text.extract_with_mark_f(filename, mark)
pacs.each do |pac|
  # TODO: Add text extraction code for the script.
end
