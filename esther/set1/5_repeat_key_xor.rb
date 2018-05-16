# http://cryptopals.com/sets/1/challenges/5
# Instructions

# Implement repeating-key XOR
# Here is the opening stanza of an important work of the English language:

# Burning 'em, if you ain't quick and nimble
# I go crazy when I hear a cymbal
# Encrypt it, under the key "ICE", using repeating-key XOR.

# In repeating-key XOR, you'll sequentially apply each byte of the key; the first byte of plaintext will be XOR'd against I, the next C, the next E, then I again for the 4th byte, and so on.

# It should come out to:

# 0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272
# a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f
# Encrypt a bunch of stuff using your repeating-key XOR function. Encrypt your mail. Encrypt your password file. Your .sig file. Get a feel for it. I promise, we aren't wasting your time with this.
require './lib'
require 'test/unit'

def repeating_key_xor(text, key)
  # convert to ascii bytes representation
  input_bytes = text.bytes
  key_bytes = key.bytes

  # Iterate through each input while repeating the key using .cycle enumerator
  key_cycle = key_bytes.cycle(input_bytes.each_slice(key_bytes.length).to_a.length)
  encrypted_bytes = input_bytes.map { |e| e ^ key_cycle.next }

  return Lib.bin_to_hex(Lib.to_text(encrypted_bytes))
end

class TestRepeatKeyXor < Test::Unit::TestCase
  def test_that_it_can_pass
    input = "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal"
    expected_encrypted_output = "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f"
    key = "ICE"

    assert_equal(expected_encrypted_output, repeating_key_xor(input, key))
  end
end