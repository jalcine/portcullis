FactoryGirl.define do
  factory :event do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    date_start { DateTime.now + 20.days }
    date_end { date_start }
    user
  end
end
