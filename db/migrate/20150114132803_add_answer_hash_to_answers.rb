class AddAnswerHashToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :user_hash, :string
  end
end
