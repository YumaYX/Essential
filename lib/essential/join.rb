# frozen_string_literal: true

# Essential
module Essential
  # Essential::Join
  module Join
    class << self
      # Performs a hash join operation on two hashes.
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
      #   result = hash_join(hash1, hash2)
      #   # => [{:a=>1, :b=>[2, 4], :c=>[3, 5]}, [:d]]
      #
      # @note The original hashes remain unchanged.
      def hash_join(hash1, hash2)
        joined_hash = {}
        not_match = hash2.keys
        hash1.each do |key, value|
          if hash2.key?(key)
            value = [value, hash2[key]]
            not_match.delete(key)
          end
          joined_hash.store(key, value)
        end
        [joined_hash, not_match]
      end
    end
  end
end
