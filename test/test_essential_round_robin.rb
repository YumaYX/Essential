# frozen_string_literal: true

require_relative './helper'

class TestEssentialRoundRobin < Minitest::Test
  def setup
    @temp_dir = Dir.mktmpdir
    @rr = Essential::RoundRobin.new(@temp_dir)

    @commands = %w[ls]
    @options  = %w[-d -1]
    @files    = %w[app.rb rakefile]
  end

  def teardown
    FileUtils.rm_rf(@temp_dir) if File.exist?(@temp_dir)
  end

  def test_generate_combinations_2_args
    @rr.generate_combinations(@commands, @options) { |combination| combination.join(' ') }
    common_assert(%w[ls_-d ls_-1])
  end

  def test_generate_combinations_3_args
    @rr.generate_combinations(@commands, @options, @files) { |combination| combination.join(' ') }
    common_assert(%w[ls_-d_app.rb ls_-1_app.rb ls_-d_rakefile ls_-1_rakefile])
  end

  def common_assert(array)
    array.each do |output_file|
      expect = output_file.gsub('_', ' ')
      content = File.read(File.join(@temp_dir, output_file))
      assert_equal(expect, content)
    end
  end
end
