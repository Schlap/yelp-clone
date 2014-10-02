FactoryGirl.define do
  factory :restaurant do

    factory :kfc do
      name 'KFC'
      cuisine 'Fast food'
      description 'Fried chicken'
    end

    factory :pret do
      name 'Pret'
      cuisine 'Fast organic food'
      description 'Good for you and everyone involved'
    end

  end
end