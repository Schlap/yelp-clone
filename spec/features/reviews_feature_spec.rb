require 'rails_helper'
require 'timecop'

describe 'reviewing' do

  before do
    create :kfc
  end

  def leave_review(comment, rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Comment", with: comment
    select rating, from: 'Rating'
    click_button 'Submit Review'
  end

  it 'allows users to leave reviews using the form' do
    leave_review("so so", '3')
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content("so so")
  end

  it 'displays the average rating for each restaurant' do
    leave_review("so so", '3')
    leave_review("so so", '1')
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content("Average rating: ★★☆☆☆")
  end

  it 'displays the relative timestamp of the review' do
    Timecop.freeze(Time.now)
    leave_review("so so", '3')
    Timecop.travel(1)
    expect(page).to have_content("less than a minute ago")
  end

end