class AddEmailsFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notify_news, :boolean, default: true
    add_column :users, :notify_answers, :boolean, default: true
    add_column :users, :notify_questions, :boolean, default: true
    add_column :users, :notify_responses, :boolean, default: true
  end
end
