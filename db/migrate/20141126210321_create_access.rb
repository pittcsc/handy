class CreateAccess < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.belongs_to :user
      t.belongs_to :organization
    end
  end
end
