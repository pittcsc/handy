class AddCurrentToEvents < ActiveRecord::Migration
  def change
    add_column :events, :current, :boolean, null: false, default: false
  end
end
