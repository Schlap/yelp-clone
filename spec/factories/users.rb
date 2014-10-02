FactoryGirl.define do
  factory :user do

    factory :ethel do
      email 'ethel@factorygirl.com'
      username 'ch2ch3'
      password 'f4k3p455w0rd'
    end

    factory :vincent do
      email 'vinc@factoryboy.com'
      username 'kikrahau'
      password '12345678'
    end
    
  end
end