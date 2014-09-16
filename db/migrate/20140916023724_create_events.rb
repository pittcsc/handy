class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
	t.string :name
	t.date	 :date
    end
  end
end
