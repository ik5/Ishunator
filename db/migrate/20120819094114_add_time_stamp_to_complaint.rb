class AddTimeStampToComplaint < ActiveRecord::Migration
  def change
    add_column :complaints, :complaint_time, :time, { :null => true}
  end
end
