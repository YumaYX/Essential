# frozen_string_literal: true

# The Essential module provides essential functionalities.
module Essential
  # The Encryption module provides encryption and decryption methods using RSA.
  module Encryption
    class << self
      # Encrypts the given secret using RSA encryption with the specified public key.
      #
      # @param secret [String] The secret to be encrypted.
      # @param key [String] The path to the public key file.
      # @return [String] The encrypted secret.
      def rsa_encrypt(secret, key)
        public_key = OpenSSL::PKey::RSA.new(File.read(key))
        public_key.public_encrypt(secret)
      end

      # Decrypts the given secret using RSA decryption with the specified private key.
      #
      # @param secret [String] The secret to be decrypted.
      # @param key [String] The path to the private key file.
      # @param raw [Boolean] If true, interprets the secret as raw data; if false, reads the secret from a file.
      # @return [String] The decrypted secret.
      def rsa_decrypt(secret, key, raw: false)
        rsa = OpenSSL::PKey::RSA.new(File.read(key))
        rsa.private_decrypt(raw ? secret : File.read(secret))
      end
    end
  end
end
