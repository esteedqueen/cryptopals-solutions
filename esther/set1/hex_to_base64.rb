# Things I learnt while solving this
# Using Ruby's Base.encode64(s) on the bin value introduces the new line between y and b, which makes it not equal to the expected_output
# This is because it packs with .pack("m") Base64 Encoding (RFC 2045) which adds a new line at the end
# Base64 Encoding (RFC 2045) returns this "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hy\nb29t\n"
# Base64 Encoding (RFC 4648) returns this "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t" which is the expected value

require 'pp'       # class pretty printer for ruby objects [PP](https://ruby-doc.org/stdlib-2.3.1/libdoc/pp/rdoc/PP.html)

expected_output = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"

# convert hex string to bin, then, encode the array of bin value in Base64 Encoding (RFC 4648)
def hex_to_bin_to_base64(s)
  [[s].pack("H*")].pack("m0")
end

pp hex_to_bin_to_base64("49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d")

pp hex_to_bin_to_base64("49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d") == expected_output
