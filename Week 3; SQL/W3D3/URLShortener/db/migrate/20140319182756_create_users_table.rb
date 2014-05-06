class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email

      t.timestamps
    end

    add_index(:users, :email, {name: "email-index", unique: true})
  end
end
