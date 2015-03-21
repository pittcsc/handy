class CreateMembership < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :member
      t.belongs_to :organization

      t.timestamps
    end
  end
end
