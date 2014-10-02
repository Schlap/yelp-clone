require 'rails_helper'
require 'timecop'

describe 'Yelp reviews' do

  before do
    create :kfc
    ethel = create :ethel
    login_as ethel, scope: :user
  end

  def leave_review(comment, rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Comment", with: comment
    select rating, from: 'Rating'
    click_button 'Submit Review'
  end

  it 'can be left using the form' do
    leave_review("so so", '3')
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content("so so")
  end

  it 'are used to calculate an average rating for the restaurant' do
    leave_review("so so", '3')
    leave_review("so so", '1')
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content("Average rating: ★★☆☆☆")
  end

  it 'are shown with a relative timestamp' do
    Timecop.freeze(Time.now)
    leave_review("so so", '3')
    Timecop.travel(1)
    expect(page).to have_content("less than a minute ago")
  end

  it 'have an author associated with them' do
    leave_review("so so", '3')
    expect(page).to have_content("posted by ethel@factorygirl.com")
  end

end