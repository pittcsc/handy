class AddIndexToMembersPhone < ActiveRecord::Migration
  def change
    add_index :members, :phone
  end
end
