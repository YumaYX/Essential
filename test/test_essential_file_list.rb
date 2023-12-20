# frozen_string_literal: true

require_relative './helper'

class TestEssentialFileList < Minitest::Test
  def setup
    @temp_dir = Dir.mktmpdir
    FileUtils.mkdir_p("#{@temp_dir}/dir")

    @not_exist = 'not_exist'

    @files = 3.times.map do |i|
      t = "#{@temp_dir}/#{i}"
      # making 3 temp files by File.write
      File.write(t, i)
      # making array variable of 3 temp files by map :@files
      t
    end
  end

  def teardown
    FileUtils.rm_rf(@temp_dir) if File.exist?(@temp_dir)
  end

  def test_add
    # filelist: one file
    filelist1 = Essential::FileList[@files[0], @not_exist]
    # add path by multi args
    filelist1.add(@files[1], @files[2])
    assert_equal(@files, filelist1.to_a)

    # filelist: empty
    fileliste = Essential::FileList[@not_exist]
    # add path by array
    fileliste.add(@files)
    assert_equal(@files, fileliste.to_a)
  end

  def test_exclude
    # filelist: three files, one directory
    filelist2 = Essential::FileList["#{@temp_dir}/*"]
    # add exclude
    filelist2.add_exclude([@files[0], @files[1]])
    filelist2.add_exclude(@files[2], @not_exist)
    assert_equal([], filelist2.to_a)

    # clear exclude
    filelist2.clear_exclude
    assert_equal(@files, filelist2.to_a)
  end
end
