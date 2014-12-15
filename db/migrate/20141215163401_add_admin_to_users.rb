class AddAdminToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :admin, null: false, default: false
      t.index :admin
    end
  end
end
