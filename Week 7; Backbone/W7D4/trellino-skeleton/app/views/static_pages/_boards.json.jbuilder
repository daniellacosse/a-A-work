json.array! boards do |board|
  json.(board, :title, :id)

  json.lists board.lists do |list|
    json.(list, :title, :rank, :id, :board_id)

    json.cards list.cards do |card|
      json.(card, :id, :title, :description, :list_id, :rank)
    end
  end

  # json.array! board.lists
end