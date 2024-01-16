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

      # Generates combinations of arguments and creates files based on the combinations.
      #
      # @param args1 [Array] The first array of arguments.
      # @param args2 [Array] Additional arrays of arguments.
      #
      # @yield [Array] The block should return the contents for each combination.
      #
      # @example
      #   args1 = [:a, :b]
      #   args2 = [1, 2]
      #   Essential::Join.generate_combinations(args1, args2) do |combination|
      #     "Content for #{combination}"
      #   end
      def generate_combinations(args1, *args2)
        Dir.mkdir(Essential.result, 0o755) unless File.directory?(Essential.result)

        args1.product(*args2).each do |combination|
          file_name = combination.join('_')
          full_path = File.join(Essential.result, file_name)
          contents = yield(combination)
          next if contents.nil?

          File.write(full_path, contents.to_s)
        end
      end
    end
  end
end
