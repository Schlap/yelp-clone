class EndorsementsController < ApplicationController

  include ActionView::Helpers::TextHelper

  def create
    review = Review.find(params[:review_id])
    review.endorsements.create
    render json: { new_endorsements_count: pluralize(review.endorsements.count, 'endorsement') }
  end

end
