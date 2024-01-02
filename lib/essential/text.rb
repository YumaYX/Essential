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

      # Converts lines of text into a hash, using a specified column as the key.
      # @param text [String] The input text containing lines to be converted into a hash.
      # @param column_index [Integer] The index of the column to be used as the key (default is 0).
      # @param deliminator [String] The delimiter used to split each line into an array of values (default is ' ').
      # @param duplex [Boolean] If true, allows duplicate keys in the resulting hash (default is false).
      # @return [Hash] The hash where keys are taken from the specified column and values are arrays of line values.
      # @raise [RuntimeError] If duplex is false (default) and duplicate keys are found in the lines.
      def lines_to_hash(text, column_index = 0, deliminator = ' ', duplex: false)
        text.each_line.each_with_object({}) do |line, hash|
          line_array = line.split(deliminator)
          key = line_array[column_index]
          raise "Duplicate keys in lines: #{key}" if !duplex && hash.key?(key)

          hash.store(key, line_array)
        end
      end
    end
  end
end
