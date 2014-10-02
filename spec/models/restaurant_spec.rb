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

  describe 'average rating' do
    context 'no reviews' do
      it 'returns N/A' do
        restaurant = Restaurant.create(name: 'The Ivy')
        expect(restaurant.average_rating).to eq 'No ratings yet'
      end
    end

    context 'with reviews' do
      it 'returns the rating from one review if there is only one review' do
        restaurant = Restaurant.create(name: 'The Ivy')
        restaurant.reviews.create(rating: 4)
        expect(restaurant.average_rating).to eq 4
      end

      it 'returns the average of 2 ratings' do
        restaurant = Restaurant.create(name: 'The Ivy')
        restaurant.reviews.create(rating: 3)
        restaurant.reviews.create(rating: 5)
        expect(restaurant.average_rating).to eq 4
      end

    end
  end
  
end