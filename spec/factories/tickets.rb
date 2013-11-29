FactoryGirl.define do
  factory :ticket do
    event
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end
end
