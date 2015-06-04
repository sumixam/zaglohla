class Admin::SparesController < Admin::ApplicationController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /admin/users
  # GET /admin/users.json
  def index
    @files = []
    wdir = Rails.env.production? ? "/home/zaglohla/csvs" : "#{Rails.root}/data/search"

    if params[:truncate].present?
      Spare.destroy_all
      redirect_to "/admin/spares"
      return
    end

    if params[:delete].present?
      File.delete(params[:delete]) if File.exist?(params[:delete])
      redirect_to "/admin/spares"
      return
    end

    Dir.glob("#{wdir}/*.csv").each do |f|
      @files << f
    end

    if params[:parse].present?
      require 'csv'
      @files.each do |f|
        begin
          CSV.foreach(f, headers: true, col_sep: ";", header_converters: :symbol) do |row|
            if !row[:manufacture].blank? || !row[:number].blank?
              manuf = row[:manufacture].blank? ? "NONE" : row[:manufacture].strip
              num   = row[:number].blank? ? "000000" : row[:number]
              if Spare.where(manufacture: manuf, number: num, title: row[:title], price: row[:price], seller: row[:seller], avalaible: row[:avalaible]).count == 0
                Spare.create(manufacture: manuf, number: num, title: row[:title], price: row[:price], seller: row[:seller], avalaible: row[:avalaible])
              end
            end
          end
        rescue NoMethodError
          redirect_to "/admin/spares", flash: {error: "Ошибочный формат файла: #{f} (лишние `;` в конце заголовков). Очистите таблицу и запустите импорт заново."}
          return
        end
      end
      redirect_to "/admin/spares"
      return
    end
  end

  def upload
    uploaded_io = params[:new_csv]
    wdir = Rails.env.production? ? "/home/zaglohla/csvs" : "#{Rails.root}/data/search"
    File.open("#{wdir}/#{uploaded_io.original_filename}", 'wb') do |file|
      file.write(uploaded_io.read)
    end
    redirect_to "/admin/spares"
  end
end
