FactoryBot.define do
  factory :address do
    street { Faker::Address.street_address }
    number { Faker::Number.between(from: 1, to: 1000) }
    letter { 'A' }
    postal_code { Faker::Address.zip_code }
    country { Faker::Address.country }
    city { Faker::Address.city }
  end
end 