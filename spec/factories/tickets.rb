FactoryGirl.define do
  factory :ticket do
    name { Faker::Lorem.words(3).join '' }
    description { Faker::Lorem.paragraphs(4).join '. ' }
    date_start { DateTime.now + (Random.rand(5).to_i).days }
    date_end { date_start + (Random.rand(5).to_i).days }
    quantity { Random.rand(400).to_i  } 
    price { Random.rand(500).to_f }
    max_quantity { (quantity / 30).to_i }

    trait :free do
      price 0.00
      donation false
    end
  end
end
