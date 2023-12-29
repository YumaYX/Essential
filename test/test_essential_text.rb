# frozen_string_literal: true

require_relative './helper'

class TestEssentialText < Minitest::Test
  def test_extract_with_mark
    text = File.read('testdata/extract_with_mark01.txt')

    assert_equal([], Essential::Text.extract_with_mark(text, /^UNIQUE$/))

    pacs = Essential::Text.extract_with_mark(text, /^MARK:/)
    pacs.each.with_index { |pac, index| assert_equal("text#{index}", pac.children[index]) }
  end
end
