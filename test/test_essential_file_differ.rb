# frozen_string_literal: true

require_relative './helper'

class TestEssentialFileDiffer < Minitest::Test
  def setup
    @temp_dir = Dir.mktmpdir

    @files = 3.times.map do |index|
      temp_fname = "#{@temp_dir}/#{index}"
      # making 3 temp files by File.write
      File.write(temp_fname, index)
      # making array variable of 3 temp files by map :@files
      temp_fname
    end

    # one files
    @filelist1 = Essential::FileDiffer[@files[0]]
    # three files
    @filelist2 = Essential::FileDiffer["#{@temp_dir}/*"]
  end

  def teardown
    FileUtils.rm_rf(@temp_dir) if File.exist?(@temp_dir)
  end

  def md5digest(file_name)
    Digest::MD5.file(file_name).hexdigest
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

  def test_no_arg
    dup_file_name = "#{@temp_dir}/duplication"
    File.write(dup_file_name, '0')
    assert_equal(2, @filelist2.diff[md5digest(dup_file_name)].length)

    assert_equal(2, @filelist2.diff_uniq.length)
  end
end
