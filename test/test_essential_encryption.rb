# frozen_string_literal: true

require 'openssl'
require_relative './helper'

class TestEssentialEncryption < Minitest::Test
  def setup
    @temp_dir = Dir.mktmpdir

    @private_key = "#{@temp_dir}/private_key.pem"
    rsa_private = OpenSSL::PKey::RSA.generate(2048)
    File.write(@private_key, rsa_private)

    @public_key = "#{@temp_dir}/public_key.pem"
    rsa_public = rsa_private.public_key
    File.write(@public_key, rsa_public)
  end

  def teardown
    FileUtils.rm_rf(@temp_dir) if File.exist?(@temp_dir)
  end

  def test_encryption_and_decryption_with_rsa
    data = 'Essential Encryption'
    enc = Essential::Encryption.rsa_encrypt(data, @public_key)

    File.write(enc_file = "#{@temp_dir}/enc_file", enc)

    dec_from_raw = Essential::Encryption.rsa_decrypt(enc, @private_key, raw: true)
    assert_equal(data, dec_from_raw)

    dec_from_file = Essential::Encryption.rsa_decrypt(enc_file, @private_key)
    assert_equal(data, dec_from_file)
  end
end
