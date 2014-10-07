class AddTokenToEvents < ActiveRecord::Migration
  def change
    add_column :events, :token, :string, null: false
    add_index  :events, :token, unique: true
  end
end
