class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commenter_id, null: false
      t.integer :commentable_id
      t.string :commentable_type
      t.text :body, null: false

      t.timestamps
    end

    add_index(:comments, :commenter_id)
    add_index(:comments, :commentable_id)
  end
end
