class AllowNullCityIdInRecipients < ActiveRecord::Migration
  def up
    change_column(:complaint_recipients, :city_id, :integer, :null => true)
  end

  def down
    change_column(:complaint_recipients, :city_id, :integer, :null => false)
  end
end
