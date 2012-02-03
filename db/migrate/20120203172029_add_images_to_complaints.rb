class AddImagesToComplaints < ActiveRecord::Migration
  def up
    change_table :complaints do |t|
      t.has_attached_file :smoking_image1
      t.has_attached_file :smoking_image2
      t.has_attached_file :smoking_image3
    end
  end
  def down
    drop_attached_file :complaints, :smoking_image1
    drop_attached_file :complaints, :smoking_image2
    drop_attached_file :complaints, :smoking_image3
  end
end