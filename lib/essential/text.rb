# frozen_string_literal: true

require_relative 'parent_and_child'

# Essential
module Essential
  # Essential::Text
  module Text
    class << self
      # Extracts text as key-value template.
      # @param text [String] The target text.
      # @param start_line [Regexp] The key text.
      # @param ref_array [Array<ParentAndChild>] The array to store ParentAndChild objects.
      # @return [Array<ParentAndChild>] An array of ParentAndChild objects.
      def extract_with_mark(text, start_line, ref_array = [])
        text.each_line do |line|
          if line.chomp! =~ start_line
            ref_array << Essential::ParentAndChild.new(line)
          elsif !ref_array.empty?
            ref_array.last.add_child(line)
          end
        end
        ref_array
      end

      # Extracts text from a file as key-value template.
      # @param filename [String] The path to the file.
      # @param start_line [Regexp] The key text.
      # @return [Array<ParentAndChild>] An array of ParentAndChild objects.
      def extract_with_mark_f(filename, start_line)
        array = []
        readline(filename) { |line| extract_with_mark(line, start_line, array) }
        array
      end

      # Converts lines of text into a hash, using a specified column as the key.
      #
      # @param text [String] The input text containing lines to be converted into a hash.
      # @param column_index [Integer] The index of the column to be used as the key (default is 0).
      # @param deliminator [String] The delimiter used to split each line into an array of values (default is ' ').
      # @param ref_hash [Hash] The hash to store the result (default is an empty hash).
      # @param duplex [Boolean] If true, allows duplicate keys in the resulting hash (default is false).
      # @return [Hash] The hash where keys are taken from the specified column and values are arrays of line values.
      # @raise [RuntimeError] If duplex is false (default) and duplicate keys are found in the lines.
      def lines_to_hash(text, column_index = 0, deliminator = ' ', ref_hash = {}, duplex: false)
        text.each_line do |line|
          line_array = line.split(deliminator)
          key = line_array[column_index]
          raise "Duplicate keys in lines: #{key}" if !duplex && ref_hash.key?(key)

          ref_hash.store(key, line_array)
        end
        ref_hash
      end

      # Converts lines of text from a file into a hash, using a specified column as the key.
      #
      # @param filename [String] The path to the file.
      # @param column_index [Integer] The index of the column to be used as the key (default is 0).
      # @param deliminator [String] The delimiter used to split each line into an array of values (default is ' ').
      # @param duplex [Boolean] If true, allows duplicate keys in the resulting hash (default is false).
      # @return [Hash] The hash where keys are taken from the specified column and values are arrays of line values.
      # @raise [RuntimeError] If duplex is false (default) and duplicate keys are found in the lines.
      def lines_to_hash_f(filename, column_index = 0, deliminator = ' ', duplex: false)
        hash = {}
        readline(filename) { |line| lines_to_hash(line, column_index, deliminator, hash, duplex: duplex) }
        hash
      end

      # Reads each line from the specified file and yields it to the provided block.
      #
      # @param filename [String] The path to the file.
      # @yield [line] The block to be executed for each line in the file.
      # @yieldparam line [String] The current line being processed.
      def readline(filename, &block)
        File.open(filename, 'r') { |text| text.each_line(&block) }
      end
    end
  end
end
