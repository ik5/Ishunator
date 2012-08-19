class RedoComplaintTimeProperly < ActiveRecord::Migration
  def change
    rename_column :complaints, :complaint_time, :complaint_start_time
    add_column :complaints, :end_time, :time, { :null => true}
  end
end
