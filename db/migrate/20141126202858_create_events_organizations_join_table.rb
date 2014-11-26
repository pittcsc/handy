class CreateEventsOrganizationsJoinTable < ActiveRecord::Migration
  def change
    create_table :events_organizations, id: false do |t|
      t.integer :event_id
      t.integer :organization_id
    end

    add_index :events_organizations, [:event_id, :organization_id]
  end
end
