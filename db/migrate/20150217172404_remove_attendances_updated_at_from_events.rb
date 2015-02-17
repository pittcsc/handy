class RemoveAttendancesUpdatedAtFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :attendances_updated_at
  end
end
