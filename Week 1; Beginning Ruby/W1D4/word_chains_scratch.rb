#WHY IS 'source' PASSED AS A PARAMETER? WE NEVER USE IT
  def find_chain(source, target, dictionary)

    parents = {}

    until (parents.has_value?(target)) do
      word_seed = @words_to_expand.pop

      adjacent_words = adjacent_words(word_seed, dictionary)
      adjacent_words.delete_if do |adj_word|
        parents.has_value?(adj_word)
      end

      adjacent_words.each do |adj_word|
        @candidate_words.delete_if {|candidate| candidate == adj_word}
        @words_to_expand << adj_word unless

        parents[adj_word] = word_seed
        break if adj_word == target
        #@all_reachable_words << adj_word
      end
    end

    parents
  end

  def build_path_from_breadcrumbs

  end