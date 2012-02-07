class RemoveImagesFromComplaints < ActiveRecord::Migration
  def up
    drop_attached_file :complaints, :smoking_image1
    drop_attached_file :complaints, :smoking_image2
    drop_attached_file :complaints, :smoking_image3
  end

  def down
    change_table :complaints do |t|
      t.has_attached_file :smoking_image1
      t.has_attached_file :smoking_image2
      t.has_attached_file :smoking_image3
    end
  end
end
