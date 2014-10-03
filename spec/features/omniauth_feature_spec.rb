require 'rails_helper'

describe 'Omniauth' do

  before do 
    visit "/users/auth/facebook"
  end

  it 'signing in with facebook' do
    expect(page).to have_content('Welcome, Ethel Ng')
  end

  it 'should successfully create a user' do
    expect(User.count).to eq 1
  end

  it 'should redirect the user to the restaurant index page' do
    expect(page.current_path).to eq '/'
  end

end