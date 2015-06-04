class UserHashToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :user_hash, :string
  end
end
