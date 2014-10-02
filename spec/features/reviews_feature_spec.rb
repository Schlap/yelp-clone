require 'rails_helper'
require 'timecop'
require_relative './helpers/application_spec_helper'

describe 'Yelp reviews' do

  before do
    create :pret
    @restaurant = Restaurant.first
    ethel = create :ethel
    login_as ethel, scope: :user
  end

  it 'can be left using the form' do
    leave_review "so so", '★★★'
    expect(current_path).to eq '/restaurants'
    visit "/restaurants/#{@restaurant.id}"
    expect(page).to have_content "so so"
  end

  it 'are displayed with their ratings' do
    leave_review("Fantastic", '★★★★★')
    visit "/restaurants/#{@restaurant.id}"
    expect(page).to have_content "★★★★★ Fantastic"
  end

  it 'are used to calculate an average rating for the restaurant' do
    leave_review "so so", '★★★'
    vincent = create :vincent
    login_as vincent, scope: :user
    leave_review "terrible", '★'
    expect(page).to have_content "Average rating: ★★☆☆☆"
  end

  it 'are shown with a relative timestamp' do
    Timecop.freeze(Time.now)
    leave_review "so so", '★★★'
    Timecop.travel(1)
    visit "/restaurants/#{@restaurant.id}"
    expect(page).to have_content "less than a minute ago"
  end

  it 'have an author associated with them' do
    leave_review "so so", '★★★'
    visit "/restaurants/#{@restaurant.id}"
    expect(page).to have_content "posted by ethel@factorygirl.com"
  end

  it 'can be edited' do
    leave_review "so so", '★★★'
    visit "/restaurants/#{@restaurant.id}"
    click_link 'Edit review'
    fill_in 'Comment', with: 'Spectacular!'
    select '★★★★★', from: 'Rating'
    click_button 'Submit Review'
    visit "/restaurants/#{@restaurant.id}"
    expect(page).to have_content 'Spectacular!'
  end

  it 'can be deleted' do
    leave_review "so so", '★★★'
    visit "/restaurants/#{@restaurant.id}"
    click_link 'Delete review'
    expect(page).not_to have_content 'so so'
    expect(page).to have_content 'Review deleted'
  end

end