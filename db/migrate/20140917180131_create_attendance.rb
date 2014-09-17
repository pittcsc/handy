class CreateAttendance < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.belongs_to :member
      t.belongs_to :event
    end
  end
end
