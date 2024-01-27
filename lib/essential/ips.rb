# frozen_string_literal: true

require 'ipaddr'

module Essential
  # Ips module provides functionality related to IP addresses.
  module Ips
    class << self
      # Eliminate extra spaces of the input string.
      #
      # @param str [String] The input string to be formatted.
      # @return [String] The formatted string.
      def eliminate_extra_spaces(str)
        str = str.strip
        str.gsub!(/(\s)+/, ' ')
        str.gsub!(%r{\s*/\s*}, '/')
        str
      end

      # Edit the format for IP addresses in the given string.
      #
      # @param [String] str The input string to be formatted.
      # @return [String] The formatted string with '/' replacing spaces.
      def edit_format_for_ipaddr(str)
        str.gsub!(/^host /, '')
        str.gsub!(/\s/, '/')
        str
      end

      # Convert a line to an IPAddr object.
      #
      # @param line [String] The input line containing the IP address.
      # @return [IPAddr] The IPAddr object representing the IP address.
      def line_to_ip(line)
        line = eliminate_extra_spaces(line)
        line = edit_format_for_ipaddr(line)
        IPAddr.new(line)
      end

      # Get the prefix of an IPAddr object.
      #
      # @param ip_target_object [IPAddr] The IPAddr object.
      # @return [String] The prefix of the IP address.
      def get_prefix(ip_target_object)
        temp = ip_target_object.inspect.gsub(%r{.*/}, '')
        temp.gsub(/>$/, '')
      end

      # Convert a line to an array of IP addresses.
      #
      # @param line [String] The input line containing the IP address.
      # @return [Array<String>] An array of IP addresses with masks.
      def line_to_ips(line)
        ip_object = line_to_ip(line)
        prefix = get_prefix(ip_object)
        ip_object.to_range.map { |ele| "#{ele} #{prefix}" }
      end
    end
  end
end
