class MakeIdentificationFieldsNotNull < ActiveRecord::Migration
  def up
    change_column(:complaints, :statement_full_name, :string, :null => false)
    change_column(:complaints, :statement_email, :string, :null => false)
    change_column(:complaints, :statement_id, :string, :null => false)
    add_column(:complaints, :statement_agreement, :boolean, :default => false, :null => false)
    remove_column(:complaints, :complaint_sender_name)
  end

  def down
    change_column(:complaints, :statement_full_name, :null => true)
    change_column(:complaints, :statement_email, :null => true)
    change_column(:complaints, :statement_id, :null => true)
    remove_column(:complaints, :statement_agreement)
    add_column(:complaints, :complaint_sender_name, :string, :null => true)
  end
end
