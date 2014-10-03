class EndorsementsController < ApplicationController

  include ActionView::Helpers::TextHelper

  def create
    review = Review.find(params[:review_id])
    if user_signed_in? && review.endorsements.find_by(user_id: current_user.id).nil?
      endorsement = review.endorsements.create(user_id: current_user.id)
      render json: { new_endorsements_count: pluralize(review.endorsements.count, 'endorsement'), notice: '' }
    elsif user_signed_in?
      render json: { new_endorsements_count: pluralize(review.endorsements.count, 'endorsement'), notice: 'Sorry, you can only endorse a review once.' }
    else
      render json: { new_endorsements_count: pluralize(review.endorsements.count, 'endorsement'), notice: '' }
    end
  end

  def destroy
    review = Review.find(params[:review_id])
    endorsement = Endorsement.find(params[:id])
    endorsement.destroy
    render json: { new_endorsements_count: pluralize(review.endorsements.count, 'endorsement'), notice: '' }
  end

end
