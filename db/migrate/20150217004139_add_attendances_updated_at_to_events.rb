class AddAttendancesUpdatedAtToEvents < ActiveRecord::Migration
  def change
    add_column :events, :attendances_updated_at, :datetime
  end
end
