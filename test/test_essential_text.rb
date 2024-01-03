# frozen_string_literal: true

require_relative './helper'

class TestEssentialText < Minitest::Test
  def setup
    @expect_lines_to_hash = { 'key0' => %w[key0 value0], 'key1' => %w[key1 value1] }
  end

  def test_extract_with_mark
    text = File.read('testdata/extract_with_mark01.txt')
    assert_equal([], Essential::Text.extract_with_mark(text, /^UNIQUE$/))

    pacs = Essential::Text.extract_with_mark(text, /^MARK:/)
    pacs.each.with_index { |pac, index| assert_equal("text#{index}", pac.children[index]) }
    assert(!pacs.empty?)
  end

  def test_extract_with_mark_f
    filename = 'testdata/extract_with_mark01.txt'
    assert_equal([], Essential::Text.extract_with_mark_f(filename, /^UNIQUE$/))

    pacs = Essential::Text.extract_with_mark_f(filename, /^MARK:/)
    pacs.each.with_index { |pac, index| assert_equal("text#{index}", pac.children[index]) }
    assert(!pacs.empty?)
  end

  def test_lines_to_hash
    assert_equal(@expect_lines_to_hash, Essential::Text.lines_to_hash("key0 value0\nkey1 value1", 0, ' '))
  end

  def test_lines_to_hash_f
    assert_equal(@expect_lines_to_hash, Essential::Text.lines_to_hash_f('testdata/lines_to_hash01.txt'))
  end

  def test_lines_to_hash_column
    expect = { 'value0' => %w[key0 value0], 'value1' => %w[key1 value1] }
    assert_equal(expect, Essential::Text.lines_to_hash("key0 value0\nkey1 value1", 1, ' '))
  end

  def test_lines_to_hash_duplication
    lines = "key a\nkey b"
    e = assert_raises RuntimeError do
      Essential::Text.lines_to_hash(lines)
    end
    assert_equal 'Duplicate keys in lines: key', e.message
  end
end
