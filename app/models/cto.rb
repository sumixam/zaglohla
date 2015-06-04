class Cto < ActiveRecord::Base
  has_many   :photos, as: :imageable
  belongs_to :city
  belongs_to :administrator
  has_many :pay_per_hours
  has_many :cto_districts
  has_many :guarantee_ctos
  has_many :pricelists
  has_many :cto_shares
  has_many :equipment_ctos
  has_many :work_hours
  has_many :districts, through: :cto_districts
  has_many :cto_category_autos
  has_many :category_autos, through: :cto_category_autos
  has_many :cto_job_types
  has_many :job_types, through: :cto_job_types
  has_many :sub_job_type_ctos
  has_many :sub_job_types, through: :sub_job_type_ctos
  has_many :cto_services
  has_many :services, through: :cto_services
  has_many :cto_control_programms
  has_many :control_programms, through: :cto_control_programms
  has_many :cto_car_brands
  has_many :car_brands, through: :cto_car_brands
  has_many :cto_metro_stations
  has_many :metro_stations, through: :cto_metro_stations

  accepts_nested_attributes_for :cto_shares, allow_destroy: true
  accepts_nested_attributes_for :pricelists, allow_destroy: true
  accepts_nested_attributes_for :cto_districts, :allow_destroy => true
  accepts_nested_attributes_for :cto_category_autos, :allow_destroy => true
  accepts_nested_attributes_for :cto_job_types, :allow_destroy => true
  accepts_nested_attributes_for :sub_job_type_ctos, :allow_destroy => true
  accepts_nested_attributes_for :cto_services, :allow_destroy => true
  accepts_nested_attributes_for :cto_control_programms, :allow_destroy => true
  accepts_nested_attributes_for :cto_car_brands, :allow_destroy => true
  accepts_nested_attributes_for :guarantee_ctos, allow_destroy: true
  accepts_nested_attributes_for :equipment_ctos, allow_destroy: true
  accepts_nested_attributes_for :work_hours, allow_destroy: true
  accepts_nested_attributes_for :cto_metro_stations, allow_destroy: true

  store_accessor :brand_list, CategoryAuto.all.map{|ca| "ca_#{ca.id}".to_sym }

  letsrate_rateable "quality"

  include Tire::Model::Search
  include Tire::Model::Callbacks

  has_many :user_cto_favs

  after_save :recalc_rating

  has_attached_file :logo, styles: {
      medium: "175x147>",
      list:  "100x70>",
      thumb: "50x50>"
    }, default_url: "/images/ctos/:style.png",
    url: "/system/ctos/:attachment/:id/:style/:basename.:extension",
    path: ":rails_root/public/system/ctos/:attachment/:id/:style/:basename.:extension"

  mapping do
    indexes :id,  type: 'integer',         index: 'not_analyzed'
    indexes :name,         analyzer: 'snowball', boost: 100
    indexes :sanitized_name, analyzer: 'snowball', boost: 100
    indexes :description,  analyzer: 'snowball'
    indexes :city_id,      type: 'integer'
    indexes :districts,    type: 'string'
    indexes :districts_name, type: 'string'
    indexes :metro_stations,    type: 'string'
    indexes :metro_stations_name, type: 'string'
    indexes :adress
    indexes :brands, type: 'string'
    indexes :brands_name, type: 'string'
    indexes :category_autos, type: 'string'
    indexes :category_autos_name, type: 'string'
    indexes :job_types, type: 'string'
    indexes :job_types_name, type: 'string'
    indexes :sub_job_types, type: 'string'
    indexes :sub_job_types_name, type: 'string'
    indexes :services, type: 'string'
    indexes :services_name, type: 'string'
    indexes :manufacture_certificate, type: 'string'
    indexes :gov_certificate, type: 'string'
    indexes :any_certificate, type: 'string'
    indexes :show_on_site, type: 'string'
    indexes :photo_count, type: 'integer'
    indexes :response_count, type: 'integer'
    indexes :manufacture_certificate_list, type: 'string'
    indexes :expert_rating, type: 'integer'
    indexes :rating, type: 'integer'
  end

  def to_indexed_json
    {
      id: id,
      name: name,
      sanitized_name: I18n.with_locale(:ru){ name.parameterize }.gsub('an', 'aann'),
      description: description,
      city_id: city_id,
      districts: districts.map(&:id).uniq,
      districts_name: districts.map(&:name).uniq.join(" "),
      metro_stations: metro_stations.map(&:id).uniq,
      metro_stations_name: metro_stations.map(&:name).uniq.join(" "),
      adress: full_adress,
      brands: car_brands.map(&:id).uniq,
      brands_name: car_brands.map(&:name).uniq.join(" "),
      category_autos: category_autos.map(&:id).uniq,
      category_autos_name: category_autos.map(&:name).uniq.join(" "),
      job_types: job_types.map(&:id).uniq,
      job_types_name: job_types.map(&:name).uniq.join(" "),
      sub_job_types: sub_job_types.map(&:id).uniq,
      sub_job_types_name: sub_job_types.map(&:name).uniq.join(" "),
      services: services.map(&:id).uniq,
      services_name: services.map(&:name).uniq.join(" "),
      manufacture_certificate: (manufacture_certificate || false) ? "yes" : "no",
      gov_certificate: (gov_certificate || false) ? "yes" : "no",
      any_certificate: !category_autos.map{ |ca| (ca.car_brands.uniq & car_brands).count > 7}.any? ? "yes" : "no",
      show_on_site: (show_on_site || false) ? "yes" : "no",
      photo_count: photos.count,
      manufacture_certificate_list: (manufacture_certificate_list || "").split(",").map{|l| l.strip},
      response_count: 0,
      rating: rating || 0,
      expert_rating: expert_rating || 0,
      created_cto: created_at.to_i
    }.stringify_keys.to_json
  end

  def recalc_rating
    Cto
      .where(id: id)
      .update_all({expert_rating: User.where(cto_id: id, type: "Mechanic").pluck(:rating).map(&:to_i).sum})
  end

  def masters
    User.where(cto_id: id, type: "Mechanic")
  end

  def main_photo
    photos.where(main: true).first || photos.first || photos.new
  end

  def full_adress
    [adress_street, adress_buildng, adress_additional].compact.join(", ")
  end

  def payment_any?
    [payment_cash, payment_card, payment_bill].any?
  end

  def metro_stations_name
    metro_stations.map(&:name).shuffle.join(", ")
  end

  def sub_job_types_name
    sub_job_types.map(&:name).shuffle.join(", ")
  end

  def job_types_name
    job_types.map(&:name).shuffle.join(", ")
  end

  def brands_name
    car_brands.map(&:name).shuffle.join(", ")
  end

  def plain_payment
    pay = []
    pay << "Наличные" if payment_cash
    pay << "Банковские карты" if payment_card
    pay << "Безнал (для юрлиц)" if payment_bill
    pay.join(", ")
  end

  def update_brand_list
    category_autos.uniq.each do |ca|
      val = if ca.car_brands.map(&:id).uniq.sort == car_brands.joins(:car_brand_category_autos).where("car_brand_category_autos.category_auto_id=#{ca.id}").map(&:id).uniq.sort
        ["any"]
      else
        if (ca.car_brands.where(local_brand: true).uniq.count == car_brands.joins(:car_brand_category_autos).where("local_brand = ?", true).where("car_brand_category_autos.category_auto_id=#{ca.id}").uniq.count) && car_brands.joins(:car_brand_category_autos).where("local_brand = ? OR local_brand IS NULL", false).where("car_brand_category_autos.category_auto_id=#{ca.id}").uniq.count == 0
          t = ["native"]
        elsif (ca.car_brands.where("local_brand = ? OR local_brand IS NULL", false).uniq.count == car_brands.joins(:car_brand_category_autos).where("local_brand = ? OR local_brand IS NULL", false).where("car_brand_category_autos.category_auto_id=#{ca.id}").uniq.count) && car_brands.joins(:car_brand_category_autos).where("local_brand = ?", true).where("car_brand_category_autos.category_auto_id=#{ca.id}").uniq.count == 0
          t = ["foreighn"]
        elsif ca.car_brands.map(&:id).uniq.count - car_brands.joins(:car_brand_category_autos).where("car_brand_category_autos.category_auto_id=#{ca.id}").map(&:id).uniq.count < 5
          t = ["anyexpect"]
          CarBrand.where(id: (ca.car_brands.map(&:id).uniq - car_brands.joins(:car_brand_category_autos).where("car_brand_category_autos.category_auto_id=#{ca.id}").map(&:id).uniq)).each_with_index do |cb, index|
            t << cb.name
          end
          t.uniq
        else
          t = ["list"]
          (ca.car_brands.uniq & car_brands.uniq).sort_by(&:name).each do |cb|
            t << cb.name
          end
          t.uniq
        end
      end
      self.send("ca_#{ca.id}=", val)
    end
    self.save
  end

  def brand_list_item(caid)
    return unless send("ca_#{caid}").present?
    JSON.parse send("ca_#{caid}")
  end

  def certificate_any?
    [gov_certificate, manufacture_certificate].any?
  end

  def plain_certificate
    cert = []
    cert << "Государственная на вид деятельности" if gov_certificate
    cert << "От производителя: #{manufacture_certificate_list.split(",").join(", ")}" if manufacture_certificate
    cert.join(", ")
  end
end
