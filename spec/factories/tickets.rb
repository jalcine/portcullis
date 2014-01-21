FactoryGirl.define do
  factory :ticket do
    event
    name { Faker::Lorem.words(3).join '' }
    description { Faker::Lorem.paragraphs(4).join '. ' }
    date_start { Time.zone.now + (Random.rand(5).to_i).days }
    date_end { date_start + (Random.rand(5).to_i).days }
    quantity { Random.rand(4000).to_i  } 
    price { Random.rand(10000).to_i  }
    max_quantity { (quantity / 30).to_i }

    trait :free do
      price 0.00
    end

    trait :priced do
      price Random.rand(7500)
    end

    trait :donation do
      price Random.rand(7500) * -1
    end

    trait :expired do
      event { create :event, :expired }
      date_start { 5.days.ago }
      date_end { 2.days.ago }
    end

    trait :available do
      date_start { Time.now - 1.day }
      date_end { date_start + 2.weeks }
    end

    factory :available_ticket, traits: [ :available, :priced ]
    factory :expired_ticket,  traits: [ :expired, :priced ]
  end
end
