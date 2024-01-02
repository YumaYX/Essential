# frozen_string_literal: true

require_relative './helper'

class TestJoin < Minitest::Test
  def test_hash_join
    expect1 = {
      'key0' => [%w[key0 value0], %w[key0 valueX]],
      'key1' => %w[key1 value1]
    }
    expect2 = ['key9']
    hash1 = Essential::Text.lines_to_hash("key0 value0\nkey1 value1")
    hash2 = Essential::Text.lines_to_hash("key0 valueX\nkey9 value9")

    assert_equal([expect1, expect2], Essential::Join.hash_join(hash1, hash2))
  end
end
