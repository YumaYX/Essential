#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/essential'

commands = %w[ls]
options  = %w[-d -l]
files    = %w[Gemfile Rakefile]

Essential::Join.generate_combinations(commands, options, files) do |combination|
  <<-COMBIEOF
# GENERATED BY Essential::RoundRobin#generate_combinations
#{combination.join(' ')}

  COMBIEOF
end

Dir.glob(Essential.result + '/*').map { |file| puts File.read(file) }