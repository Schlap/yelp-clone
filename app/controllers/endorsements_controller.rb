class EndorsementsController < ApplicationController

  include ActionView::Helpers::TextHelper

  def create
    review = Review.find(params[:review_id])
    endorsement = review.endorsements.create(user_id: current_user.id)
    render json: { new_endorsements_count: pluralize(review.endorsements.count, 'endorsement'), replacement_link: "<a href='/reviews/#{review.id}/endorsements/#{endorsement.id}' class='unendorse'>Unendorse</a>" }
  end

  def destroy
    review = Review.find(params[:review_id])
    endorsement = Endorsement.find(params[:id])
    endorsement.destroy
    render json: { new_endorsements_count: pluralize(review.endorsements.count, 'endorsement'), replacement_link: "<a href='/reviews/#{review.id}/endorsements' class='endorse'>Endorse</a>" }
  end

end
