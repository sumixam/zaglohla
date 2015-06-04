class CarBrandsController < ApplicationController
  def index
    if params[:category_auto].present?
      brands = CategoryAuto.where(id: params[:category_auto]).map{ |ca| ca.car_brands.order(:name)}.flatten.uniq
    else
      brands = CarBrand.order(:name).all
    end
    render json: brands
  end
end
