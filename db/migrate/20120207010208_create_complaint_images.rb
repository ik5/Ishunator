class CreateComplaintImages < ActiveRecord::Migration
  def up
    create_table(:complaint_images) do |t|
      t.references :complaint, :null => false
      t.has_attached_file :image
      t.timestamps
    end
    
    add_index(:complaint_images, :complaint_id)
  end

  def down
    drop_table(:complaint_images)
  end
end
