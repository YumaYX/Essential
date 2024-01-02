# frozen_string_literal: true

require_relative './helper'

class TestEssentialText < Minitest::Test
  def test_extract_with_mark
    text = File.read('testdata/extract_with_mark01.txt')

    assert_equal([], Essential::Text.extract_with_mark(text, /^UNIQUE$/))

    pacs = Essential::Text.extract_with_mark(text, /^MARK:/)
    pacs.each.with_index { |pac, index| assert_equal("text#{index}", pac.children[index]) }
  end

  def test_lines_to_hash
    expect = {}
    2.times do |index|
      key = "key#{index}"
      value = [key, "value#{index}"]
      expect.store(key, value)
    end
    assert_equal(expect, Essential::Text.lines_to_hash("key0 value0\nkey1 value1", 0, ' '))
  end

  def test_lines_to_hash_duplication
    lines = "key a\nkey b"
    e = assert_raises RuntimeError do
      Essential::Text.lines_to_hash(lines)
    end
    assert_equal 'Duplicate keys in lines: key', e.message
  end
end
