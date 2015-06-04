class AddAclToAdministrators < ActiveRecord::Migration
  def change
    add_column :administrators, :acl, :integer, default: 0
  end
end
