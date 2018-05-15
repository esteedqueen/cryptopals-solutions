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
end