class FillSlugs2 < ActiveRecord::Migration
  def change
    JobType.all.each{ |c| c.save! }
    SubJobType.all.each{ |c| c.save! }
  end
end
