# http://cryptopals.com/sets/1/challenges/8
# Instructions
# Detect AES in ECB mode
# In this file are a bunch of hex-encoded ciphertexts.

# One of them has been encrypted with ECB.

# Detect it.

# Remember that the problem with ECB is that it is stateless and deterministic;
# the same 16 byte plaintext block will always produce the same 16 byte ciphertext.

require './lib'
require 'test/unit'
require 'base64'


def ecb_mode?(bytes_block)
  # In a block with 16 bytes arrays, the block with repeated 16 bytes arrays is in ecb mode,
  # so I'm checking if the actual block length is greater than the unique block length to identify the block in ecb mode
  bytes_block.length > bytes_block.uniq.length
end

def detect_aes_in_ecb(hex_encoded_cipher_texts)
  hex_encoded_cipher_texts.split("\n").map do |text_per_line|
    bytes16block = text_per_line.bytes.each_slice(16).to_a

    return text_per_line if ecb_mode?(bytes16block)
  end
end


class TestDetectAESInECBMode < Test::Unit::TestCase
  def test_that_it_can_pass
    input = File.read("./challenge_data/set8.txt")
    expected_output = 'd880619740a8a19b7840a8a31c810a3d08649af70dc06f4fd5d2d69c744cd283e2dd052f6b641dbf9d11b0348542bb5708649af70dc06f4fd5d2d69c744cd2839475c9dfdbc1d46597949d9c7e82bf5a08649af70dc06f4fd5d2d69c744cd28397a93eab8d6aecd566489154789a6b0308649af70dc06f4fd5d2d69c744cd283d403180c98c8f6db1f2a3f9c4040deb0ab51b29933f2c123c58386b06fba186a'

    puts detect_aes_in_ecb(input)

    assert_equal(expected_output, detect_aes_in_ecb(input))
  end
end