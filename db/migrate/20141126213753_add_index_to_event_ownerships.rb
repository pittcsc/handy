class AddIndexToEventOwnerships < ActiveRecord::Migration
  def change
    change_table :event_ownerships do |t|
      t.index [:event_id, :organization_id], unique: true
    end
  end
end
