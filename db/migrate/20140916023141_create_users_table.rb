class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
	    t.string :email
	    t.string :phone, limit: 10
    end
  end
end
