class AddNullConstraintToTimestamps < ActiveRecord::Migration
  def up
    change_column :accesses, :created_at, :datetime, null: false
    change_column :accesses, :updated_at, :datetime, null: false

    change_column :attendances, :created_at, :datetime, null: false
    change_column :attendances, :updated_at, :datetime, null: false

    change_column :event_ownerships, :created_at, :datetime, null: false
    change_column :event_ownerships, :updated_at, :datetime, null: false

    change_column :events, :created_at, :datetime, null: false
    change_column :events, :updated_at, :datetime, null: false

    change_column :organizations, :created_at, :datetime, null: false
    change_column :organizations, :updated_at, :datetime, null: false

    change_column :users, :created_at, :datetime, null: false
    change_column :users, :updated_at, :datetime, null: false
  end

  def down
    change_column :accesses, :created_at, :datetime, null: true
    change_column :accesses, :updated_at, :datetime, null: true

    change_column :attendances, :created_at, :datetime, null: true
    change_column :attendances, :updated_at, :datetime, null: true

    change_column :event_ownerships, :created_at, :datetime, null: true
    change_column :event_ownerships, :updated_at, :datetime, null: true

    change_column :events, :created_at, :datetime, null: true
    change_column :events, :updated_at, :datetime, null: true

    change_column :organizations, :created_at, :datetime, null: true
    change_column :organizations, :updated_at, :datetime, null: true

    change_column :users, :created_at, :datetime, null: true
    change_column :users, :updated_at, :datetime, null: true
  end
end
