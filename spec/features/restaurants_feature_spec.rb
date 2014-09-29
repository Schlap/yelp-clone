require 'rails_helper'

describe 'displaying restaurants' do

  context 'no restaurants added' do
    it 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content "No restaurants"
      expect(page).to have_link "Add a restaurant"
    end
  end

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

end

describe 'creating restaurants' do

  it 'prompts the user to fill in a form and displays the new restaurant' do
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

describe 'editing restaurants' do

  before do
    Restaurant.create(name: 'KFC')
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
    Restaurant.create(name: 'Nandos')
  end

  it 'allows the user to delete a restaurant' do
    visit '/restaurants'
    click_link 'Delete Nandos'
    expect(page).not_to have_content("Nandos")
    expect(page).to have_content("Restaurant deleted")
  end

end