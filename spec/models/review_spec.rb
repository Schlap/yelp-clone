require 'rails_helper'

RSpec.describe Review, type: :model do
  it 'is not valid without a rating' do
    review = Review.new(comment: 'Average')
    expect(review).to have(2).error_on(:rating)
  end

  it 'is not valid if the rating is not within 1 to 5' do
    review = Review.new(comment: 'Average', rating: 6)
    expect(review).to have(1).error_on(:rating)
  end
  
end