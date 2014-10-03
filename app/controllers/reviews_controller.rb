class ReviewsController < ApplicationController

  before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    if @restaurant.reviews.find_by(user_id: current_user.id).nil?
      @review = @restaurant.reviews.new
    else
      flash[:notice] = 'Sorry, you can only review a restaurant once.'
      redirect_to restaurants_path
    end
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(params[:review].permit(:comment, :rating))
    @review.user_id = current_user.id
    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      render 'new'
    end
  end

  def edit
    @review = Review.find(params[:id])
    @restaurant = Restaurant.find(@review.restaurant_id)
  end

  def update
    @review = Review.find(params[:id])
    @restaurant = Restaurant.find(@review.restaurant_id)
    @review.update(params[:review].permit(:comment, :rating))
    redirect_to restaurant_path(@restaurant)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = 'Review deleted'
    redirect_to restaurants_path
  end

end
