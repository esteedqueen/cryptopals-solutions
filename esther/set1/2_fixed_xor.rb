#Instructions

# Write a function that takes two equal-length buffers and produces their XOR combination.

# If your function works properly, then when you feed it the string:
# 1c0111001f010100061a024b53535009181c
# ... after hex decoding, and when XOR'd against:

# 686974207468652062756c6c277320657965
# ... should produce:

# 746865206b696420646f6e277420706c6179

require 'test/unit'

def hex_xor_combine(a, b)
  # interpret the strings as hexadecimal base integers
  # use the XOR operator on both integers
  xor_sum = a.to_i(16) ^ b.to_i(16)
  # convert the xor_sum result integer to hexadecimal string
  xor_sum.to_s(16)
end

class TestFixedXor < Test::Unit::TestCase
  def test_that_it_can_pass
    inputA = '1c0111001f010100061a024b53535009181c'
    inputB = '686974207468652062756c6c277320657965'
    expected_output = '746865206b696420646f6e277420706c6179'

    assert_equal(expected_output, hex_xor_combine(inputA, inputB))
  end
end