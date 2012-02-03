class AddCommentField < ActiveRecord::Migration
  def up
    add_column(:complaints, :smoking_comment, :string)
  end

  def down
    remove_column(:complaints, :smoking_comment)
  end
end
