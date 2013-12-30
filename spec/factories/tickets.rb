FactoryGirl.define do
  factory :ticket do
    event
    name { Faker::Lorem.words(3).join '' }
    description { Faker::Lorem.paragraphs(4).join '. ' }
    date_start { DateTime.now + (Random.rand(5).to_i).days }
    date_end { date_start + (Random.rand(5).to_i).days }
    quantity { Random.rand(400).to_i  } 
    price { Random.rand(500).to_f }
    max_quantity { (quantity / 30).to_i }

    trait :free do
      price 0.00
    end

    trait :priced do
      price { Random.rand(150).to_i }
    end

    trait :donation do
      price { Random.rand(150).to_i * -1 }
    end

    trait :expired do
      event { create :event, :expired }
      date_start { 5.days.ago }
      date_end { 2.days.ago }
    end

    trait :available do
      date_start { 5.days.ago }
    end
  end
end
