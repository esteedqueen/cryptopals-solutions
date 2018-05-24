module Lib
  module_function

  def hex_to_bin(string)
    [string].pack('H*')
  end

  def bin_to_base64(array)
    array.pack('m0')
  end

  def bin_to_hex(string)
    string.unpack('H*').first
  end

  def to_text(bytes)
    bytes.flatten.pack('C*')
  end

  def score(bytes)
    # Compare each characters, the number of english alphabets found is the score
    to_text(bytes).chars.grep(/[ A-Za-z]/).length
  end

  def hamming_distance(hex_stringA, hex_stringB)
    # the number of position at which the bits are different
    (hex_stringA.to_i(16) ^ hex_stringB.to_i(16)).to_s(2).count('1')
  end

  def decrypt_xor(bytes)
    # There 256 ascii characters (bytes), XOR every possible ascii character representation
    # with each character in the converted bytes array values of the encrypted message (provided hex)
    # Collect all of the xored bytes values as one of them is the decrypted message

    possible_score_key_and_decrypted_message_collection =
      (0..255).map do |possible_character_key|
        decrypted_bytes = bytes.map { |x| x ^ possible_character_key }

        # Collect each xored bytes values, the english character frequency score of each xored bytes and
        # each possible character key into an array
        [score(decrypted_bytes), possible_character_key, decrypted_bytes]
      end

    # Retrieve the array with the highest english frequency score
    decrypted_collection = possible_score_key_and_decrypted_message_collection.max

    return decrypted_collection
  end

  def repeating_key_xor(text, key)
    # convert to ascii bytes representation
    input_bytes = text.bytes
    key_bytes = key.bytes

    # Iterate through each input while repeating the key using .cycle enumerator
    key_cycle = key_bytes.cycle(input_bytes.each_slice(key_bytes.length).to_a.length)
    encrypted_bytes = input_bytes.map { |e| e ^ key_cycle.next }

    return Lib.bin_to_hex(Lib.to_text(encrypted_bytes))
  end
end