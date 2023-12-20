# frozen_string_literal: true

require_relative './helper'

class TestEssentialFileDiffer < Minitest::Test
  def setup
    @temp_dir = Dir.mktmpdir

    @files = 3.times.map do |i|
      t = "#{@temp_dir}/#{i}"
      # making 3 temp files by File.write
      File.write(t, i)
      # making array variable of 3 temp files by map :@files
      t
    end

    # one files
    @filelist1 = Essential::FileDiffer[@files[0]]
    # three files
    @filelist2 = Essential::FileDiffer["#{@temp_dir}/*"]
  end

  def teardown
    FileUtils.rm_rf(@temp_dir) if File.exist?(@temp_dir)
  end

  def md5digest(file)
    Digest::MD5.file(file).hexdigest
  end

  def test_diff
    diff = @filelist2.diff(@filelist1)
    assert_equal(2, diff[md5digest(@files[0])].length)
    assert_equal(1, diff[md5digest(@files[1])].length)
    assert_equal(1, diff[md5digest(@files[2])].length)
  end

  def test_diff_uniq
    expect = {
      md5digest(@files[1]) => [@files[1]],
      md5digest(@files[2]) => [@files[2]]
    }
    assert_equal(expect, @filelist2.diff_uniq(@filelist1))
  end
end
