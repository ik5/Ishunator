class AddDescriptionToComplaintRecipients < ActiveRecord::Migration
  def change
    change_table(:complaint_recipients) do |t|
      t.string :description, :null => false
    end
  end
end
