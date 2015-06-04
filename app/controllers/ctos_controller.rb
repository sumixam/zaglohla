class CtosController < ApplicationController
  before_filter :set_cto, only: [:show, :edit, :update]

  def index
    if params[:brand_slug].present?
      @ctos = []
      @brand = CarBrand.find_by_slug(params[:brand_slug])
    end

    if params[:job_slug].present?
      @ctos = []
      r = params[:job_slug].split("_")
      @job_type = JobType.find_by_slug(r[1]) if r[0] == "jt"
      @sub_job_type = SubJobType.find_by_slug(r[1]) if r[0] == "sjt"
    end

    if params[:location_slug].present?
      @ctos = []
      r = params[:location_slug].split("_")
      @metro_station = MetroStation.find_by_slug(r[1]) if r[0] == "m"
      @district = District.find_by_slug(r[1]) if r[0] == "d"
    end

    if !@brand.present? && !@job_type.present? && !@sub_job_type.present?
      @ctos = Cto.where(show_on_site: true).order('created_at DESC').limit(10)
    end
  end

  def show
    unless @cto.show_on_site
      raise ActionController::RoutingError.new('Cto Not Found')
    end
  end

  def direct_search
    opts = params
    search_str = I18n.with_locale(:ru){ opts[:q].parameterize }.gsub('-', ' ').gsub('an ', 'aann ')
    res = Cto.search do
      query do
        filtered do
          query { string "#{search_str.split(" ").map{|l| "sanitized_name:#{l}*"}.join(" OR ")}" }
          filter :terms, { show_on_site: ["yes"] }
        end
      end
      size 20
    end.results
    render json: { results: res.select{ |c|
      I18n.with_locale(:ru){ c.name.parameterize }.include?(I18n.with_locale(:ru){ opts[:q].parameterize })
    }.map{|e| {id: e.id, text: e.name } } }
  end

  def search
    opts = params
    if params[:location].present?
      metros = []
      districts = []
      params[:location].each do |e|
        r = e.split("-")
        metros << r[1] if r[0] == "m"
        districts << r[1] if r[0] == "d"
      end
    end
    if params[:job_type].present?
      job_types = []
      sub_job_types = []
      params[:job_type].each do |e|
        r = e.split("-")
        job_types << r[1] if r[0] == "j"
        sub_job_types << r[1] if r[0] == "sj"
      end
    end
    if params[:cert].present?
      opts[:cert] = "gov" if params[:cert] == "gov"
      unless params[:cert] == 0
        opts[:cert] = params[:cert]
      end
    end
    opts.delete(:cert) if opts[:cert] == "0"
    page = params[:page].to_i || 1

    res = Cto.search do
      query do
        filtered do
          query { string "manufacture_certificate_list:#{opts[:cert]}*" } if (!opts[:cert].blank? && opts[:cert] != "gov")
          query { string "*" } unless (!opts[:cert].blank? && opts[:cert] != "gov")
          filter :terms, { category_autos: [opts[:category_auto]] } if opts[:category_auto].present? && opts[:brand].present? && opts[:brand] != "0"
          filter :terms, { brands: [opts[:brand]] } if opts[:brand].present? && opts[:brand] != "0"
          filter :terms, { job_types: job_types, execution: "and" } if job_types.present? && job_types.size > 0
          filter :terms, { sub_job_types: sub_job_types, execution: "and" } if sub_job_types.present? && sub_job_types.size > 0
          filter :terms, { metro_stations: metros, execution: "or" } if metros.present? && metros.size > 0
          filter :terms, { districts: districts, execution: "or" } if districts.present? && districts.size > 0
          filter :terms, { any_certificate: ["yes"] } if opts[:spec] == "1"
          filter :terms, { gov_certificate: ["yes"] } if opts[:cert] == "gov"
          filter :terms, { show_on_site: ["yes"] }
        end
      end
      size 20
      from ((page - 1) * 20)
      sort do
        by :rating, 'desc'
        by :expert_rating, 'desc'
        by :created_cto, 'desc'
      end
    end

    res_count = Tire.search(Cto.index.name, search_type: 'count') {
          query { string "manufacture_certificate_list:#{opts[:cert]}*" } if opts[:cert].present? && opts[:cert] != "gov"
          query { string "*" } unless opts[:cert].present? && opts[:cert] != "gov"
          filter :terms, { category_autos: [opts[:category_auto]] } if opts[:category_auto].present? && opts[:brand].present? && opts[:brand] != "0"
          filter :terms, { brands: [opts[:brand]] } if opts[:brand].present? && opts[:brand] != "0"
          filter :terms, { job_types: job_types, execution: "and" } if job_types.present? && job_types.size > 0
          filter :terms, { sub_job_types: sub_job_types, execution: "and" } if sub_job_types.present? && sub_job_types.size > 0
          filter :terms, { metro_stations: metros, execution: "or" } if metros.present? && metros.size > 0
          filter :terms, { districts: districts, execution: "or" } if districts.present? && districts.size > 0
          filter :terms, { any_certificate: ["yes"] } if opts[:spec] == "1"
          filter :terms, { gov_certificate: ["yes"] } if opts[:cert] == "gov"
          filter :terms, { show_on_site: ["yes"] }
    }.results.total

    render json: { count: res_count, result: res.results.map{ |r| r.load.to_hash.merge(
      photo: r.load.main_photo.pic.url(:thumb),
      metro_stations_name: r.load.metro_stations_name,
      job_types_name: r.load.job_types_name,
      sub_job_types_name: r.load.sub_job_types_name,
      brands_name: r.load.brands_name,
      rating: r.load.average("quality") ? r.load.average("quality").avg : 0
    ) }, page: page }
  end

  private

  def set_cto
    @cto = Cto.find params[:id]
  end

end
