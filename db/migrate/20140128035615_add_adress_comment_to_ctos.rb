class AddAdressCommentToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :adress_comment, :string
  end
end
