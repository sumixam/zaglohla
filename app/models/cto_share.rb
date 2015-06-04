class CtoShare < ActiveRecord::Base
  belongs_to :cto

  def from_date_formated
    from_date.to_date.strftime("%d-%m-%Y")
  rescue
    from_date
  end

  def to_date_formated
    to_date.to_date.strftime("%d-%m-%Y")
  rescue
    to_date
  end
end
