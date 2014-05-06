class CreateShortenedUrlsTable < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :long_url
      t.string :short_url
      t.integer :submitter_id

      t.timestamps
    end

    add_index :shortened_urls, :submitter_id, {name: "submitter_id_index"}
    add_index :shortened_urls, :short_url, {name: "shortened_url_index", unique: true}
  end
end
