class CreateConfirmationForComplaints < ActiveRecord::Migration
  def up
    change_table :complaints do |t|
      t.boolean :confirmed, :null => false, :default => false
      t.string :confirmation_token, :null => false, :length => 16
    end
    
    add_index :complaints, :confirmation_token, :unique => true
  end

  def down
    remove_column :complaints, :confirmed
    remove_column :complaints, :confirmation_token
    
    remove_index :complaints, :confirmation_token
  end
end
