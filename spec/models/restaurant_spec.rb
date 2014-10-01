require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it 'is not valid with a name of less than 3 characters' do
    restaurant = Restaurant.new(name: 'XY')
    expect(restaurant).not_to be_valid
    expect(restaurant).to have(1).error_on(:name)
  end

  it 'is not valid unless it is a unique name' do
    Restaurant.create(name: "The Ivy")
    restaurant = Restaurant.new(name: "The Ivy")
    expect(restaurant).to have(1).error_on(:name)
  end
  
end