class RemoveSmokingRoomMustPassThroughField < ActiveRecord::Migration
  def up
    remove_column :complaints, :smoking_room_must_pass_through
  end

  def down
    add_column :complaints, :smoking_room_must_pass_through, :boolean, :null => false, :default => false
  end
end
