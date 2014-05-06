class Removesubidfromlink < ActiveRecord::Migration
  def change
    remove_column :links, :sub_id
  end
end
