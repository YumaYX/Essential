# frozen_string_literal: true

# The Essential module contains essential functionalities.
module Essential
  # The Join module provides methods for joining data structures.
  module Join
    class << self
      # Performs a hash join operation on two hashes.
      #
      # Given two hashes, this method iterates through the keys of the first hash and checks
      # if the second hash contains a corresponding key. If a match is found, the values
      # associated with the matching keys are combined into an array. The method returns a
      # new hash containing the joined key-value pairs and an array of keys from the second
      # hash that did not have a corresponding key in the first hash.
      #
      # @param hash1 [Hash] The first hash to be joined.
      # @param hash2 [Hash] The second hash to be joined.
      # @return [Array<Hash, Array>] A two-element array containing the joined hash and
      #   an array of keys from the second hash that did not have a corresponding key in
      #   the first hash.
      #
      # @example
      #   hash1 = { :a => 1, :b => 2, :c => 3 }
      #   hash2 = { :b => 4, :c => 5, :d => 6 }
      #   result = Essential::Join.hash_join(hash1, hash2)
      #   # => [{:a=>1, :b=>[2, 4], :c=>[3, 5]}, [:d]]
      #
      # @note The original hashes remain unchanged.
      def hash_join(hash1, hash2)
        joined_hash = hash1.merge(hash2) { |_, hash1_val, hash2_val| [hash1_val, hash2_val] }
        not_match = hash2.keys - hash1.keys
        joined_hash.reject! { |key| not_match.include?(key) }
        [joined_hash, not_match]
      end

      # Generates combinations using the given arguments and executes a block for each combination.
      #
      # @param args1 [Array] The first array of arguments for combination generation.
      # @param args2 [Array] Additional arrays of arguments for combination generation.
      # @yield [combination] Block to be executed for each combination.
      # @yieldparam combination [Array] The current combination of arguments.
      # @yieldreturn [String] The contents to be written to a file for the current combination.
      # @return [void]
      def generate_combinations(args1, *args2)
        args1.product(*args2).each { |combination| yield(combination) || next }
      end

      # Generates combination files using the given arguments and executes a block for each combination.
      # The resulting files are saved in the 'result' directory within the Essential module.
      #
      # @param args1 [Array] The first array of arguments for combination generation.
      # @param args2 [Array] Additional arrays of arguments for combination generation.
      # @yield [combination] Block to be executed for each combination.
      # @yieldparam combination [Array] The current combination of arguments.
      # @yieldreturn [String] The contents to be written to a file for the current combination.
      # @return [void]
      def generate_combination_files(args1, *args2)
        Dir.mkdir(Essential.result, 0o755) unless File.directory?(Essential.result)

        generate_combinations(args1, *args2) do |combination|
          contents = yield(combination) || next
          contents = contents.to_s
          file_name = combination.join('_')
          full_path = File.join(Essential.result, file_name)
          File.write(full_path, contents)
          contents
        end
      end
    end
  end
end
