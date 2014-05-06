def rps(move)
  moves = ["Rock", "Paper", "Scissors"]
  computer_move = moves.sample

  move_index = moves.find_index(move)
  comp_index = moves.find_index(computer_move)

  if move_index == comp_index
    "#{computer_move}, Draw"
  elsif move_index + 1 % moves.length == comp_index
    "#{computer_move}, Lose"
  else
    "#{computer_move}, Win"
  end

end


def remix(ingredients)
  alcohols = []
  mixers = []
  new_ingredients = []

  ingredients.each do |pair|
    alcohols << pair[0]
    mixers << pair[1]
  end

  alcohols.shuffle!
  mixers.shuffle!

  alcohols.count.times do |i|
    new_ingredients << [alcohols[i], mixers[i]]
  end

  new_ingredients
end


