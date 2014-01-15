FactoryGirl.define do
  factory :event do
    longitude   48.8582
    latitude    2.2945
    name        { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(3) }
    date_start  { Time.now + 6.days }
    date_end    { date_start }
    address     { Faker::Address.street_address(include_secondary: true) }
    publicity   :public

    trait :with_tickets do
      after(:create) do | event, evaluator |
        10.times.each { event.tickets.create attributes_for(:ticket, {
            date_start: event.date_start - 6.days,
            date_end: event.date_start
          })
        }
        event.save!
      end
    end

    trait :expired do
      date_start { Time.now - 15.days }
      date_end { date_start - 5.days }
    end

    trait :available do
      date_start { Time.zone.now - 1.day }
      date_end { date_start + 2.days }
    end

    trait :unlisted do
      publicity :unlisted
    end

    trait :draft do
      name nil
      description nil
      date_end nil
      date_start nil
      address nil
      longitude 0.0
      latitude 0.0
    end
  end
end
