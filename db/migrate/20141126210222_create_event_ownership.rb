class CreateEventOwnership < ActiveRecord::Migration
  def change
    create_table :event_ownerships do |t|
      t.belongs_to :event
      t.belongs_to :organization
    end
  end
end
