class AddIndexToAccesses < ActiveRecord::Migration
  def change
    change_table :accesses do |t|
      t.index [:user_id, :organization_id], unique: true
    end
  end
end
