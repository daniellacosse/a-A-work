class CreateTracks < ActiveRecord::Migration
  def change
    #also has a title
    create_table :tracks do |t|
      t.text :lyrics
      t.boolean :bonus
      t.integer :album_id

      t.timestamps
    end

    add_index(:tracks, :album_id)
  end
end
