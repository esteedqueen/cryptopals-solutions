# http://cryptopals.com/sets/1/challenges/7

# Instructions
# AES in ECB mode
# The Base64-encoded content in this file has been encrypted via AES-128 in ECB mode under the key

# "YELLOW SUBMARINE".
# (case-sensitive, without the quotes; exactly 16 characters; I like "YELLOW SUBMARINE" because it's exactly 16 bytes long, and now you do too).

# Decrypt it. You know the key, after all.

# Easiest way: use OpenSSL::Cipher and give it AES-128-ECB as the cipher.

require 'openssl'
require 'base64'
require './lib'
require 'test/unit'

def decrypt_aes_in_ecb_mode(cipher_text_bytes, key)
  # Reference - https://ruby-doc.org/stdlib-2.4.0/libdoc/openssl/rdoc/OpenSSL/Cipher.html

  decipher = OpenSSL::Cipher::AES.new(128, :ECB)
  decipher.decrypt
  decipher.key = key

  decrypted_text = decipher.update(cipher_text_bytes) + decipher.final

  puts decrypted_text
  return decrypted_text
end


class TestDecryptAESInECBMode < Test::Unit::TestCase
  def test_that_it_can_pass
  cipher_text_in_bytes = Base64.decode64(File.read("./challenge_data/set7.txt"))
  key = 'YELLOW SUBMARINE'
  expected_first_line = "I'm back and I'm ringin' the bell "

  first_line = decrypt_aes_in_ecb_mode(cipher_text_in_bytes, key).split("\n")[0]

  assert_equal(expected_first_line, first_line )
  end
end