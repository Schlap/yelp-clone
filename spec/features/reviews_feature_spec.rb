require 'rails_helper'
require 'timecop'
require_relative './helpers/application_spec_helper'

describe 'Yelp reviews' do

  before do
    create :pret
    ethel = create :ethel
    login_as ethel, scope: :user
  end

  it 'can be left using the form' do
    leave_review("so so", '3')
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content("so so")
  end

  it 'are displayed with their ratings' do
    leave_review("Fantastic", '5')
    expect(page).to have_content("★★★★★ Fantastic")
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