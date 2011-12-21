class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.references :city
      t.date    :event_date
      t.integer :business_type, :null => false
      t.string  :business_type_other
      t.string  :business_name, :null => false
      t.string  :business_address, :null => false
      
      t.boolean :smoking_person, :null => false, :default => false
      t.boolean :smoking_ashtrays, :null => false, :default => false
      t.boolean :smoking_ashtrays_details, :null => false, :default => false
      t.boolean :smoking_room_not_seperate, :null => false, :default => false
      t.boolean :smoking_room_too_large, :null => false, :default => false
      t.boolean :smoking_room_must_pass_through, :null => false, :default => false
      t.boolean :smoking_room_must_pass_through_to_public_area, :null => false, :default => false
      t.boolean :smoking_room_must_pass_through_to_bathroom, :null => false, :default => false
      t.string  :smoking_room_must_pass_through_to_other
      t.boolean :smoking_room_not_closed, :null => false, :default => false
      t.string  :smoking_room_smoking_outside_details
      t.boolean :smoking_no_signs, :null => false, :default => false
      t.boolean :smoking_signs_too_small, :null => false, :default => false
      t.boolean :smoking_signs_not_at_height, :null => false, :default => false
      t.boolean :smoking_signs_hidden, :null => false, :default => false
      t.string  :smoking_signs_hidden_details
      
      t.string  :complaint_sender_name
      
      t.string  :statement_full_name
      t.string  :statement_address
      t.string  :statement_phone
      t.string  :statement_email
      t.integer :statement_id
      
      t.timestamps
    end
  end
end
