class FillSlugs < ActiveRecord::Migration
  def change
    CarBrand.all.each{ |c| c.save! }
    District.all.each{ |c| c.save! }
    MetroStation.all.each{ |c| c.save! }
  end
end
