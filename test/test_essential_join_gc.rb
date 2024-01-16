# frozen_string_literal: true

require_relative './helper'

class TestEssentialJoinGC < Minitest::Test
  def setup
    Essential.result = Dir.mktmpdir
    @temp_dir = Essential.result

    @commands = %w[ls]
    @options  = %w[-d -1]
    @files    = %w[Gemfile Rakefile]
  end

  def teardown
    FileUtils.rm_rf(@temp_dir) if File.exist?(@temp_dir)
  end

  def test_generate_combinations_2_args
    Essential::Join.generate_combinations(@commands, @options) { |combination| combination.join(' ') }
    common_assert(%w[ls_-d ls_-1])
  end

  def test_generate_combinations_3_args
    Essential::Join.generate_combinations(@commands, @options, @files) { |combination| combination.join(' ') }
    common_assert(%w[ls_-d_Gemfile ls_-1_Gemfile ls_-d_Rakefile ls_-1_Rakefile])
  end

  def common_assert(array)
    array.each do |output_file|
      expect = output_file.gsub('_', ' ')
      content = File.read(File.join(@temp_dir, output_file))
      assert_equal(expect, content)
    end
  end

  def test_generate_combinations_include_nil
    Essential::Join.generate_combinations([1, 2], [100]) do |combination|
      multi = combination.first * combination.last
      multi if multi.eql?(200) # value or nil
    end
    assert(!File.exist?(File.join(@temp_dir, '1_100')))
    assert(File.exist?(File.join(@temp_dir, '2_100')))
  end
end
