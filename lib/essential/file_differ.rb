# frozen_string_literal: true

require 'digest/md5'
require_relative './file_list'

# The Essential module contains classes for working with file lists.
module Essential
  # FileDiffer is a class for comparing two file lists and returning file differences as a hash.
  class FileDiffer < Essential::FileList
    # Compare two FileLists and return the file differences as a hash.
    # @param other [Essential::FileList] The FileList to compare with.
    # @return [Hash] A hash containing the file differences.
    def diff(other = FileDiffer.new)
      (to_a + other.to_a).each_with_object({}) do |element, hash|
        digest = Digest::MD5.file(element).hexdigest
        (hash[digest] ||= []) << element
      end
    end

    # Compare two FileLists and return unique file differences as a hash.
    # This method selects only the file differences with a count of 1.
    # @param other [Essential::FileList] The FileList to compare with.
    # @return [Hash] A hash containing the unique file differences.
    def diff_uniq(other = nil)
      diff(other).select { |_, value| value.length.eql?(1) }
    end
  end
end
