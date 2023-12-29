# frozen_string_literal: true

require_relative './helper'

class TestEssentialParentAndChild < Minitest::Test
  def setup
    @pacs = Essential::ParentAndChild.new('Parent')
    @number = 6
    @number.times { |index| @pacs.add_child("Child#{index}") }
  end

  def test_add_child
    @number.times { |index| assert_equal(@pacs.children[index], "Child#{index}") }
  end

  def test_get_content_with_text
    expect = 'Parent'
    @number.times { |index| expect += "\nChild#{index}" }
    assert_equal(expect, @pacs.make_list)
  end
end
