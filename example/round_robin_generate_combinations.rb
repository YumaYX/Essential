#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/essential'

rr = Essential::RoundRobin.new(output_dir = 'output')

commands = %w[ls]
options  = %w[-d -l]
files    = %w[Gemfile Rakefile]

rr.generate_combinations(commands, options, files) do |combination|
  # TODO: fix code for the script.
  <<-COMBIEOF
# GENERATED BY Essential::RoundRobin#Egenerate_combinations
#{combination.join(' ')}
  COMBIEOF
end

# TODO: fix code for the script.
Dir.glob("#{output_dir}/*").each do |file|
  puts '# ' + file
  puts File.read(file)
  puts
end
