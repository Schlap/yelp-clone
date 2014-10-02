class ReviewsController < ApplicationController

  def new
    if user_signed_in?
      @restaurant = Restaurant.find(params[:restaurant_id])
      @review = Review.new
    else
      flash[:notice] = 'Please log in or sign up for an account.'
      redirect_to new_user_session_path
    end
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.reviews.create(params[:review].permit(:comment, :rating))
    redirect_to restaurants_path
  end

end
