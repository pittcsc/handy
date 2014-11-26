class CreateOrganizationsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :organizations_users, id: false do |t|
      t.integer :organization_id
      t.integer :user_id
    end

    add_index :organizations_users, [:organization_id, :user_id]
  end
end
