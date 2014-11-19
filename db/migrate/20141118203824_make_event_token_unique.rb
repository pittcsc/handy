class MakeEventTokenUnique < ActiveRecord::Migration
  def change
    change_column :events, :token, :string, null: false, unique: true
  end
end
