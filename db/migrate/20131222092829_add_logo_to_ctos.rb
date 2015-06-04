class AddLogoToCtos < ActiveRecord::Migration
  def self.up
    add_attachment :ctos, :logo
  end

  def self.down
    remove_attachment :ctos, :logo
  end
end
