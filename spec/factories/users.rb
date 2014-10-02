FactoryGirl.define do
  factory :user do

    factory :ethel do
      email 'ethel@factorygirl.com'
      password 'f4k3p455w0rd'
    end

    factory :vincent do
      email 'vinc@factoryboy.com'
      password '12345678'
    end

    factory :ecomba do
      email 'ecomba@factoryboy.com'
      password 'password'
    end
  end
end