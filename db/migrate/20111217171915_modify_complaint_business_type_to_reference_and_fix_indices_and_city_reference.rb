class ModifyComplaintBusinessTypeToReferenceAndFixIndicesAndCityReference < ActiveRecord::Migration
  def up
    remove_column :complaints, :business_type
    change_column :complaints, :city_id, :integer, :null => false
    change_table :complaints do |t|
      t.references :business_type, :null => false
    end
    
    add_index :complaints, :city_id
    add_index :complaints, :business_type_id
  end

  def down
    remove_column :complaints, :business_type_id
    change_column :complaints, :city_id, :integer, :null => true
    change_table :complaints do |t|
      t.integer :business_type, :null => false
    end
    
    remove_index :complaints, :city_id
    remove_index :complaints, :business_type_id
  end
end
