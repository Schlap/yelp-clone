require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is not valid without a username' do
    user = User.new(email: 'ethel@gmail.com')
    expect(user).to have(2).error_on(:username)
  end

  it 'must have a unique username' do
    User.create(email: 'ethel@gmail.com', username: 'ch2ch3')
    user = User.new(email: 'ethel.ng@gmail.com', username: 'ch2ch3')
    expect(user).to have(1).error_on(:username)
  end
  
end