# frozen_string_literal: true

require 'ipaddr'

module Essential
  # The Ips module provides functionality related to IP addresses.
  module Ips
    class << self
      # Eliminate extra spaces in the input string.
      #
      # @param str [String] The input string to be formatted.
      # @return [String] The formatted string.
      def eliminate_extra_spaces(str)
        # Strips leading and trailing spaces, and replaces consecutive spaces with a single space.
        string = str.strip
        string.gsub!(/(\s)+/, ' ')
        string.gsub(%r{\s*/\s*}, '/')
      end

      # Edit the format for IP addresses in the given string.
      #
      # @param str [String] The input string to be formatted.
      # @return [String] The formatted string with '/' replacing spaces.
      def edit_format_for_ipaddr(str)
        # Removes 'host' at the beginning and replaces spaces with '/'.
        string = str.gsub(/^host /, '')
        string.gsub(/\s/, '/')
      end

      # Convert a line to an IPAddr object.
      #
      # @param line [String] The input line containing the IP address.
      # @return [IPAddr] The IPAddr object representing the IP address.
      def line_to_ip(line)
        # Formats the line, eliminating extra spaces and editing the format for IP addresses.
        temp_line = eliminate_extra_spaces(line)
        temp_line = edit_format_for_ipaddr(temp_line)
        IPAddr.new(temp_line)
      end

      # Convert a line to an array of IP addresses.
      #
      # @param line [String] The input line containing the IP address.
      # @return [Array<String>] An array of IP addresses with masks.
      def line_to_ips(line)
        # Converts the line to an IPAddr object and then creates an array of IP addresses.
        line_to_ip(line).to_range.to_a
      end
    end
  end
end
