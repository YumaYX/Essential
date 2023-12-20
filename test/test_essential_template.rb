# frozen_string_literal: true

require 'minitest/autorun'
require 'fileutils'

class TestEssentialTemplate < Minitest::Test
  def setup; end

  def teardown; end

  def test_compare_files
    assert(FileUtils.cmp(__FILE__, __FILE__))
  end
end
