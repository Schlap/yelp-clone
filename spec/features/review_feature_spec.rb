require 'rails_helper'

describe 'reviewing' do

  before do
    Restaurant.create(name: 'KFC')
  end

  it 'allows users to leave reviews using the form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Comment", with: "so so"
    select '3', from: "Rating"
    click_button 'Submit Review'
    expect(page).to have_content("so so")
  end

end