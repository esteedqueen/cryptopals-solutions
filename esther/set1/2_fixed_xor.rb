require 'pp'       # class pretty printer for ruby objects [PP](https://ruby-doc.org/stdlib-2.3.1/libdoc/pp/rdoc/PP.html)

def xor_combine(a, b)
  # interpret the strings as hexadecimal base integers
  # use the XOR operator on both integers
  # convert the xor_sum result integer to hexadecimal string
  xor_sum = a.to_i(16) ^ b.to_i(16)
  xor_sum.to_s(16)
end

expected_output = "746865206b696420646f6e277420706c6179"

pp xor_combine("1c0111001f010100061a024b53535009181c", "686974207468652062756c6c277320657965") == expected_output
