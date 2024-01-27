# frozen_string_literal: true

require_relative './helper'

class TestEssentialIps < Minitest::Test
  def test_line_to_ips_networks
    expect = [IPAddr.new('192.168.100.100/32'), IPAddr.new('192.168.100.101/32')]
    lines = ['192.168.100.100/31', '192.168.100.100 255.255.255.254']
    lines.each { |ip| assert_equal(expect, Essential::Ips.line_to_ips(ip)) }
  end

  def test_line_to_ips_hosts
    expect = [IPAddr.new('192.168.100.100/32')]
    lines = ['host 192.168.100.100', '192.168.100.100']
    lines.each { |ip| assert_equal(expect, Essential::Ips.line_to_ips(ip)) }
  end
end
