class Admin::PhotosController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]

  def index
    render json: Cto.find(params[:id]).photos.map{ |p|
      { id: p.id, pic: p.pic.url(:thumb), main: p.main }
    }
  end

  def create
    @photo = Photo.new(coerce(params)[:photo]).save
    render json: @photo
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.imageable.photos.update_all main: false
    @photo.main = true
    @photo.save!
    render nothing: true
  end

  def destroy
    Photo.find(params[:id]).destroy
    render nothing: true
  end

  private

  def coerce(params)
    if params[:photo].nil?
      h = Hash.new
      h[:photo] = Hash.new
      h[:photo][:imageable_id] = params[:imageable_id]
      h[:photo][:imageable_type] = params[:imageable_type]
      h[:photo][:pic] = params[:Filedata]
      h
    else
      params
    end
  end
end
