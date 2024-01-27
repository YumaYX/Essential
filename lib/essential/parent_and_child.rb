# frozen_string_literal: true

module Essential
  # This class represents a parent with a collection of children.
  class ParentAndChild
    attr_reader :parent
    attr_accessor :children

    # Initializes a new instance of ParentAndChild.
    # @param parent [Object] The parent object.
    def initialize(parent)
      @parent   = parent
      @children = []
    end

    # Adds a child to the collection.
    # @param child [Object] The child object to add.
    def add_child(child)
      @children << child
    end

    # Returns an array containing the parent and children of the family.
    #
    # @return [Array] An array containing the parent and children.
    def family
      [@parent] + @children
    end

    # Generates a key-value template text.
    # @return [String] The key-value template text.
    def make_list
      family.join("\n")
    end
  end
end
