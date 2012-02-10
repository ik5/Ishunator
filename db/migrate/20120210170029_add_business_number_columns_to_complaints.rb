class AddBusinessNumberColumnsToComplaints < ActiveRecord::Migration
  def change
    change_table(:complaints) do |t|
      t.string :private_company_number
      t.string :business_number
    end
  end
end
