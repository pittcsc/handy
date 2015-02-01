class AddMissingTimestamps < ActiveRecord::Migration
  def change
    change_table :accesses do |t|
      t.timestamps
    end

    change_table :attendances do |t|
      t.timestamps
    end

    change_table :event_ownerships do |t|
      t.timestamps
    end

    change_table :events do |t|
      t.timestamps
    end

    change_table :organizations do |t|
      t.timestamps
    end
  end
end
