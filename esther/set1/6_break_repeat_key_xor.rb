require 'base64'
require './lib'
require 'test/unit'

def break_repeat_key_xor(file, keysize_range)
  decoded_input = Base64.decode64(File.read(file)).bytes.flatten
  keysize = guess_keysize(keysize_range, decoded_input)[1]

  puts "guessed keysize is: #{keysize}"
  #  break the ciphertext into blocks of KEYSIZE length
  blocks = decoded_input.each_slice(keysize).map { |e| e }

  # transpose blocks but using only same length arrays to get around the error:
  # `transpose': element size differs (5 should be 29) (IndexError)
  transposed_blocks = blocks.take(blocks.length - 1).transpose

  # Solve each block as if it was single-character XOR. You already have code to do this.
  max_decrypted_collection = transposed_blocks.map do |block|
        # XOR decrypt using all possible ascii codes,
        # calculate english frequency score for each XORed bytes
        # and store all possible collections' keys
    Lib.decrypt_xor(block)[1]
  end

  key = Lib.to_text(max_decrypted_collection)
  puts "The key is: #{key}"

  return key
end

def guess_keysize(keysize_range, decoded_input)
  keysize_range.map do |keysize|

    four_blocks_of_keysize_bytes = [decoded_input[0...keysize], decoded_input[keysize...2*keysize], decoded_input[2*keysize...3*keysize], decoded_input[3*keysize...4*keysize]]

    array_of_normalized_hamming_distances = four_blocks_of_keysize_bytes.combination(2).map { |a, b|
      Lib.hamming_distance(Lib.bin_to_hex(Lib.to_text(a)), Lib.bin_to_hex(Lib.to_text(b))) / keysize.to_f
    }

    average_normalized_hamming_distance = array_of_normalized_hamming_distances.reduce(:+) / 6
    # puts "Key size: #{keysize}, Normalized hamming_distance: #{average_normalized_hamming_distance}"

    [average_normalized_hamming_distance, keysize]
  end.min
end

class TestBreakRepeatKeyXor < Test::Unit::TestCase
  def test_that_it_can_pass
    keysize_range = (2..40)
    file = './challenge_data/set6.txt'

    # Hamming distance
    stringA = "this is a test"
    stringB = "wokka wokka!!!"
    hamming_distance = Lib.hamming_distance(Lib.bin_to_hex(stringA), Lib.bin_to_hex(stringB))
    puts "hamming distance is: #{hamming_distance}"

    guessed_keysize = guess_keysize(keysize_range, Base64.decode64(File.read(file)).bytes.flatten)[1]

    expected_key_output = 'Terminator X: Bring the noise'

    assert_equal(37, hamming_distance)
    assert_equal(29, guessed_keysize)
    assert_equal(expected_key_output, break_repeat_key_xor(file, keysize_range))
  end
end