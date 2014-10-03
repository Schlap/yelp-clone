require 'rails_helper'
require_relative './helpers/application_spec_helper'
require 'launchy'

describe 'Yelp users' do

  context 'without an account' do

    it 'can register for one' do
      visit '/restaurants'
      click_link 'Register'
      fill_in 'Email', with: 'ethel@gmail.com'
      fill_in 'Username', with: 'ch2ch3'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'
      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end

    it 'can use omniauth to sign in' do
      visit '/restaurants'
      click_link 'Register'
      expect(page).to have_link 'Sign in with Facebook'
    end

  end

  context 'with an account' do

    before do
      @ethel = create :ethel
    end

    it 'can sign in with their account' do
      visit '/restaurants'
      click_link 'Login'
      fill_in 'Login', with: 'ethel@factorygirl.com'
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
      @pret = create :pret
      ethel = create :ethel
      login_as ethel, scope: :user
      leave_review "Great!", '★★★★★'
      logout(:user)
    end

    it 'adding a restaurant' do
      visit '/restaurants'
      expect(page).not_to have_link 'Add a restaurant'
      visit '/restaurants/new'
      expect(page).to have_content 'Please log in or sign up for an account.'
    end

    it 'editing a restaurant' do
      visit '/restaurants'
      expect(page).not_to have_link 'Edit Pret'
      visit "/restaurants/#{@pret.id}/edit"
      expect(page).to have_content 'Please log in or sign up for an account.'
    end

    it 'deleting a restaurant' do
      visit '/restaurants'
      expect(page).not_to have_link 'Delete Pret'

    end

    it 'reviewing a restaurant' do
      visit '/restaurants'
      expect(page).not_to have_link 'Review Pret'
      visit "/restaurants/#{@pret.id}/reviews/new"
      expect(page).to have_content 'Please log in or sign up for an account.'
    end

    it 'endorsing a review', js: true do
      visit '/restaurants'
      expect(page).not_to have_link 'Endorse'
    end

  end

  context 'can only access some features once' do

    before do
      create :pret
      @pret = Restaurant.first
      ethel = create :ethel
      login_as ethel, scope: :user
      leave_review "Amazing!", '★★★★★'
    end

    it 'reviewing a restaurant' do
      click_link 'Review Pret'
      expect(page).to have_content 'Sorry, you can only review a restaurant once.'
    end

    it 'endorsing a review', js: true do
      vincent = create :vincent
      login_as vincent, scope: :user
      visit "/restaurants/#{@pret.id}"
      click_link 'Endorse'
      expect(page).not_to have_link 'Endorse'
      expect(page).to have_content '1 endorsement'
    end

  end

  context 'restrictions:' do

    before do
      create :pret
      @pret = Restaurant.first
      @ethel = create :ethel
      login_as @ethel, scope: :user
      leave_review "Super!", '★★★★★'
      vincent = create :vincent
      login_as vincent, scope: :user
      leave_review "Shit!", '★'
      login_as @ethel, scope: :user
      visit "/restaurants/#{@pret.id}"
    end

    it 'cannot endorse their own reviews', js: true do
      within '.review:first-of-type' do
        expect(page).not_to have_link 'Endorse'
      end
      within '.review:last-of-type' do
        expect(page).to have_link 'Endorse'
      end
    end

    it 'can only edit their own reviews' do
      within '.review:first-of-type' do
        expect(page).to have_link 'Edit review'
      end
      within '.review:last-of-type' do
        expect(page).not_to have_link 'Edit review'
      end
    end

    it 'can only delete their own reviews' do
      within '.review:first-of-type' do
        expect(page).to have_link 'Delete review'
      end
      within '.review:last-of-type' do
        expect(page).not_to have_link 'Delete review'
      end
    end

  end

end