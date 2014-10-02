class EndorsementsController < ApplicationController

  include ActionView::Helpers::TextHelper

  def create
    review = Review.find(params[:review_id])
    if user_signed_in? && review.user_id == current_user.id
      render json: { new_endorsements_count: pluralize(review.endorsements.count, 'endorsement'), notice: 'Endorsing your own review? Not the best idea.' }
    elsif user_signed_in? && review.endorsements.find_by(user_id: current_user.id).nil?
      review.endorsements.create(user_id: current_user.id)
      render json: { new_endorsements_count: pluralize(review.endorsements.count, 'endorsement'), notice: '' }
    elsif user_signed_in?
      render json: { new_endorsements_count: pluralize(review.endorsements.count, 'endorsement'), notice: 'Sorry, you can only endorse a review once.' }
    else
      render json: { new_endorsements_count: pluralize(review.endorsements.count, 'endorsement'), notice: 'Please log in or sign up for an account to endorse a review.' }
    end
  end

end
