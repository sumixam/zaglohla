class FillUserLevels < ActiveRecord::Migration
  def change
    UserLevel.create(name: "Новичок")
    UserLevel.create(name: "Специалист")
    UserLevel.create(name: "Проффесионал")
  end
end
