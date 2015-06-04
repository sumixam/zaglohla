class SparesController < ApplicationController

  def index
  end

  def show
    @term = params[:term]
    @spares = Spare.where(number: params[:number]).where(manufacture: params[:manufacture])
  end

  def search
    @term = params[:term]
    if @term.present?
      (SpareQuery.where(term: @term).first || SpareQuery.create(term: @term)).increment!(:attempts)
      @spares = Spare.search("#{@term.split(" ").map{|l| "#{l}*"}.join(" ")}", load: true).results
    else
      @spares = []
    end
    @spares_list = {}
    @spares.each do |s|
      if @spares_list["#{s.number}-#{s.manufacture}"].present?
        @spares_list["#{s.number}-#{s.manufacture}"][:price] << s.price
      else
        @spares_list["#{s.number}-#{s.manufacture}"] = {
          row: s,
          price: [s.price]
        }
      end
    end
  end

end
