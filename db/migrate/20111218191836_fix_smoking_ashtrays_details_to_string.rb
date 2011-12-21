class FixSmokingAshtraysDetailsToString < ActiveRecord::Migration
  def up
    change_column(:complaints, :smoking_ashtrays_details, :string, :null => true, :default => nil)
  end

  def down
    change_column(:complaints, :smoking_ashtrays_details, :boolean, :null => false, :default => false)
  end
end
