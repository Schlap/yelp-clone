require 'rails_helper'
require 'launchy'

describe 'endorsing reviews' do

  before do
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(rating: 3, comment: "average")
  end

  it 'can endorse a review updating the review endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse this review'
    expect(page).to have_content '1 endorsement'
  end

end