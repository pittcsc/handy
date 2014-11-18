class AddConstraintsToUsers < ActiveRecord::Migration
  def change
    change_column :users, :email, :string, null: false
    add_index :users, :email, unique: true

    remove_column :users, :password

    change_column :users, :password_digest, :string, null: false
  end
end
