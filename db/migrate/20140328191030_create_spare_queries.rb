class CreateSpareQueries < ActiveRecord::Migration
  def change
    create_table :spare_queries do |t|
      t.string :term
      t.integer :attempts, default: 0

      t.timestamps
    end
  end
end
