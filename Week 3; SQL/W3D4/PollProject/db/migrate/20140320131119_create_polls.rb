class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title
      t.integer :author_id
      t.timestamps
    end
    add_index(:polls, :title, {name: "title_index"})
    add_index(:polls, :author_id, {name: "author_id_index"})
  end
end
