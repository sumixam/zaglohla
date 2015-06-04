class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body
      t.integer :question_id
      t.integer :user_id
      t.boolean :email_notification

      t.timestamps
    end
  end
end
