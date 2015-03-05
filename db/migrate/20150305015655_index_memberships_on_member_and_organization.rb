class IndexMembershipsOnMemberAndOrganization < ActiveRecord::Migration
  def change
    add_index :memberships, [:member_id, :organization_id], unique: true
  end
end
