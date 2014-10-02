require 'rails_helper'
require_relative './helpers/application_spec_helper'

describe 'displaying restaurants' do

  context 'when no restaurants have been added' do
    it 'displays a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content "No restaurants"
      expect(page).to have_link "Add a restaurant"
    end
  end

  context 'when restaurants have been added' do
    before do
      create :kfc
    end

    it 'displays restaurants and their info' do
      visit '/restaurants' 
      expect(page).to have_content 'KFC'
      expect(page).to have_content 'Fast food'
      expect(page).to have_content 'Fried chicken'
      expect(page).not_to have_content 'No restaurants yet'
    end
  end

end

describe 'creating restaurants' do

  before do
    ethel = create :ethel
    login_as ethel, scope: :user
  end

  context 'a valid restaurant' do
    it 'prompts the user to fill in a form and displays the new restaurant' do
      expect(Restaurant.count).to be 0
      add_restaurant 'Nandos', 'Portuguese', 'Chicken'
      expect(Restaurant.count).to be 1
      expect(page.current_path).to eq "/restaurants/#{Restaurant.first.id}"
      expect(page).to have_content "Nandos"
    end
  end

  context 'an invalid restaurant' do
    it 'rejected if name is too short' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      add_restaurant 'KF'
      expect(page).not_to have_css 'h2', text: "KF"
      expect(page).to have_content "Name is too short (minimum is 3 characters)"
    end
  end

end

describe 'editing restaurants' do

  before do
    create :kfc
    ethel = create :ethel
    login_as ethel, scope: :user
  end

  it 'allows the user to edit a restaurant' do
    visit '/restaurants'
    click_link 'Edit KFC'
    fill_in "Name", with: "PFC"
    fill_in "Cuisine", with: "Fast food"
    click_button "Update Restaurant"
    expect(page).to have_content "PFC"
    expect(page.current_path).to eq '/restaurants'
  end

end

describe 'deleting restaurants' do

  before do
    create :kfc
    ethel = create :ethel
    login_as ethel, scope: :user
  end

  it 'allows the user to delete a restaurant' do
    visit '/restaurants'
    click_link 'Delete KFC'
    expect(page).not_to have_content "KFC"
    expect(page).to have_content "Restaurant deleted"
  end

end

describe 'showing individual restaurants' do

  before do
    create :pret
    ethel = create :ethel
    login_as ethel, scope: :user
    leave_review 'Breathtaking!', '★★★★★'
  end

  it 'clicking the restaurant name brings the user to a page with more info' do
    visit '/restaurants'
    click_link 'Pret'
    expect(page).to have_content "Fast organic food"
    expect(page).to have_content "Good for you and everyone involved"
    expect(page).to have_content 'Average rating: ★★★★★'
    expect(page).to have_content 'Breathtaking!'
  end

end