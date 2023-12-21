#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/essential'

if ARGV.empty?
  warn "Usage:\n  #{__FILE__} <glob> [glob] ..."
  exit 1
end

filelist = Essential::FileDiffer.new
ARGV.each { |glob| filelist.add(glob) }

filelist.diff.each { |sum, files| puts "#{sum} #{files.join(' ')}" }
