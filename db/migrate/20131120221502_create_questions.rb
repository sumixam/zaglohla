class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :topic
      t.text :body
      t.boolean :email_notification
      t.integer :user_id

      t.timestamps
    end
  end
end
