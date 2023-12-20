# frozen_string_literal: true

require_relative './helper'

class TestEssentialParentAndChild < Minitest::Test
  def setup
    @pac = Essential::ParentAndChild.new('Parent')
    @number = 6
    @number.times { |i| @pac.add_child("Child#{i}") }
  end

  def test_add_child
    @number.times { |i| assert_equal(@pac.children[i], "Child#{i}") }
  end

  def test_get_content_with_text
    expect = 'Parent'
    @number.times { |i| expect += "\nChild#{i}" }
    assert_equal(expect, @pac.make_list)
  end
end
