class CreateVisitsTable < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :user_id
      t.string :shortened_url_id

      t.timestamps
    end

    add_index :visits, :user_id, {name: 'user_id_index'}
    add_index :visits, :shortened_url_id, {name: 'shortened_url_id_index'}
  end
end
