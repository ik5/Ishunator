class FixEventDateNullToFalse < ActiveRecord::Migration
  def up
    change_column :complaints, :event_date, :date, :null => false
  end

  def down
    change_column :complaints, :event_date, :date, :null => true
  end
end
