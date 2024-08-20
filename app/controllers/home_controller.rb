class HomeController < ApplicationController
  def index
    @resources = Resource.all
  end

  def search
    if params[:query].present?
      @resources = Resource.where("title ILIKE ?", "%#{params[:query]}%")
    else
      @resources = Resource.all
    end
    render :index
  end
end
