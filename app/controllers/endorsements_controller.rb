class EndorsementsController < ApplicationController

  include ActionView::Helpers::TextHelper

  def create
    review = Review.find(params[:review_id])
    if user_signed_in?
      review.endorsements.create
      render json: { new_endorsements_count: pluralize(review.endorsements.count, 'endorsement'), notice: '' }
    else
      render json: { new_endorsements_count: pluralize(review.endorsements.count, 'endorsement'), notice: 'Please log in or sign up for an account to endorse a review.' }
    end
  end

end
