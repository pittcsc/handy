class CreateCurrentEvent < ActiveRecord::Migration
  def change
    create_table :current_events do |t|
      t.belongs_to :event
    end
  end
end
