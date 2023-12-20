# frozen_string_literal: true

require_relative './helper'

class TestEssentialText < Minitest::Test
  def test_extract_with_mark
    text = File.read('testdata/extract_with_mark01.txt')

    assert_equal([], Essential::Text.extract_with_mark(text, /^UNIQUE$/))

    pac = Essential::Text.extract_with_mark(text, /^MARK:/)
    pac.each.with_index { |t, i| assert_equal("text#{i}", t.children[i]) }
  end
end
