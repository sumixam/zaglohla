class AddSlugToMetroJobTypes < ActiveRecord::Migration
  def change
    add_column :job_types, :slug, :string
  end
end
