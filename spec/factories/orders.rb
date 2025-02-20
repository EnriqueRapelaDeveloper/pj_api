FactoryBot.define do
  factory :order do
    status { 0 }
    total_price { 1000 }
    store
    
    trait :paid do
      status { 1 }
    end

    trait :cancelled do
      status { 3 }
    end
  end
end 