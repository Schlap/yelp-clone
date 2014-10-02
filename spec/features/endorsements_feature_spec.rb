require 'rails_helper'

describe 'endorsing reviews' do

  before do
    kfc = create :kfc
    kfc.reviews.create(rating: 3, comment: "average")
    ethel = create :ethel
    login_as ethel, scope: :user
  end

  it 'can endorse a review updating the review endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse this review'
    expect(page).to have_content '1 endorsement'
  end

end