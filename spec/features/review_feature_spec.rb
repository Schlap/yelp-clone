require 'rails_helper'

describe 'reviewing' do

  before do
    Restaurant.create(name: 'KFC')
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

end