# Instructions

# Detect single-character XOR
# One of the 60-character strings in this file has been encrypted by single-character XOR.

# Find it.

# (Your code from #3 should help.)

require './lib'
require 'test/unit'

def detect_single_char_xor(file)
  # read from file
  decrypted_collection = File.open(file) do |f|
    f.map do |string|
      string.tr!("\n","")
      # convert hex to binary, then to ascii bytes codes
      bytes = Lib.hex_to_bin(string).bytes

      # XOR decrypt using all possible ascii codes,
      # calculate english frequency score for each XORed bytes
      # and store all possible collections
      Lib.decrypt_xor(bytes)
    end.max
  end

  decrypted_message = decrypted_collection[-1]

  # Retrieve the highest and
  # return just the decrypted message which is the last item in the array

  puts "The highest english frequency score is: " + "#{decrypted_collection[0]}"
  puts "The key's ASCII code is: " + "#{decrypted_collection[1]}"
  puts "The key is: " + Lib.to_text([decrypted_collection[1]])
  puts "The decrypted_message is: " + Lib.to_text(decrypted_message)

  Lib.to_text(decrypted_message)
end

class TestDetectSingleCharXor < Test::Unit::TestCase
  def test_that_it_can_pass
    input = './challenge_data/set4.txt'
    expected_output = "Now that the party is jumping\n"

    assert_equal(expected_output, detect_single_char_xor(input))
  end
end