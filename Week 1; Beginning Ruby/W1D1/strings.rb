
def num_to_s(num, base)

  i = 0
  alphabet = ("A".."Z").to_a
  numerical_alphabet = {}
  10.times do
    numerical_alphabet[i] = i.to_s
    i += 1
  end

  j = 0
  26.times do
    numerical_alphabet[i] = alphabet[j]
    i += 1
    j += 1
  end

  p numerical_alphabet
  p alphabet


  n = 0
  str = []
  while base**n < num
    str << ((num / base**n) % base)
    n += 1
  end

  str.map!{|item| numerical_alphabet[item]}.join("").reverse!
end

#p num_to_s(234,10)
#p num_to_s(234,2)
#p num_to_s(234,16)


def caesar_cipher(str, offset)

  alphabet = ("a".."z").to_a

  new_str = ""
  str.each_char do |char|
    char_index = alphabet.index(char)
    if (char_index + offset) >= 26
      new_str << alphabet[char_index + offset - 26]
    else
      new_str << alphabet[char_index + offset]
    end
  end
  new_str
end

p caesar_cipher("hello",3)
