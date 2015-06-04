class AddSlugToMetroSubJobTypes < ActiveRecord::Migration
  def change
    add_column :sub_job_types, :slug, :string
  end
end
