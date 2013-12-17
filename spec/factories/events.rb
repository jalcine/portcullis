FactoryGirl.define do
  factory :event do
    longitude   48.8582
    latitude    2.2945
    access_key  nil
    name        Faker::Lorem.sentence
    description Faker::Lorem.paragraph(3)
    date_start  Time.now
    date_end    { date_start }
    address     Faker::Address.street_address(include_secondary: true)

    trait :with_tickets do
      after(:create) do | event, evaluator |
        10.times.each { event.tickets << FactoryGirl.create(:ticket) }
      end
    end

    factory :protected_event do
      access_key Faker::Lorem.sentence
    end
    trait :expired do
      date_start { Time.now - 5.days }
    end
  end
end
