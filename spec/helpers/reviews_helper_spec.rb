require 'rails_helper'

RSpec.describe ReviewsHelper, type: :helper do
  context 'star rating' do

    it 'does nothing for an invalid number' do
      expect(helper.star_rating('No ratings yet')).to eq 'No ratings yet'
    end

    it 'returns 5 black stars for 5' do
      expect(helper.star_rating(5)).to eq '★★★★★'
    end

    it 'returns 3 black stars and 2 white stars for 3' do
      expect(helper.star_rating(3)).to eq '★★★☆☆'
    end

    it 'rounds up to the nearest whole number' do
      expect(helper.star_rating(2.6)).to eq helper.star_rating(3)
    end

  end
end