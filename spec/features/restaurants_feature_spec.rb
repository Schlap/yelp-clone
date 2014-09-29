require 'rails_helper'

describe 'restaurants' do

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    it 'should display restaurants' do
      visit '/restaurants' 
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end

  end

  context 'no restaurants added' do
    it 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content "No restaurants"
      expect(page).to have_link "Add a restaurant"
    end
  end

  context 'adding a restaurant' do
    it 'clicking the link brings you to a form input' do
      visit '/restaurants'
      click_link "Add a restaurant"
      expect(page.current_path).to eq "/restaurants/new"
      expect(page).to have_selector("input[name='name']")
      expect(page).to have_selector("input[name='cuisine']")
      expect(page).to have_selector("input[name='description']")
    end
  end

end