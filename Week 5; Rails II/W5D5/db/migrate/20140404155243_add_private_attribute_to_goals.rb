class AddPrivateAttributeToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :private?, :boolean,  default: false
  end
end
