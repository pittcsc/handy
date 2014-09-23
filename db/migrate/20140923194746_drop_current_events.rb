class DropCurrentEvents < ActiveRecord::Migration
  def change
    drop_table :current_events
  end
end
