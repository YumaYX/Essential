# frozen_string_literal: true

# ACT(TEST)
desc 'Test with act'
task :act do
  sh %(act -j test -W .github/workflows/test.yml)
end

# DEFAULT
require 'rake/clean'
CLOBBER.include('_site', 'output', '.yardoc')
task default: %i[clobber test rubocop]

# TEST
require 'rake/testtask'
task :test
Rake::TestTask.new do |t|
  t.test_files = FileList['test/test_*.rb']
  t.warning = true
end

# RUBOCOP
require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) do |t|
  t.patterns = %w[lib test Rakefile]
end

# YARD
require_relative 'lib/essential'
require 'yard'
YARD::Rake::YardocTask.new do |t|
  t.files = FileList.new %w[lib/*.rb lib/**/*.rb]
  t.options += ['--title', "Essential Ver. #{Essential::VERSION}"]
  t.options += ['--output-dir', '_site']
end
