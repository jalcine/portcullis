FactoryGirl.define do
  factory :event do
    user
    longitude   { 48.8582 }
    latitude    { 2.2945 }
    name        { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(3) }
    date_start  { Time.now }
    date_end    { date_start }
    address     { Faker::Address.street_address include_secondary: true }

    trait :with_tickets do
      after(:create) do | event, evaluator |
        10.times.each { event.tickets << FactoryGirl.create(:ticket) }
      end
    end
  end
end
