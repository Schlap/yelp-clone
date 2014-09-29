class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def new
  end

  def create
    Restaurant.create(name: params[:name], cuisine: params[:cuisine], description: params[:description])
    redirect_to '/restaurants'
  end

end
