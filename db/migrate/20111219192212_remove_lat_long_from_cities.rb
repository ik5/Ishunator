class RemoveLatLongFromCities < ActiveRecord::Migration
  def up
    remove_column :cities, :longitude
    remove_column :cities, :latitude
  end

  def down
    add_column :cities, :longitude, :float, :null => false
    add_column :cities, :latitude, :float, :null => false
  end
end
