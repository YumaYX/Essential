# frozen_string_literal: true

require_relative 'parent_and_child'

# Essential
module Essential
  # Essential::Text
  module Text
    class << self
      # Extract text as key-value template.
      # @param text [String] The target text.
      # @param start_line [Regexp] The key text.
      # @return [Array<ParentAndChild>] An array of ParentAndChild objects.
      def extract_with_mark(text, start_line)
        text.each_line.each_with_object([]) do |line, array|
          if line.chomp! =~ start_line
            array << Essential::ParentAndChild.new(line)
          elsif !array.empty?
            array.last.add_child(line)
          end
        end
      end
    end
  end
end
