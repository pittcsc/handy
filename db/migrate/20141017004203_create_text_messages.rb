class CreateTextMessages < ActiveRecord::Migration
  def change
    create_table :text_messages do |t|
      t.string :phone_number, null: false
      t.string :body, null: false
      
      t.timestamps null: false
    end
  end
end
