class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    if user_signed_in? && @restaurant.reviews.find_by(user_id: current_user.id).nil?
      @review = @restaurant.reviews.new
    elsif user_signed_in?
      flash[:notice] = 'Sorry, you can only review a restaurant once.'
      redirect_to restaurants_path
    else
      flash[:notice] = 'Please log in or sign up for an account.'
      redirect_to new_user_session_path
    end
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(params[:review].permit(:comment, :rating))
    @review.user_id = current_user.id
    if @review.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

end
