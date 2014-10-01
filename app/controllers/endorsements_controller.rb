class EndorsementsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @review.endorsements.create
    redirect_to restaurants_path
    # render json: { new_endorsement_count: @review.endorsements.count }
  end

end
