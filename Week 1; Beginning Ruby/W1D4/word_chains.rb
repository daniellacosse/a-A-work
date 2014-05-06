require 'debugger'
class WordChains
  attr_reader :words_to_expand, :all_reachable_words, :candidate_words

  # def initialize(dictionary)
  #
  #   #@candidate_words = dictionary.select {|query| query.length == word.length}
  #   #@all_reachable_words = [word]
  #
  #
  # end

  def find_chain(source, target, dictionary = @candidate_words.dup) #dictionary = @candidate_words.dup
   # debugger
    dictionary = dictionary.dup.select! {|query| query.length == source.length}
   # puts "dic:"
    #p dictionary[0..10]

    words_to_expand = [source]
    parents = {}
   # p "WtP: "
   # p words_to_expand
    until (words_to_expand.empty?) do
      #p parents
      # p words_to_expand

      word_seed = words_to_expand.shift

      adjacent_words = adjacent_words(word_seed, dictionary)
     # p "adj words1"
    #  p adjacent_words[0..10]

      adjacent_words.delete_if do |adj_word|
        parents.has_key?(adj_word)
      end
     # p "adj words2"
      #p adjacent_words[0..10]
      adjacent_words.each do |adj_word|
        dictionary.delete_if {|candidate| candidate == adj_word}
        words_to_expand << adj_word
        parents[adj_word] = word_seed
        break if adj_word == target
        #@all_reachable_words << adj_word
      end
      # p words_to_expand
      break if parents.has_value?(target)
    end

    parents
  end

  # def explore_words(source, dictionary)
  #
  #   until (words_to_expand.empty?) do
  #     word_seed = words_to_expand.pop
  #
  #     adjacent_words = adjacent_words(word_seed, dictionary)
  #     adjacent_words.delete_if {|adj_word| @all_reachable_words.include? adj_word}
  #
  #     adjacent_words.each do |adj_word|
  #       @candidate_words.delete_if {|candidate| candidate == adj_word}
  #       words_to_expand << adj_word
  #       @all_reachable_words << adj_word
  #     end
  #   end
  #
  #   @all_reachable_words
  # end


  def adjacent_words(word, dictionary)
    #adj_words = filter_for_size(word, dictionary)
    #assume they come in at right size
    dictionary.select! {|query| query.length == word.length}
    adj_words = dictionary
    bad_words = []

    adj_words.each do |dict_word|
      first_strike = false
      sec_strike = false

      word.length.times do |index|
        if word[index] != dict_word[index]
          sec_strike = first_strike && true
          first_strike = true
          break if sec_strike
        end
      end

      bad_words << dict_word if first_strike && sec_strike
    end

    adj_words.select{|word| !bad_words.include? word }

  end

  def build_path_from_breadcrumbs(source, target, parents)
    path = []

    child = target
    path << child
    loop do
      child = parents[child]
      path << child

      if child == source
        #p child
        break
      end
    end
    path

  end

end