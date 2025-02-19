# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    sku { Faker::Alphanumeric.alphanumeric(number: 10).upcase }
    kind { Product.kinds.values.sample }
    price { Faker::Commerce.price(range: 0.01..1000.0) }
    description { Faker::Lorem.paragraph }
  end
end 