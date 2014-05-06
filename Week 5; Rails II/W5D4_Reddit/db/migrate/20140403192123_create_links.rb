class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :url
      t.text :body
      t.integer :poster_id
      t.integer :sub_id

      t.timestamps
    end

    add_index :links, :poster_id
    add_index :links, :sub_id
  end
end
