# frozen_string_literal: true

require 'rake/clean'

require 'rake/testtask'
task :test
Rake::TestTask.new do |t|
  t.test_files = FileList['test/test_*.rb']
  t.warning = true
end

require_relative 'lib/essential'
require 'yard'
YARD::Rake::YardocTask.new do |t|
  t.files = FileList.new %w[lib/*.rb lib/**/*.rb]
  t.options += ['--title', "Essential Ver. #{Essential::VERSION}"]
  t.options += ['--output-dir', '_site']
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) do |t|
  t.patterns = %w[lib test Rakefile]
end

CLOBBER << '_site'
task default: %i[clobber test rubocop]
