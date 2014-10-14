class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.belongs_to :event, null: false
      t.string :phone_number, null: false
      t.string :name
      t.string :email_address

      t.timestamps null: false
    end
  end
end
