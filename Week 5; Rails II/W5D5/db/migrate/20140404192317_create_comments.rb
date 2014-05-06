class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |g|
      g.text :body
      g.integer :author_id
      g.references :commentable, polymorphic: true

      g.timestamps
    end
    add_index :comments, :author_id
  end
end
