# frozen_string_literal: true

require_relative './helper'

class TestEssentialIps < Minitest::Test
  def test_line_to_ips_networks
    expect = ['192.168.100.100 255.255.255.254', '192.168.100.101 255.255.255.254']
    lines = ['192.168.100.100/31', '192.168.100.100 255.255.255.254']
    lines.each { |ip| assert_equal(expect, Essential::Ips.line_to_ips(ip)) }
  end

  def test_line_to_ips_hosts
    expect = ['192.168.100.100 255.255.255.255']
    lines = ['host 192.168.100.100', '192.168.100.100']
    lines.each { |ip| assert_equal(expect, Essential::Ips.line_to_ips(ip)) }
  end
end
