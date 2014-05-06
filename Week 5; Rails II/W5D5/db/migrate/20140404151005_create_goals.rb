class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |g|
      g.string :name
      g.text :description
      g.boolean :completed?, default: false
      g.integer :user_id

      g.timestamps
    end

    add_index :goals, :user_id
  end
end
