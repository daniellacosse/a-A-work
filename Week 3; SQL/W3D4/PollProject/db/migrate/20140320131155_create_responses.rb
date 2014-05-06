class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :user_id
      t.integer :answer_choice_id

      t.timestamps
    end

    add_index :responses, :user_id, {name: "user_id_index"}
    add_index :responses, :answer_choice_id, {name: "answer_choice_id_index"}
  end
end
