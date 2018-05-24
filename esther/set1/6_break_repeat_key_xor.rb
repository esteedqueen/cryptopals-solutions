require 'base64'
require './lib'

# KEYSIZE

keysize_range = (2..40)

# Hamming distance

stringA = "this is a test"
stringB = "wokka wokka!!!"

hamming_distance = Lib.hamming_distance(Lib.bin_to_hex(stringA), Lib.bin_to_hex(stringB))

puts hamming_distance

file = './challenge_data/set6.txt'

decoded_input1 = Base64.decode64(File.read(file))#.bytes.flatten

decoded_input = Lib.bin_to_hex(decoded_input1).bytes.flatten

# For each KEYSIZE, take the first KEYSIZE worth of bytes, and the second KEYSIZE worth of bytes, and find the edit distance between them. Normalize this result by dividing by KEYSIZE.

keysize_range.map do |keysize|

  four_blocks_of_keysize_bytes = [decoded_input[0...keysize], decoded_input[keysize...2*keysize]]

  normalized_hamming_distance = four_blocks_of_keysize_bytes.each_slice(2).map { |a, b|
    Lib.hamming_distance(Lib.to_text(a), Lib.to_text(b)) / keysize.to_f
  }

  # puts four_blocks_of_keysize_bytes.length
  # puts hamming_distances_array.length
  # puts hamming_distances_array

  # normalized_hamming_distance = hamming_distances_array.reduce(:+) / keysize.to_f

  puts "Key size: #{keysize}, Normalized hamming_distance: #{normalized_hamming_distance}"

end
