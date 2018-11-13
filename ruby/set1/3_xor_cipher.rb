# Instructions
# Single-byte XOR cipher
# The hex encoded string:

# 1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736
# ... has been XOR'd against a single character. Find the key, decrypt the message.

# You can do this by hand. But don't: write code to do it for you.

# How? Devise some method for "scoring" a piece of English plaintext.
# Character frequency is a good metric. Evaluate each output and choose the one with the best score.

require 'test/unit'
require './lib'

# Rational:
# If a message is encypted by XORing it against a key, if you find the key and
# use it to XOR against the encrypted message, you'll get the decrypted message
# Ref: https://en.wikipedia.org/wiki/XOR_cipher

def byte_xor_cipher(hex_text)
  # First, convert hex to binary, then obtain the ASCII codes of the value
  # using ruby `.bytes`.
  ascii_codes_of_input_hex = Lib.hex_to_bin(hex_text).bytes

  # Pass in the ASCII codes of the hex input to decrypt the message
  decrypted_collection = Lib.decrypt_xor(ascii_codes_of_input_hex)
  decrypted_message = decrypted_collection[2]

  puts "The highest english frequency score is: " + "#{decrypted_collection[0]}"
  puts "The key's ASCII code is: " + "#{decrypted_collection[1]}"
  puts "The key is: " + Lib.to_text([decrypted_collection[1]])
  puts "The decrypted_message is: " + Lib.to_text(decrypted_message)

  # Convert the decrypted byte to english text
  Lib.to_text(decrypted_message)
end


class TestByteXorCipher < Test::Unit::TestCase
  def test_that_it_can_pass
    input = '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736'
    expected_output = "Cooking MC's like a pound of bacon"

    assert_equal(expected_output, byte_xor_cipher(input))
  end
end