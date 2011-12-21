class RemoveSmokingSignsHiddenBoolField < ActiveRecord::Migration
  def up
    remove_column(:complaints, :smoking_signs_hidden)
  end

  def down
    add_column(:complaints, :smoking_signs_hidden, :boolean, :null => false, :default => false)
  end
end
