class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.belongs_to :event, null: false, index: true
      t.string :phone_number, null: false
      t.string :name
      t.string :email_address

      t.timestamps null: false
    end

    add_index :registrations, :phone_number
  end
end
