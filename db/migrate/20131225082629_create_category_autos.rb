class CreateCategoryAutos < ActiveRecord::Migration
  def change
    create_table :category_autos do |t|
      t.string :name

      t.timestamps
    end
  end
end
