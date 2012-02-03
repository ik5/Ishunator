class ChangeCommentToText < ActiveRecord::Migration
  def up
    change_column(:complaints, :smoking_comment, :text)
  end

  def down
    change_column(:complaints, :smoking_comment, :string)
  end
end
