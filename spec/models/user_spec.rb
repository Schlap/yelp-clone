require 'rails_helper'

RSpec.describe User, type: :model do
  
  before do
    create :ethel
  end

  it 'is not valid without a username' do
    user = User.new(email: 'ethel@gmail.com')
    expect(user).to have(1).error_on(:username)
  end

  it 'must have a unique username' do
    user = User.new(email: 'ethel@gmail.com', username: 'ch2ch3')
    expect(user).to have(1).error_on(:username)
  end
  
end