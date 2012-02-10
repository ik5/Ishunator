class AddIndexToUserIdForComplaints < ActiveRecord::Migration
  def change
    add_index(:complaints, :statement_id)
  end
end
