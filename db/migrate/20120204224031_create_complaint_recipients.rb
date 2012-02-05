class CreateComplaintRecipients < ActiveRecord::Migration
  def up
    create_table(:complaint_recipients) do |t|
      t.references :city, :null => false
      t.string :email, :null => false
      t.integer :recipient_type, :null => false, :default => 0
    end
    
    add_index(:complaint_recipients, :city_id)
    add_index(:complaint_recipients, :email, :unique => true)
  end

  def down
    drop_table(:complaint_recipients)
  end
end
