class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def new
    if user_signed_in?
      @restaurant = Restaurant.new
    else
      flash[:notice] = 'Please log in or sign up for an account.'
      redirect_to new_user_session_path
    end
  end

  def create
    @restaurant = Restaurant.new(params[:restaurant].permit(:name, :cuisine, :description))
    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      render 'new'
    end
  end

  def edit
    if user_signed_in?
      @restaurant = Restaurant.find(params[:id])
    else
      flash[:notice] = 'Please log in or sign up for an account.'
      redirect_to new_user_session_path
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(params[:restaurant].permit(:name, :cuisine, :description))
    redirect_to restaurants_path
  end

  def destroy
    if user_signed_in?
      @restaurant = Restaurant.find(params[:id])
      @restaurant.destroy
      flash[:notice] = "Restaurant deleted"
      redirect_to restaurants_path
    else
      flash[:notice] = 'Please log in or sign up for an account.'
      redirect_to new_user_session_path
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

end
