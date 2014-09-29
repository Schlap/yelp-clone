class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    Restaurant.create(params[:restaurant].permit(:name, :cuisine, :description))
    redirect_to restaurants_path
  end

end
