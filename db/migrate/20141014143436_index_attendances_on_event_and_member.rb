class IndexAttendancesOnEventAndMember < ActiveRecord::Migration
  def change
    add_index :attendances, [:event_id, :member_id], unique: true
  end
end
