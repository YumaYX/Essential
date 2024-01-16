#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/essential'

unless ARGV.length.eql?(2)
  warn "Usage:\n  #{__FILE__} <file name> <file name>"
  exit 1
end

hash1 = Essential::Text.lines_to_hash_f(ARGV.first)
hash2 = Essential::Text.lines_to_hash_f(ARGV.last)

joined = Essential::Join.hash_join(hash1, hash2)

# Joined Hash
joined.first.each do |key, value|
  # TODO: Add code for the script.
end

# Not Matched
joined.last.each do |key|
  # TODO: Add code for the script.
end
