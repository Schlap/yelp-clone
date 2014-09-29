class RestaurantsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => :create

  def index
    @restaurants = Restaurant.all
  end

  def new
  end

  def create
    Restaurant.create(name: params[:name], cuisine: params[:cuisine], description: params[:description])
    redirect_to action: "index"
  end

end
