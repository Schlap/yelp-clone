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

    it 'submit restaurant information creates a new restaurant' do
      expect(Restaurant.count).to be 0
      visit '/restaurants'
      click_link "Add a restaurant"
      fill_in "Name", with: "Nandos"
      fill_in "Cuisine", with: "Portuguese"
      fill_in "Description", with: "Chicken"
      click_button 'Create Restaurant'
      expect(Restaurant.count).to be 1
      expect(page).to have_content "Nandos"
    end

  end


end