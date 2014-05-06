class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :name, null: false
      t.integer :mod_id, null: false

      t.timestamps
    end

    add_index :subs, :mod_id
  end
end
