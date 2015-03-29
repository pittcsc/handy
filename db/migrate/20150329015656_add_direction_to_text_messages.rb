class AddDirectionToTextMessages < ActiveRecord::Migration
  def change
    add_column :text_messages, :direction, :integer, null: false
  end
end
