class UpdateMemberPhoneLength < ActiveRecord::Migration
  def change
    change_column :members, :phone, :string, null: false
  end
end
