class RenameCurrentToActive < ActiveRecord::Migration
  def change
    rename_column :events, :current, :active
  end
end
