class Pricelist < ActiveRecord::Base
  belongs_to :cto

  def checked_at_formated
    checked_at.to_date.strftime("%d-%m-%Y")
  rescue
    checked_at
  end
end
