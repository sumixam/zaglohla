class Admin::LoaderCtosController < Admin::ApplicationController
  before_action :set_admin_cto, only: [:show, :edit, :update, :destroy, :copy]
  layout "admin"

  # GET /admin/ctos
  # GET /admin/ctos.json
  def index
    @ctos = ::Cto.eager_load(:photos).order('ctos.id desc').all
  end

  # GET /admin/ctos/1
  # GET /admin/ctos/1.json
  def show
  end

  def copy
    new_cto = @cto.dup include: [:pay_per_hours, :cto_districts, :guarantee_ctos, :equipment_ctos, :work_hours, :cto_category_autos,
      :cto_job_types, :sub_job_type_ctos, :cto_services, :cto_control_programms, :cto_car_brands, :cto_metro_stations]
    new_cto.name = "#{@cto.name} Копия"
    new_cto.save
    redirect_to edit_admin_loader_cto_path(new_cto)
  end

  # GET /admin/ctos/new
  def new
    @cto = ::Cto.new
  end

  # GET /admin/ctos/1/edit
  def edit
  end

  def search
    opts = params
    search_str = I18n.with_locale(:ru){ opts[:q].parameterize }.gsub('an', 'aann')
    res = ::Cto.search do
      query do
        filtered do
          query { string "sanitized_name:#{search_str}*", default_operator: 'AND' }
        end
      end
      size 20
    end.results
    render json: { results: res.map{|e| {id: e.id, text: e.name } } }
  end

  # POST /admin/ctos
  # POST /admin/ctos.json
  def create
    @cto = ::Cto.new(admin_cto_params)

    respond_to do |format|
      if @cto.save
        @cto.update_brand_list
        format.html { redirect_to admin_loader_ctos_path, notice: 'Cto was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cto }
      else
        format.html { render action: 'new' }
        format.json { render json: @cto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/ctos/1
  # PATCH/PUT /admin/ctos/1.json
  def update
    cleanup_cto
    respond_to do |format|
      if @cto.update(admin_cto_params)
        @cto.update_brand_list
        format.html { redirect_to admin_loader_ctos_path, notice: 'Cto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/ctos/1
  # DELETE /admin/ctos/1.json
  def destroy
    @cto.destroy
    respond_to do |format|
      format.html { redirect_to admin_loader_ctos_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_cto
      @cto = ::Cto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_cto_params
      params.require(:cto).permit(:name, :description, :adress_street, :start_from_year, :city_id,
        :payment_cash, :payment_card, :payment_bill, :show_on_site, :administrator_id,
        :adress_buildng, :adress_additional, :site, :email, :gov_certificate,
        :manufacture_certificate, :phone, :additional_phone_1, :additional_phone_2,
        :additional_phone_3, :work_time, :other_job_types, :manufacture_certificate_list,
        :lat, :lon, :work_with_other_brands, :cto_adress_street, :adress_buildng,
        :adress_comment, :vk_page, :official_diler, :cto_pricelist, :rating,
        :guarantee, :sign_on_time, :boxsize, :sale_percent, :sale_comment, :other_control_programm,
        :intresting_to_work, :contact_person, cto_districts_attributes: [:district_id],
        cto_category_autos_attributes: [:category_auto_id], cto_job_types_attributes: [:job_type_id],
        cto_services_attributes: [:service_id], cto_control_programms_attributes: [:control_programm_id],
        work_hours_attributes: [:weekday_start, :time_start, :weekday_finish, :time_finish],
        guarantee_ctos_attributes: [:length, :comment], equipment_ctos_attributes: [:mark, :title],
        sub_job_type_ctos_attributes: [:sub_job_type_id], cto_metro_stations_attributes: [:metro_station_id],
        cto_car_brands_attributes: [:car_brand_id], pricelists_attributes: [:comment, :description, :price, :checked_at],
        cto_shares_attributes: [:description, :from_date, :to_date, :anytime])
    end

    def cleanup_cto
      @cto.cto_control_programms.destroy_all
      @cto.cto_services.destroy_all
      @cto.cto_districts.destroy_all
      @cto.work_hours.destroy_all
      @cto.guarantee_ctos.destroy_all
      @cto.equipment_ctos.destroy_all
      @cto.sub_job_type_ctos.destroy_all
      @cto.cto_job_types.destroy_all
      @cto.cto_metro_stations.destroy_all
      @cto.cto_category_autos.destroy_all
      @cto.cto_car_brands.destroy_all
      @cto.pricelists.destroy_all
      @cto.cto_shares.destroy_all
    end
end
