FactoryBot.define do
  factory :store do
    name { Faker::Company.name }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    
    association :address
  end
end 