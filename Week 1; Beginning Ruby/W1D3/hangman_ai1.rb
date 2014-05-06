def dictionary_filter(guesses)
  @dictionary.select! { |word| word.length == guesses.length}

  #figure out how to tell computer there was an incorrect guess
  @incorrect_guesses.each do |char|
    @dictionary.select! { |word| word.include?(char) }
  end

  @dictionary.select! do |word|
    word_chars = word.split("")
    word_chars.each_index do |idx|
      next if guesses[idx].nil?
      guesses[idx] == word_chars[idx]
    end.all?
  end
end