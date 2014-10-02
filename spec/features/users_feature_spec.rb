require 'rails_helper'

describe 'Yelp users' do

  context 'without an account' do

    it 'can register for one' do
      visit '/restaurants'
      click_link 'Register'
      fill_in 'Email', with: 'ethel@gmail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'
      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end

  end

  context 'with an account' do

    before do
      @ethel = create :ethel
    end

    it 'can sign in with their account' do
      visit '/restaurants'
      click_link 'Login'
      fill_in 'Email', with: 'ethel@factorygirl.com'
      fill_in 'Password', with: 'f4k3p455w0rd'
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully.'
    end

    it 'can sign out while being logged in' do
      login_as @ethel, scope: :user
      visit '/restaurants'
      click_link 'Logout'
      expect(page).to have_content 'Signed out successfully.'
    end

  end

  context 'can only access some features when logged in' do

    before do
      create :pret
    end

    it 'adding a restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(page).to have_content 'Please log in or sign up for an account.'
    end

    it 'editing a restaurant' do
      visit '/restaurants'
      click_link 'Edit Pret'
      expect(page).to have_content 'Please log in or sign up for an account.'
    end

  end

end