class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.string :recording
      t.integer :band_id


      t.timestamps
    end

    add_index(:albums, :band_id)
  end
end
