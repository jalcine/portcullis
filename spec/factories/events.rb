FactoryGirl.define do
  factory :event do
    longitude   48.8582
    latitude    2.2945
    password    nil
    name        Faker::Lorem.sentence
    description Faker::Lorem.paragraph(3)
    date_start  { Time.now + 6.days }
    date_end    { date_start }
    address     Faker::Address.street_address(include_secondary: true)
    publicity   { :public }

    trait :with_tickets do
      after(:create) do | event, evaluator |
        10.times.each { event.tickets << FactoryGirl.create(:ticket) }
        event.save!
      end
    end

    trait :expired do
      date_start { Time.now - 5.days }
    end

    trait :unlisted do
      publicity { :unlisted }
    end

    trait :draft do
      name nil
      description nil
      password nil
      date_end nil
      date_start nil
      address nil
      longitude 0.0
      latitude 0.0
    end
  end
end
