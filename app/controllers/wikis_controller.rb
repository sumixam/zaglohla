class WikisController < ApplicationController

  def index
    @page = Page.where(parent_id: 0).first
  end

  def show
    @page = Page.where(id: params[:id], visible: true).first
  end

  def search
    @term = params[:term]
    if @term.present?
      @pages = Page.search("#{@term.split(" ").map{|l| "#{l}*"}.join(" ")}", load: true).results
    else
      @pages = []
    end
  end

end
